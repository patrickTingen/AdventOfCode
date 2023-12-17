/* AoC 2023 day 14b
 * 
 * Alternative version with array instead of temp table
 */ 
DEFINE TEMP-TABLE ttHist NO-UNDO
  FIELD iId     AS INTEGER
  FIELD cData   AS CHARACTER
  FIELD iWeight AS INTEGER
  INDEX iPrim iId
  INDEX iData cData.

DEFINE VARIABLE giPrev     AS INTEGER NO-UNDO.
DEFINE VARIABLE giCycle    AS INTEGER NO-UNDO.
DEFINE VARIABLE giGridSize AS INTEGER NO-UNDO.
DEFINE VARIABLE giNumCols  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE gcPos      AS CHARACTER NO-UNDO EXTENT.

FUNCTION setPos RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  , pcVal AS CHARACTER
  ):    
  gcPos[(piRow - 1) * giNumCols + piCol] = pcVal.
  
  RETURN TRUE.
END FUNCTION.


FUNCTION pos RETURNS CHARACTER
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):    
  IF piRow < 1 OR piRow > giNumRows
  OR piCol < 1 OR piCol > giNumCols THEN RETURN "".
  
  RETURN gcPos[(piRow - 1) * giNumCols + piCol].
  
END FUNCTION. /* pos */


FUNCTION loadGrid RETURNS LOGICAL 
  ( pcFile AS CHARACTER 
  ): 
  DEFINE VARIABLE cData  AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE iCol   AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRow   AS INTEGER  NO-UNDO.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giNumCols = LENGTH(ENTRY(1,cData,'~n')).
  giNumRows = NUM-ENTRIES(cData,'~n').
  giGridSize = giNumCols * giNumRows.
  EXTENT(gcPos) = giGridSize.

  DO iRow = 1 TO giNumRows:
    DO iCol = 1 TO giNumCols:
      setPos(iCol, iRow, STRING(SUBSTRING(ENTRY(iRow, cData, '~n'), iCol, 1))).
    END.
  END.
END FUNCTION. /* loadGrid */


FUNCTION getGrid RETURNS LONGCHAR
  ( ): 
  DEFINE VARIABLE cGrid AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER  NO-UNDO.
  
  DO i = 1 TO giGridSize:   
    cGrid = cGrid + gcPos[i].
  END.

  RETURN cGrid.
END FUNCTION. /* getGrid */


PROCEDURE tiltNorth:
  DEFINE VARIABLE i    AS INTEGER NO-UNDO.
  DEFINE VARIABLE iRow AS INTEGER NO-UNDO.
  DEFINE VARIABLE iCol AS INTEGER NO-UNDO.

  DO iRow = 2 TO giNumRows:
  
    #Rock:
    DO iCol = 1 TO giNumCols:
    
      IF pos(iCol,iRow) = "O" THEN
      DO i = iRow TO 1 BY -1:
        IF pos(iCol,i - 1) = "." THEN
        DO:
          setpos(iCol,i - 1,"O").
          setpos(iCol,i,".").
        END.
        ELSE
          NEXT #Rock.
      END.
      
    END.
  END.
END PROCEDURE. 


PROCEDURE tiltWest:
  DEFINE VARIABLE i    AS INTEGER NO-UNDO.
  DEFINE VARIABLE iRow AS INTEGER NO-UNDO.
  DEFINE VARIABLE iCol AS INTEGER NO-UNDO.

  DO iCol = 2 TO giNumCols:
  
    #Rock:
    DO iRow = 1 TO giNumRows:
    
      IF pos(iCol,iRow) = "O" THEN  
      DO i = iCol TO 1 BY -1:
        IF pos(i - 1, iRow) = "." THEN
        DO:
          setpos(i - 1, iRow,"O").
          setpos(i, iRow,".").
        END.
        ELSE
          NEXT #Rock.
      END.
      
    END.
  END.
END PROCEDURE. 


PROCEDURE tiltSouth:
  DEFINE VARIABLE i    AS INTEGER NO-UNDO.
  DEFINE VARIABLE iRow AS INTEGER NO-UNDO.
  DEFINE VARIABLE iCol AS INTEGER NO-UNDO.

  DO iRow = giNumRows - 1 TO 1 BY -1:
  
    #Rock:
    DO iCol = 1 TO giNumCols:
    
      IF pos(iCol,iRow) = "O" THEN  
      DO i = iRow TO giNumRows:
        IF pos(iCol,i + 1) = "." THEN
        DO:
          setpos(iCol,i + 1,"O").
          setpos(iCol,i,".").
        END.
        ELSE
          NEXT #Rock.
      END.
      
    END.
  END.
END PROCEDURE. 


PROCEDURE tiltEast:
  DEFINE VARIABLE i    AS INTEGER NO-UNDO.
  DEFINE VARIABLE iRow AS INTEGER NO-UNDO.
  DEFINE VARIABLE iCol AS INTEGER NO-UNDO.

  DO iCol = giNumCols - 1 TO 1 BY -1:
  
    #Rock:
    DO iRow = 1 TO giNumRows:
    
      IF pos(iCol,iRow) = "O" THEN  
      DO i = iCol TO giNumCols:
        IF pos(i + 1,iRow) = "." THEN
        DO:
          setpos(i + 1,iRow,"O").
          setpos(i,iRow,".").
        END.
        ELSE
          NEXT #Rock.
      END.
      
    END.
  END.
END PROCEDURE. 


FUNCTION findGrid RETURNS INTEGER ():
  DEFINE VARIABLE iNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cHash AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iCol  AS INTEGER   NO-UNDO.

  DEFINE BUFFER bHist FOR ttHist. 

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
  DO iRow = 1 TO giNumRows:
    DO iCol = 1 TO giNumCols:
  	IF pos(iCol,iRow) = "O" THEN
  	  bHist.iWeight = bHist.iWeight + (giNumRows - iRow) + 1.
    END.
  END.

  RETURN 0.
END FUNCTION. /* findGrid */

/* Main 
*/
ETIME(YES).
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
    MESSAGE ttHist.iWeight ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.

  /* Show some progress */
  HIDE MESSAGE NO-PAUSE.
  MESSAGE giCycle.
  PROCESS EVENTS.
END.

