/* loadGrid.p
*/
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol  AS INTEGER 
  FIELD iRow  AS INTEGER 
  FIELD cVal  AS CHARACTER
  FIELD lUsed AS LOGICAL 
  INDEX idxPrim iCol iRow. 
  
DEFINE VARIABLE giNumCols AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows AS INTEGER NO-UNDO INITIAL ?.
  
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

loadGrid("data.txt").

