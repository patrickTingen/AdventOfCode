/* AoC 2024 day 06b - much faster
 */ 
DEFINE TEMP-TABLE ttRoute NO-UNDO
  FIELD iCol AS INTEGER
  FIELD iRow AS INTEGER
  INDEX idxPrim iCol iRow.

DEFINE TEMP-TABLE ttGrid 
  FIELD iCol AS INTEGER
  FIELD iRow AS INTEGER
  FIELD lBounced AS LOGICAL EXTENT 4
  INDEX idxHor iRow iCol
  INDEX idxVer iCol iRow.

DEFINE VARIABLE giPartA    AS INTEGER  NO-UNDO.
DEFINE VARIABLE giPartB    AS INTEGER  NO-UNDO.
DEFINE VARIABLE giStartCol AS INTEGER  NO-UNDO.
DEFINE VARIABLE giStartRow AS INTEGER  NO-UNDO.
DEFINE VARIABLE giNumCols  AS INTEGER  NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows  AS INTEGER  NO-UNDO INITIAL ?.
DEFINE VARIABLE glStuck    AS LOGICAL  NO-UNDO.

PROCEDURE addRoute:
  DEFINE INPUT PARAMETER piCol AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER piRow AS INTEGER NO-UNDO.
  DEFINE BUFFER btRoute FOR ttRoute. 

  IF NOT CAN-FIND(btRoute WHERE btRoute.iCol = piCol AND btRoute.iRow = piRow) THEN 
  DO:
    CREATE btRoute.
    ASSIGN btRoute.iCol = piCol 
           btRoute.iRow = piRow.
  END.
END PROCEDURE. 

PROCEDURE readMap:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iCol  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cVal  AS CHARACTER NO-UNDO.

  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(TRIM(cData),'~r',''),'~n').

  /* Max dimensions of playing field */
  giNumCols = LENGTH(ENTRY(1,cData,'~n')).
  giNumRows = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO giNumRows:
    DO iCol = 1 TO giNumCols:

      cVal = SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1).
      CASE cVal:
        WHEN "#" THEN
        DO:
          FIND bGrid WHERE bGrid.iCol = iCol AND bGrid.iRow = iRow NO-ERROR.
          IF NOT AVAILABLE bGrid THEN 
          DO:
            CREATE bGrid.
            ASSIGN bGrid.iCol = iCol
                   bGrid.iRow = iRow.
          END.
        END.
      
        WHEN "^" THEN 
          ASSIGN giStartCol = iCol
                 giStartRow = iRow.
      END CASE. 
    END.
  END.
END PROCEDURE. /* readMap */


PROCEDURE walkRoute:
  DEFINE INPUT  PARAMETER pcPart  AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER plStuck AS LOGICAL   NO-UNDO.

  DEFINE VARIABLE iDir      AS INTEGER NO-UNDO INITIAL 1.
  DEFINE VARIABLE iOldCol   AS INTEGER NO-UNDO.
  DEFINE VARIABLE iOldRow   AS INTEGER NO-UNDO.
  DEFINE VARIABLE iGuardCol AS INTEGER NO-UNDO.
  DEFINE VARIABLE iGuardRow AS INTEGER NO-UNDO.
  DEFINE VARIABLE i         AS INTEGER NO-UNDO.

  DEFINE BUFFER btGrid  FOR ttGrid.
  DEFINE BUFFER btRoute FOR ttRoute.

  /* init guard */
  iGuardCol = giStartCol.
  iGuardRow = giStartRow.

  REPEAT:
    iOldCol = iGuardCol.
    iOldRow = iGuardRow.

    CASE iDir:
      WHEN 1 THEN FIND LAST  btGrid USE-INDEX idxVer WHERE btGrid.iCol = iGuardCol AND btGrid.iRow < iGuardRow NO-ERROR.
      WHEN 2 THEN FIND FIRST btGrid USE-INDEX idxHor WHERE btGrid.iCol > iGuardCol AND btGrid.iRow = iGuardRow NO-ERROR.
      WHEN 3 THEN FIND FIRST btGrid USE-INDEX idxVer WHERE btGrid.iCol = iGuardCol AND btGrid.iRow > iGuardRow NO-ERROR.
      WHEN 4 THEN FIND LAST  btGrid USE-INDEX idxHor WHERE btGrid.iCol < iGuardCol AND btGrid.iRow = iGuardRow NO-ERROR.
    END CASE.

    /* Update guard position: next to the obstacle 
    ** if no obstacle, then place guard at the edge of the map
    */
    CASE iDir:
      WHEN 1 THEN iGuardRow = (IF AVAILABLE btGrid THEN btGrid.iRow + 1 ELSE 1).
      WHEN 2 THEN iGuardCol = (IF AVAILABLE btGrid THEN btGrid.iCol - 1 ELSE giNumCols).
      WHEN 3 THEN iGuardRow = (IF AVAILABLE btGrid THEN btGrid.iRow - 1 ELSE giNumRows).
      WHEN 4 THEN iGuardCol = (IF AVAILABLE btGrid THEN btGrid.iCol + 1 ELSE 1).
    END CASE.
    
    /* Remember route: Mark skipped cells as visited */
    IF pcPart = "A" THEN 
    DO:
      DO i = MIN(iOldCol,iGuardCol) TO MAX(iOldCol,iGuardCol):
        RUN addRoute(i,iGuardRow).
      END.
      
      DO i = MIN(iOldRow,iGuardRow) TO MAX(iOldRow,iGuardRow):
        RUN addRoute(iGuardCol,i).
      END.
    END. /* A */

    IF pcPart = "B" AND AVAILABLE btGrid THEN 
    DO:
      IF btGrid.lBounced[iDir] = TRUE THEN 
      DO:
        plStuck = TRUE.
        RETURN.
      END.

      btGrid.lBounced[iDir] = TRUE.
    END. /* B */

    /* About to walk off the map? */
    IF NOT AVAILABLE btGrid 
      THEN RETURN. 
      ELSE iDir = (iDir MOD 4) + 1. /* turn right */
  END.
END PROCEDURE. /* walkRoute */

/* Init */
ETIME(YES).
RUN readMap("data.txt").

/* Part A */
RUN walkRoute("A", OUTPUT glStuck).
FOR EACH ttRoute: giPartA = giPartA + 1. END.

/* Part B */
FOR EACH ttRoute TRANSACTION:

  /* do not overwrite the guard's starting position */
  IF ttRoute.iCol = giStartCol AND ttRoute.iRow = giStartRow THEN NEXT.

  /* Create a temporary obstacle and test the route again */
  CREATE ttGrid.
  BUFFER-COPY ttRoute TO ttGrid.
  RUN walkRoute("B",OUTPUT glStuck).
  IF glStuck THEN giPartB = giPartB + 1.

  UNDO. /* delete temporary obstacle */
END.

MESSAGE
  'A:' giPartA SKIP
  'B:' giPartB "in" ETIME "ms" /* 1562 in 16043 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


