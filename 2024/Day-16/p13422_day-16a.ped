/* AoC 2024 day 16a 
 */ 
DEFINE VARIABLE gcStart AS CHARACTER NO-UNDO.
DEFINE VARIABLE gcExit  AS CHARACTER NO-UNDO.
DEFINE VARIABLE giScore AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE gcPath  AS CHARACTER NO-UNDO.
DEFINE VARIABLE gcRoute AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD cId  AS CHARACTER
  FIELD iCol AS INTEGER /* x-pos    */
  FIELD iRow AS INTEGER /* y-pos    */
  FIELD cVal AS CHARACTER
  INDEX iPrim cId
  INDEX iPos iCol iRow. 

PAUSE 0 BEFORE-HIDE. 

RUN readData("data.txt").
RUN findExit(gcStart, gcStart, "E", "E", 0).
MESSAGE "Shortest path is" giScore VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

DEFINE VARIABLE i AS INTEGER   NO-UNDO.
DO i = 1 TO NUM-ENTRIES(gcPath):
  FIND ttLoc WHERE ttLoc.cId = ENTRY(i,gcPath).
  ASSIGN ttLoc.cVal = 'o'.
END.

DEFINE VARIABLE cGrid AS CHARACTER NO-UNDO.
FOR EACH ttLoc BREAK BY ttLoc.iRow BY ttLoc.iCol:
  cGrid = cGrid + ttLoc.cVal.
  IF LAST-OF(ttLoc.iRow) THEN cGrid = cGrid + "~n".
END.
MESSAGE cGrid SKIP gcRoute VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

PROCEDURE findExit:
  DEFINE INPUT PARAMETER pcId    AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcPath  AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcDir   AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcRoute AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piScore AS INTEGER   NO-UNDO.

  DEFINE BUFFER bThis  FOR ttLoc.
  DEFINE BUFFER bOther FOR ttLoc.
  DEFINE VARIABLE cDir AS CHARACTER NO-UNDO.

  FIND bThis WHERE bThis.cId = pcId.

  /* Found exit? */
  IF bThis.cId = gcExit THEN 
  DO:
    IF giScore = ? OR piScore < giScore THEN 
    DO:
      giScore = piScore.
      gcPath  = pcPath.
      gcRoute = pcRoute.
      DISPLAY giScore LENGTH(pcRoute) WITH DOWN. DOWN. 
    END.

    RETURN.
  END.

  /* Examine the neighbours */
  FOR EACH bOther
    WHERE (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow - 1) // N
       OR (bOther.iCol = bThis.iCol + 1 AND bOther.iRow = bThis.iRow    ) // E
       OR (bOther.iCol = bThis.iCol - 1 AND bOther.iRow = bThis.iRow    ) // W
       OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow + 1) // S
     :

    IF bOther.cVal = "#" THEN NEXT. // wall
    IF LOOKUP(bOther.cId, pcPath) > 0 THEN NEXT. // visited

    /* Change direction? */
    IF (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow - 1) THEN cDir = "N". 
    IF (bOther.iCol = bThis.iCol + 1 AND bOther.iRow = bThis.iRow    ) THEN cDir = "E". 
    IF (bOther.iCol = bThis.iCol - 1 AND bOther.iRow = bThis.iRow    ) THEN cDir = "W". 
    IF (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow + 1) THEN cDir = "S". 

    RUN findExit
      ( bOther.cId
      , SUBSTITUTE("&1,&2", pcPath,bOther.cId)
      , cDir
      , SUBSTITUTE("&1,&2", pcRoute,cDir)
      , (IF cDir <> pcDir THEN piScore + 1001 ELSE piScore + 1)
      ).
  END.

END PROCEDURE. /* findExit */


PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').

  EMPTY TEMP-TABLE ttLoc. 

  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:

      iNr = iNr + 1.
      CREATE bLoc.
      ASSIGN 
        bLoc.cId  = STRING(iNr)
        bLoc.iCol = iX 
        bLoc.iRow = iY 
        bLoc.cVal = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).

      CASE bLoc.cVal :
        WHEN 'S' THEN ASSIGN gcStart = bLoc.cId bLoc.cVal = ".".
        WHEN 'E' THEN ASSIGN gcExit  = bLoc.cId bLoc.cVal = ".".
      END CASE.

    END. /* iX */
  END. /* iY */

END PROCEDURE. /* readData */

