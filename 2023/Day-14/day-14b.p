/* AoC 2023 day 14b
 */ 
DEFINE TEMP-TABLE ttHist NO-UNDO
  FIELD iId     AS INTEGER
  FIELD cData   AS CHARACTER
  FIELD iWeight AS INTEGER
  INDEX iPrim iId
  INDEX iData cData.

DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER 
  FIELD cVal AS CHARACTER
  INDEX idxPos iCol iRow. 
  
DEFINE VARIABLE giPrev     AS INTEGER NO-UNDO.
DEFINE VARIABLE giCycle    AS INTEGER NO-UNDO.
DEFINE VARIABLE giGridSize AS INTEGER NO-UNDO.
DEFINE VARIABLE giNumCols  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows  AS INTEGER NO-UNDO INITIAL ?.

FUNCTION setPos RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  , pcVal AS CHARACTER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iCol = piCol AND bGrid.iRow = piRow NO-ERROR.
  IF NOT AVAILABLE bGrid THEN 
  DO:
    giGridSize = giGridSize + 1.
    CREATE bGrid.
    ASSIGN 
      bGrid.iCol = piCol
      bGrid.iRow = piRow
      bGrid.cVal = pcVal.
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
  DEFINE VARIABLE cData  AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE iCol   AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRow   AS INTEGER  NO-UNDO.

  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giNumCols = LENGTH(ENTRY(1,cData,'~n')).
  giNumRows = NUM-ENTRIES(cData,'~n').

  DO iRow = 1 TO giNumRows:
    DO iCol = 1 TO giNumCols:
      setPos(iCol, iRow, STRING(SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1))).
    END.
  END.
END FUNCTION. /* loadGrid */


FUNCTION getGrid RETURNS LONGCHAR
  ( ): 
  DEFINE VARIABLE cGrid AS LONGCHAR NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  FOR EACH bGrid:
    cGrid = cGrid + bGrid.cVal.
  END.

  RETURN cGrid.
END FUNCTION. /* getGrid */


PROCEDURE tiltNorth:
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid. 

  #Rock:
  FOR EACH bGrid 
    WHERE bGrid.cVal = "O"
       BY bGrid.iRow BY bGrid.iCol:
  
    DO i = bGrid.iRow TO 1 BY -1:
      IF pos(bGrid.iCol,i - 1) = "." THEN
      DO:
        setpos(bGrid.iCol,i - 1,"O").
        setpos(bGrid.iCol,i,".").
      END.
      ELSE
        NEXT #Rock.
    END.
  END.
END PROCEDURE. 

PROCEDURE tiltWest:
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid. 

  #Rock:
  FOR EACH bGrid 
    WHERE bGrid.cVal = "O"
       BY bGrid.iCol BY bGrid.iRow:
  
    DO i = bGrid.iCol TO 1 BY -1:
      IF pos(i - 1, bGrid.iRow) = "." THEN
      DO:
        setpos(i - 1, bGrid.iRow,"O").
        setpos(i, bGrid.iRow,".").
      END.
      ELSE
        NEXT #Rock.
    END.
  END.
END PROCEDURE. 

PROCEDURE tiltSouth:
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid. 

  #Rock:
  FOR EACH bGrid 
    WHERE bGrid.cVal = "O"
       BY bGrid.iRow DESC BY bGrid.iCol:
  
    DO i = bGrid.iRow TO giNumRows:
      IF pos(bGrid.iCol,i + 1) = "." THEN
      DO:
        setpos(bGrid.iCol,i + 1,"O").
        setpos(bGrid.iCol,i,".").
      END.
      ELSE
        NEXT #Rock.
    END.
  END.
END PROCEDURE. 

PROCEDURE tiltEast:
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid. 

  #Rock:
  FOR EACH bGrid 
    WHERE bGrid.cVal = "O"
       BY bGrid.iCol DESC BY bGrid.iRow:
  
    DO i = bGrid.iCol TO giNumCols:
      IF pos(i + 1, bGrid.iRow) = "." THEN
      DO:
        setpos(i + 1, bGrid.iRow,"O").
        setpos(i, bGrid.iRow,".").
      END.
      ELSE
        NEXT #Rock.
    END.
  END.
END PROCEDURE. 


FUNCTION findGrid RETURNS INTEGER ():
  DEFINE VARIABLE iNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cHash AS CHARACTER NO-UNDO.

  DEFINE BUFFER bHist FOR ttHist. 
  DEFINE BUFFER bGrid FOR ttGrid.

  cHash = STRING(MD5-DIGEST( getGrid() )).
  FIND bHist WHERE bHist.cData = cHash NO-ERROR.
  IF AVAILABLE bHist THEN RETURN bHist.iId.

  FIND LAST bHist NO-ERROR.
  iNr = (IF AVAILABLE bHist THEN bHist.iId ELSE 0) + 1.

  CREATE bHist. 
  ASSIGN 
    bHist.iId     = iNr
    bHist.cData   = cHash
    bHist.iWeight = 0.

  /* Calc total weight */
  FOR EACH bGrid WHERE bGrid.cVal = "O":
    bHist.iWeight = bHist.iWeight + (giNumRows - bGrid.iRow) + 1.
  END.

  RETURN 0.
END FUNCTION. /* findGrid */


/* Main 
*/
loadGrid("data.txt").

DO giCycle = 1 TO 1000:

  RUN tiltNorth.
  RUN tiltWest.
  RUN tiltSouth.
  RUN tiltEast.

  giPrev = findGrid().
  IF giPrev > 0 THEN
  DO:
    /* Need 1,000,000,000 iterations, but there is a pattern (mine is ~200 cycles) */
    FIND ttHist WHERE ttHist.iId = giPrev + (1000000000 - giPrev) MOD (giCycle - giPrev).
    MESSAGE ttHist.iWeight VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.

  /* Show some progress */
  HIDE MESSAGE NO-PAUSE.
  MESSAGE giCycle.
  PROCESS EVENTS. 
END.
