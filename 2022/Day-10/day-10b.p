/* AoC 2022 day 10b 
 */ 
DEFINE VARIABLE cInstr  AS CHARACTER NO-UNDO. 
DEFINE VARIABLE iParam  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCycle  AS INTEGER   NO-UNDO. 
DEFINE VARIABLE iValue  AS INTEGER   NO-UNDO INITIAL 1.
DEFINE VARIABLE iLength AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cImage  AS LONGCHAR  NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  IMPORT cInstr iParam.
  
  CASE cInstr:
    WHEN 'noop' THEN iLength = 1.
    WHEN 'addx' THEN iLength = 2.
  END CASE.
  
  #Cycle:
  DO i = 1 TO iLength:
    iCycle = iCycle + 1.
    cImage = cImage + STRING(ABS((iValue + 1) - (iCycle MOD 40)) < 2, "#/.").
    IF iCycle MOD 40 = 0 THEN cImage = cImage + '~n'.
  END.
  
  IF cInstr = 'addx' THEN iValue = iValue + iParam.
END.
INPUT CLOSE.

COPY-LOB cImage TO FILE "image.txt".
OS-COMMAND NO-WAIT START "image.txt".

  

