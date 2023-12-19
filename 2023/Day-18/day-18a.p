/* AoC 2023 day 18a 
 */ 
DEFINE VARIABLE iMinCol AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iMinRow AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iMaxCol AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iMaxRow AS INTEGER NO-UNDO INITIAL ?.

DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER 
  FIELD cVal AS CHARACTER
  INDEX idxPrim iCol iRow. 
 
FUNCTION setPos RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  , pcVal AS CHARACTER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iCol = piCol AND bGrid.iRow = piRow NO-ERROR.
  IF NOT AVAILABLE bGrid THEN 
  DO:
    CREATE bGrid.
    ASSIGN bGrid.iCol = piCol
           bGrid.iRow = piRow
           bGrid.cVal = pcVal.
           
    /* Set borders of grid */
    IF iMinCol = ? OR piCol < iMinCol THEN iMinCol = piCol.
    IF iMaxCol = ? OR piCol > iMaxCol THEN iMaxCol = piCol.
    IF iMinRow = ? OR piRow < iMinRow THEN iMinRow = piRow.             
    IF iMaxRow = ? OR piRow > iMaxRow THEN iMaxRow = piRow.             
  END.

  bGrid.cVal = pcVal.
  RETURN TRUE.
END FUNCTION.


FUNCTION pos RETURNS CHARACTER
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iCol = piCol AND bGrid.iRow = piRow NO-ERROR.
  RETURN (IF AVAILABLE bGrid THEN bGrid.cVal ELSE " ").
END FUNCTION. /* pos */


PROCEDURE loadGrid:
  /* Load data and build the grid
  */
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE cData  AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iCol   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cDir   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cPrev  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j      AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iSteps AS INTEGER   NO-UNDO.

  /* Repeat first step, otherwise the very first character
  ** will not be the right corner-character and counting
  ** nr of squares will miss a line
  */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(cData,"~n") + "~n" + ENTRY(1,cData,"~n").

  /* Draw outline */
  DO i = 1 TO NUM-ENTRIES(cData,"~n"):

    cDir = ENTRY(1, ENTRY(i,cData,"~n"), " ").
    iSteps = INTEGER(ENTRY(2, ENTRY(i,cData,"~n"), " ")).

    DO j = 1 TO iSteps:

      CASE cPrev + cDir:
        WHEN "RR" THEN setPos(iCol,iRow,"-").
        WHEN "LL" THEN setPos(iCol,iRow,"-").
        WHEN "DD" THEN setPos(iCol,iRow,"|").
        WHEN "UU" THEN setPos(iCol,iRow,"|").
        WHEN "RU" THEN setPos(iCol,iRow,"J").
        WHEN "RD" THEN setPos(iCol,iRow,"7").
        WHEN "LU" THEN setPos(iCol,iRow,"L").
        WHEN "LD" THEN setPos(iCol,iRow,"F").
        WHEN "UL" THEN setPos(iCol,iRow,"7").
        WHEN "UR" THEN setPos(iCol,iRow,"F").
        WHEN "DL" THEN setPos(iCol,iRow,"J").
        WHEN "DR" THEN setPos(iCol,iRow,"L").
      END CASE.
      
      CASE cDir:
        WHEN "R" THEN iCol = iCol + 1.
        WHEN "L" THEN iCol = iCol - 1.
        WHEN "D" THEN iRow = iRow + 1.
        WHEN "U" THEN iRow = iRow - 1.
      END CASE.

      cPrev = cDir.
    END.
  END.
END PROCEDURE. 


PROCEDURE calcSurface:
  DEFINE VARIABLE iCol    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iCount  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cPos    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lInside AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE iDir    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cDebug  AS LONGCHAR  NO-UNDO.
       
  DO iRow = iMinRow TO iMaxRow:
    
    lInside = FALSE.

    DO iCol = iMinCol TO iMaxCol:
      cPos = pos(iCol,iRow).
      
      CASE cPos:
        WHEN "F" THEN iDir = 1.
        WHEN "|" THEN lInside = NOT lInside.
        WHEN "-" THEN .
        WHEN "L" THEN iDir = -1.
        WHEN "J" THEN IF iDir = 1 THEN lInside = NOT lInside.
        WHEN "7" THEN IF iDir = -1 THEN lInside = NOT lInside.
        WHEN " " THEN IF lInside THEN iCount = iCount + 1.
      END CASE.

      /* count the wall itself as well */
      IF INDEX("F|-LJ7",cPos) > 0 THEN iCount = iCount + 1.     
      cDebug = cDebug + cPos.
    END.
    cDebug = cDebug + "~n".
  END.

  /* 56923 */
  COPY-LOB cDebug TO FILE "debug.txt".
  MESSAGE iCount VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END PROCEDURE. 


RUN loadGrid("data.txt").
RUN calcSurface.







