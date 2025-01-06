/* AoC 2024 day 08b
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER 
  FIELD cVal AS CHARACTER CASE-SENSITIVE
  INDEX idxPrim cVal iCol iRow. 
  
DEFINE VARIABLE giMaxCol AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giMaxRow AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iPartB   AS INTEGER NO-UNDO.
DEFINE VARIABLE iNewCol  AS INTEGER NO-UNDO.
DEFINE VARIABLE iNewRow  AS INTEGER NO-UNDO.

DEFINE BUFFER btGrid  FOR ttGrid.
DEFINE BUFFER btGrid2 FOR ttGrid.
DEFINE BUFFER btGrid3 FOR ttGrid.

ETIME(YES).
RUN loadGrid("data.txt").

FOR EACH btGrid WHERE cVal <> "#"
  , EACH btGrid2 WHERE btGrid2.cVal = btGrid.cVal AND ROWID(btGrid2) <> ROWID(btGrid):

  iNewCol = btGrid.iCol.
  iNewRow = btGrid.iRow.

  REPEAT:
    IF NOT CAN-FIND(ttGrid WHERE ttGrid.cVal = "#" AND ttGrid.iCol = iNewCol AND ttGrid.iRow = iNewRow) THEN 
    DO:
      CREATE btGrid3.
      ASSIGN btGrid3.iCol = iNewCol
             btGrid3.iRow = iNewRow
             btGrid3.cVal = "#"
             iPartB = iPartB + 1.
    END.

    iNewCol = (iNewCol + (btGrid.iCol - btGrid2.iCol)). 
    iNewRow = (iNewRow + (btGrid.iRow - btGrid2.iRow)). 
  
    IF iNewCol < 1 OR iNewCol > giMaxCol OR iNewRow < 1 OR iNewRow > giMaxRow THEN LEAVE.
  END.
END.

MESSAGE iPartB "in" ETIME "ms" /* 1235 in 22 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


PROCEDURE loadGrid:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iCol  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cAnt  AS CHARACTER NO-UNDO.

  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giMaxCol = LENGTH(ENTRY(1,cData,'~n')).
  giMaxRow = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO giMaxRow:
    DO iCol = 1 TO giMaxCol:

      cAnt = SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1).
      IF cAnt = "." THEN NEXT. 

      CREATE bGrid.
      ASSIGN bGrid.iCol = iCol
             bGrid.iRow = iRow
             bGrid.cVal = cAnt.
    END.
  END.
END PROCEDURE. /* loadGrid */
