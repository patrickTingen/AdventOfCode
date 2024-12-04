/* AoC 2024 day 04b 
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol  AS INTEGER 
  FIELD iRow  AS INTEGER 
  FIELD cVal  AS CHARACTER
  FIELD lUsed AS LOGICAL 
  INDEX idxPrim iCol iRow. 
  
DEFINE VARIABLE giNumCols AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows AS INTEGER NO-UNDO INITIAL ?.
  
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
  DEFINE VARIABLE cData AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE iCol  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER  NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giNumCols = LENGTH(ENTRY(1,cData,'~n')).
  giNumRows = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO giNumRows:
    DO iCol = 1 TO giNumCols:

      FIND bGrid WHERE bGrid.iCol = iCol AND bGrid.iRow = iRow NO-ERROR.
      IF NOT AVAILABLE bGrid THEN 
      DO:
        CREATE bGrid.
        ASSIGN bGrid.iCol = iCol
               bGrid.iRow = iRow
               bGrid.cVal = SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1).
      END.
    END.
  END.
END FUNCTION. /* loadGrid */


DEFINE VARIABLE i AS INTEGER NO-UNDO.

loadGrid("data.txt").

FOR EACH ttGrid WHERE ttGrid.cVal = "A":

  IF (    pos(ttGrid.iCol - 1, ttGrid.iRow - 1) = "M" /* M.M */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow - 1) = "M" /* .A. */
      AND pos(ttGrid.iCol - 1, ttGrid.iRow + 1) = "S" /* S.S */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow + 1) = "S" ) THEN i = i + 1.

  IF (    pos(ttGrid.iCol - 1, ttGrid.iRow + 1) = "M" /* S.S */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow + 1) = "M" /* .A. */
      AND pos(ttGrid.iCol - 1, ttGrid.iRow - 1) = "S" /* M.M */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow - 1) = "S" ) THEN i = i + 1.

  IF (    pos(ttGrid.iCol - 1, ttGrid.iRow - 1) = "M" /* M.S */
      AND pos(ttGrid.iCol - 1, ttGrid.iRow + 1) = "M" /* .A. */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow - 1) = "S" /* M.S */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow + 1) = "S" ) THEN i = i + 1.

  IF (    pos(ttGrid.iCol + 1, ttGrid.iRow - 1) = "M" /* S.M */
      AND pos(ttGrid.iCol + 1, ttGrid.iRow + 1) = "M" /* .A. */
      AND pos(ttGrid.iCol - 1, ttGrid.iRow - 1) = "S" /* S.M */
      AND pos(ttGrid.iCol - 1, ttGrid.iRow + 1) = "S" ) THEN i = i + 1.
END. 


MESSAGE i VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
