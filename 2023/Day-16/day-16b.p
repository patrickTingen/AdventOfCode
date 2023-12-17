/* AoC 2023 day 16b
 */ 
DEFINE VARIABLE giGridSize  AS INTEGER   NO-UNDO.
DEFINE VARIABLE giNumCols   AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows   AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE gcPos       AS CHARACTER NO-UNDO EXTENT.

DEFINE TEMP-TABLE ttEnergy NO-UNDO
  FIELD ttCol AS INTEGER
  FIELD ttRow AS INTEGER
  INDEX iPri ttCol ttRow.

DEFINE TEMP-TABLE ttTodo NO-UNDO
  FIELD ttCol AS INTEGER
  FIELD ttRow AS INTEGER
  FIELD ttDir AS CHARACTER 
  INDEX iPri ttCol ttRow.

DEFINE TEMP-TABLE ttDone NO-UNDO
  FIELD ttCol AS INTEGER
  FIELD ttRow AS INTEGER
  FIELD ttDir AS CHARACTER 
  INDEX iPri ttCol ttRow.

FUNCTION setPos RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  , pcVal AS CHARACTER
  ):    
  gcPos[(piRow - 1) * giNumCols + piCol] = pcVal.
  RETURN TRUE.
END FUNCTION.


FUNCTION energize RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):    
  FIND ttEnergy WHERE ttEnergy.ttCol = piCol AND ttEnergy.ttRow = piRow NO-ERROR.
  IF AVAILABLE ttEnergy THEN RETURN FALSE. 

  CREATE ttEnergy.
  ASSIGN ttEnergy.ttCol = piCol
         ttEnergy.ttRow = piRow.

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
  DEFINE VARIABLE cData AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE iCol  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER  NO-UNDO.

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
    DEFINE VARIABLE iCol  AS INTEGER  NO-UNDO.
    DEFINE VARIABLE iRow  AS INTEGER  NO-UNDO.
  
  DO iRow = 1 TO giNumRows:
    DO iCol = 1 TO giNumCols:
      cGrid = cGrid + Pos(iCol, iRow).
    END.
    cGrid = cGrid + "~n".
  END.

  RETURN cGrid.
END FUNCTION. /* getGrid */


FUNCTION newBeam RETURNS LOGICAL 
  ( piCol AS INTEGER
  , piRow AS INTEGER
  , pcDir AS CHARACTER
  ):    
  DEFINE BUFFER bDone FOR ttDone.
  DEFINE BUFFER bTodo FOR ttTodo.

  IF CAN-FIND(bDone 
        WHERE bDone.ttCol = piCol
          AND bDone.ttRow = piRow
          AND bDone.ttDir = pcDir) THEN RETURN FALSE.

  CREATE bTodo.
  ASSIGN 
    bTodo.ttCol = piCol 
    bTodo.ttRow = piRow 
    bTodo.ttDir = pcDir. 

  RETURN TRUE.
END FUNCTION.


FUNCTION getEnergy RETURNS INTEGER():

  DEFINE VARIABLE iCol    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cDir    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iResult AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iAnswer AS INTEGER   NO-UNDO.

  EMPTY TEMP-TABLE ttEnergy.
  EMPTY TEMP-TABLE ttDone.

  #Main:
  REPEAT:
  
    /* pick a new beam */
    FIND FIRST ttTodo NO-ERROR.
    IF NOT AVAILABLE ttTodo THEN LEAVE #Main.
    
    iCol = ttTodo.ttCol.
    iRow = ttTodo.ttRow.
    cDir = ttTodo.ttDir.
    DELETE ttTodo.
  
    #Step:
    REPEAT:
  
      /* New position */
      CASE cDir:
        WHEN "U" THEN iRow = iRow - 1.
        WHEN "R" THEN iCol = iCol + 1.
        WHEN "D" THEN iRow = iRow + 1.
        WHEN "L" THEN iCol = iCol - 1.
      END CASE.
  
      /* Been here before? */
      IF CAN-FIND(ttDone 
            WHERE ttDone.ttCol = iCol
              AND ttDone.ttRow = iRow
              AND ttDone.ttDir = cDir) THEN NEXT #Main.
  
      /* Outside grid? */
      IF pos(iCol,iRow) = "" THEN NEXT #Main.
  
      CREATE ttDone.
      ASSIGN ttDone.ttCol = iCol
             ttDone.ttRow = iRow
             ttDone.ttDir = cDir.
  
      energize(iCol,iRow).
  
      /* Continue in same direction */
      IF pos(iCol,iRow) = "." THEN NEXT #Step.
  
      /* New instruction */
      CASE cDir + pos(iCol,iRow):
        WHEN "U|" THEN NEXT #Step. 
        WHEN "R-" THEN NEXT #Step. 
        WHEN "D|" THEN NEXT #Step. 
        WHEN "L-" THEN NEXT #Step. 
  
        WHEN "U\" THEN ASSIGN cDir = "L".
        WHEN "R\" THEN ASSIGN cDir = "D".
        WHEN "D\" THEN ASSIGN cDir = "R".
        WHEN "L\" THEN ASSIGN cDir = "U".
  
        WHEN "U/" THEN ASSIGN cDir = "R".
        WHEN "R/" THEN ASSIGN cDir = "U".
        WHEN "D/" THEN ASSIGN cDir = "L".
        WHEN "L/" THEN ASSIGN cDir = "D".
  
        WHEN "L|" OR WHEN "R|" THEN 
        DO:
          newBeam(iCol,iRow,"U").
          newBeam(iCol,iRow,"D").
          NEXT #Main.
        END.
  
        WHEN "U-" OR WHEN "D-" THEN 
        DO:
          newBeam(iCol,iRow,"L").
          newBeam(iCol,iRow,"R").
          NEXT #Main.
        END.
      END CASE.
    END.       
  END.
  
  FOR EACH ttEnergy:
    iResult = iResult + 1.
  END.
  RETURN iResult.

END FUNCTION. /* getEnergy */

/* Main 
*/
loadGrid("data.txt").

DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INTEGER   NO-UNDO.
DEFINE VARIABLE iEnergy AS INTEGER   NO-UNDO.

DO i = 1 TO giNumRows:

  EMPTY TEMP-TABLE ttTodo. 
  newBeam(0,i,"R").
  iEnergy = getEnergy().
  iAnswer = MAX(iAnswer, iEnergy).

  EMPTY TEMP-TABLE ttTodo. 
  newBeam(giNumCols + 1,i,"L").
  iEnergy = getEnergy().
  iAnswer = MAX(iAnswer, iEnergy).

  EMPTY TEMP-TABLE ttTodo. 
  newBeam(i,0,"D").
  iEnergy = getEnergy().
  iAnswer = MAX(iAnswer, iEnergy).

  EMPTY TEMP-TABLE ttTodo. 
  newBeam(i,giNumRows + 1,"U").
  iEnergy = getEnergy().
  iAnswer = MAX(iAnswer, iEnergy).

  HIDE MESSAGE NO-PAUSE.
  MESSAGE i.
  PROCESS EVENTS. 
END.

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
