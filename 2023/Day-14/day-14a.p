/* AoC 2023 day 14a 
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER 
  FIELD cVal AS CHARACTER
  INDEX idxPrim iCol iRow. 
  
DEFINE VARIABLE iNumCols AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iNumRows AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE i        AS INTEGER NO-UNDO.
DEFINE VARIABLE iAnswer  AS INTEGER NO-UNDO.
  
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
  DEFINE VARIABLE cData AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE iCol  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER  NO-UNDO.

  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iNumCols = LENGTH(ENTRY(1,cData,'~n')).
  iNumRows = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO iNumRows:
    DO iCol = 1 TO iNumCols:
      setPos(iCol, iRow, SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1)).
    END.
  END.

END FUNCTION. /* loadGrid */


loadGrid("data.txt").

#Rock:
FOR EACH ttGrid BY ttGrid.iRow BY ttGrid.iCol:

  IF pos(ttGrid.iCol,ttGrid.iRow) = "O" THEN 
  DO i = ttGrid.iRow TO 1 BY -1:

    IF pos(ttGrid.iCol,i - 1) = "." THEN 
    DO:
      setpos(ttGrid.iCol,i - 1,"O").
      setpos(ttGrid.iCol,i,".").
    END.
    ELSE 
      NEXT #Rock.
  END.
END.

FOR EACH ttGrid WHERE ttGrid.cVal = "O":
  iAnswer = iAnswer + (iNumRows - ttGrid.iRow) + 1.
END.

MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


