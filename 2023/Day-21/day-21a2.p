/* AoC 2023 day 21a version 2
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol   AS INTEGER 
  FIELD iRow   AS INTEGER 
  FIELD cVal   AS CHARACTER
  FIELD iSteps AS INTEGER INITIAL -1
  INDEX idxPrim iCol iRow iSteps. 
  
DEFINE VARIABLE i         AS INTEGER NO-UNDO.
DEFINE VARIABLE iAnswer   AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumSteps AS INTEGER NO-UNDO.
DEFINE BUFFER bGrid FOR ttGrid. 

FUNCTION loadGrid RETURNS LOGICAL 
  ( pcFile AS CHARACTER 
  ): 
  DEFINE VARIABLE cData  AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iCol   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow   AS INTEGER   NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  DO iRow = 1 TO NUM-ENTRIES(cData,'~n'):
    DO iCol = 1 TO LENGTH(ENTRY(1,cData,'~n')):

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

/* Main */
loadGrid("data.txt").
iNumSteps = 64.

FIND ttGrid WHERE ttGrid.cVal = "S".
ttGrid.iSteps = 0.

DO i = 0 TO iNumSteps - 1:
  FOR EACH ttGrid WHERE ttGrid.iSteps = i:
  
    FIND bGrid WHERE bGrid.iCol = ttGrid.iCol - 1 AND bGrid.iRow = ttGrid.iRow AND bGrid.iSteps = -1 AND bGrid.cVal = "." NO-ERROR.
    IF AVAILABLE bGrid THEN ASSIGN bGrid.iSteps = ttGrid.iSteps + 1.
  
    FIND bGrid WHERE bGrid.iCol = ttGrid.iCol + 1 AND bGrid.iRow = ttGrid.iRow AND bGrid.iSteps = -1 AND bGrid.cVal = "." NO-ERROR.
    IF AVAILABLE bGrid THEN ASSIGN bGrid.iSteps = ttGrid.iSteps + 1.
  
    FIND bGrid WHERE bGrid.iCol = ttGrid.iCol AND bGrid.iRow = ttGrid.iRow - 1 AND bGrid.iSteps = -1 AND bGrid.cVal = "." NO-ERROR.
    IF AVAILABLE bGrid THEN ASSIGN bGrid.iSteps = ttGrid.iSteps + 1.
  
    FIND bGrid WHERE bGrid.iCol = ttGrid.iCol AND bGrid.iRow = ttGrid.iRow + 1 AND bGrid.iSteps = -1 AND bGrid.cVal = "." NO-ERROR.
    IF AVAILABLE bGrid THEN ASSIGN bGrid.iSteps = ttGrid.iSteps + 1.
  END.
END.

/* If you are 63 steps away, you can also do a step back and land on a tile
** that is 62 steps away from your start position. Likewise, you can do 2 steps
** back from tile nr 62. Your total nr of steps will still be 64 but you end on 
** tile nr 60. You can continue this until tile nr 32 where you do 32 steps back
** and come back on your starting position. 
*/
FOR EACH ttGrid WHERE ttGrid.iStep = iNumSteps OR ttGrid.iStep MOD 2 = 0.
  iAnswer = iAnswer + 1.
END.

MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

