/* AoC 2023 day 21a 
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol   AS INTEGER 
  FIELD iRow   AS INTEGER 
  FIELD cVal   AS CHARACTER
  FIELD iSteps AS INTEGER
  INDEX idxPrim iCol iRow. 
  
DEFINE TEMP-TABLE ttTodo NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER.

DEFINE VARIABLE iNumCols  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iNumRows  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE i         AS INTEGER NO-UNDO.
DEFINE VARIABLE j         AS INTEGER NO-UNDO.
DEFINE VARIABLE iDist     AS INTEGER NO-UNDO.
DEFINE VARIABLE iAnswer   AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumSteps AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumTodo  AS INTEGER NO-UNDO.
  
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
           
    /* Might need to adjust dimensions */
    IF iNumCols = ? OR piCol > iNumCols THEN iNumCols = piCol.
    IF iNumRows = ? OR piRow > iNumRows THEN iNumRows = piRow.             
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
  RETURN (IF NOT AVAILABLE bGrid THEN "?" ELSE bGrid.cVal). 
  
END FUNCTION. /* pos */


FUNCTION loadGrid RETURNS LOGICAL 
  ( pcFile AS CHARACTER 
  ): 
  DEFINE VARIABLE cData  AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iCol     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cVal   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iStart AS INTEGER   NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iNumCols = LENGTH(ENTRY(1,cData,'~n')).
  iNumRows = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO iNumRows:
    DO iCol = 1 TO iNumCols:
      cVal = SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1).
      setPos(iCol, iRow, cVal).
    END.
  END.
END FUNCTION. /* loadGrid */


FUNCTION getPartialGrid RETURNS CHARACTER
  ( piFromX AS INTEGER
  , piFromY AS INTEGER
  , piToX   AS INTEGER
  , piToY   AS INTEGER
  ): 
  DEFINE VARIABLE iCol    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cGrid AS LONGCHAR NO-UNDO.

  DO iRow = MIN(piFromY,piToY) TO MAX(piFromY,piToY):
    DO iCol = MIN(piFromX,piToX) TO MAX(piFromX,piToX):
      cGrid = cGrid + pos(iCol,iRow).
    END.
    cGrid = cGrid + "~n".
  END.

  RETURN STRING(cGrid).
END FUNCTION. /* getPartialGrid */


FUNCTION getGrid RETURNS CHARACTER
  ( ): 
  RETURN getPartialGrid(1, 1, iNumCols, iNumRows).
END FUNCTION. /* getGrid */


FUNCTION addStep RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):    
  DEFINE BUFFER bTodo FOR ttTodo.
  
  FIND bTodo WHERE bTodo.iCol = piCol AND bTodo.iRow = piRow NO-ERROR.
  IF NOT AVAILABLE bTodo THEN 
  DO:
    CREATE bTodo.
    ASSIGN bTodo.iCol = piCol
           bTodo.iRow = piRow.
  END.
END FUNCTION.


loadGrid("data.txt").
iNumSteps = 64.

FIND ttGrid WHERE ttGrid.cVal = "S".
addStep(ttGrid.iCol,ttGrid.iRow).

REPEAT:
  FIND FIRST ttTodo NO-ERROR.
  IF NOT AVAILABLE ttTodo THEN LEAVE.

  /* Debug info */
  IF ETIME > 100 THEN 
  DO:
    HIDE MESSAGE NO-PAUSE.
    MESSAGE iNumTodo '/' ttTodo.iCol ttTodo.iRow. 
    ETIME(YES).
  END.
  PROCESS EVENTS. 

  FIND ttGrid WHERE ttGrid.iCol = ttTodo.iCol AND ttGrid.iRow = ttTodo.iRow NO-ERROR.
  iDist = ttGrid.iSteps.

  DO i = -1 TO 1:
    DO j = -1 TO 1:
      IF i = 0 AND j = 0 THEN NEXT.
      IF i <> 0 AND j <> 0 THEN NEXT.

      FIND ttGrid WHERE ttGrid.iCol = ttTodo.iCol + i AND ttGrid.iRow = ttTodo.iRow + j NO-ERROR.
      IF NOT AVAILABLE ttGrid OR ttGrid.cVal = "#" OR ttGrid.iSteps > 0 THEN NEXT.
      ttGrid.iSteps = iDist + 1.

      setPos(ttGrid.iCol, ttGrid.iRow,STRING(ttGrid.iSteps)).
      IF ttGrid.iSteps < iNumSteps THEN 
      DO:
        iNumTodo = iNumTodo + 1.
        addStep(ttGrid.iCol, ttGrid.iRow).
      END.
    END.
  END.

  iNumTodo = iNumTodo - 1.
  DELETE ttTodo.
END.

/* If you are 63 steps away, you can also do a step back and land on a tile
** that is 62 steps away from your start position. Likewise, you can do 2 steps
** back from tile nr 62. Your total nr of steps will still be 64 but you end on 
** tile nr 60. You can continue this until tile nr 32 where you do 32 steps back
** and come back on your starting position. 
*/
DO i = iNumSteps TO (iNumSteps / 2) + 1 BY -1:
  FOR EACH ttGrid WHERE ttGrid.iStep = i - (iNumSteps - i):
    iAnswer = iAnswer + 1.
  END.
END.

MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

