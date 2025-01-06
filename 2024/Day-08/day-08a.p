/* AoC 2024 day 08a 
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol  AS INTEGER 
  FIELD iRow  AS INTEGER 
  FIELD cVal  AS CHARACTER CASE-SENSITIVE
  INDEX idxPrim iCol iRow. 
  
DEFINE VARIABLE giMaxCol AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giMaxRow AS INTEGER NO-UNDO INITIAL ?.
  
FUNCTION setAntinode RETURNS LOGICAL
  ( piColA AS INTEGER
  , piRowA AS INTEGER
  , piColB AS INTEGER
  , piRowB AS INTEGER
  ):
  DEFINE VARIABLE iNewCol AS INTEGER NO-UNDO.
  DEFINE VARIABLE iNewRow AS INTEGER NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  iNewCol = (piColA + (piColA - piColB)). 
  iNewRow = (piRowA + (piRowA - piRowB)). 

  IF iNewCol < 1 OR iNewCol > giMaxCol THEN RETURN FALSE. 
  IF iNewRow < 1 OR iNewRow > giMaxRow THEN RETURN FALSE. 

  FIND bGrid 
    WHERE bGrid.iCol = iNewCol
      AND bGrid.iRow = iNewRow
      AND bGrid.cVal = "#" NO-ERROR.

  IF AVAILABLE bGrid THEN RETURN FALSE. 

  CREATE bGrid.
  ASSIGN bGrid.iCol = iNewCol
         bGrid.iRow = iNewRow
         bGrid.cVal = "#".
           
  RETURN TRUE.
END FUNCTION.


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
  giMaxCol = LENGTH(ENTRY(1,cData,'~n')).
  giMaxRow = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO giMaxRow:
    DO iCol = 1 TO giMaxCol:

      FIND bGrid WHERE bGrid.iCol = iCol AND bGrid.iRow = iRow NO-ERROR.
      IF NOT AVAILABLE bGrid THEN 
      DO:
        CREATE bGrid.
        ASSIGN bGrid.iCol = iCol
               bGrid.iRow = iRow
               bGrid.cVal = SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1).

        IF bGrid.cVal = "." THEN DELETE bGrid.
      END.
    END.
  END.
END FUNCTION. /* loadGrid */

loadGrid("test.txt").

DEFINE VARIABLE iPartA AS INTEGER NO-UNDO.
DEFINE BUFFER btGrid  FOR ttGrid.
DEFINE BUFFER btGrid2 FOR ttGrid.

FOR EACH btGrid BREAK BY btGrid.cVal:
  FOR EACH btGrid2 WHERE ROWID(btGrid2) <> ROWID(btGrid) AND btGrid2.cVal = btGrid.cVal:
    setAntinode(btGrid.iCol, btGrid.iRow, btGrid2.iCol, btGrid2.iRow).
  END.
END.

FOR EACH ttGrid WHERE ttGrid.cVal = "#":
  iPartA = iPartA + 1.
END.

MESSAGE iPartA
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
