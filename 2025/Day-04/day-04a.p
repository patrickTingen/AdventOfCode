/* AoC 2025 day 04a 
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER 
  FIELD cVal AS CHARACTER
  INDEX idxPrim iCol iRow. 
  
DEFINE VARIABLE iNumCols AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iNumRows AS INTEGER NO-UNDO INITIAL ?.
  
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


DEFINE VARIABLE xx     AS INTEGER     NO-UNDO.
DEFINE VARIABLE yy     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRolls AS INTEGER     NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER     NO-UNDO.

ETIME(YES).
loadGrid("data.txt").

FOR EACH ttGrid WHERE ttGrid.cVal = "@":

  iRolls = 0.

  DO xx = -1 TO 1:
    DO yy = -1 TO 1:
      IF xx = 0 AND yy = 0 THEN NEXT. 
      IF pos(ttGrid.iCol + xx, ttGrid.iRow + yy) = "@" THEN iRolls = iRolls + 1.
    END.
  END.

  IF iRolls < 4 THEN iTotal = iTotal + 1.
END.

MESSAGE iTotal "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

// ---------------------------
// Information 
// ---------------------------
// 1346 in 763 ms
// ---------------------------
