/* AoC 2022 day 10a 
 */ 
DEFINE VARIABLE cInstr  AS CHARACTER NO-UNDO. 
DEFINE VARIABLE iParam  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCycle  AS INTEGER   NO-UNDO. 
DEFINE VARIABLE iValue  AS INTEGER   NO-UNDO INITIAL 1.
DEFINE VARIABLE iLength AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSignal AS INTEGER   NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  IMPORT cInstr iParam.
  
  CASE cInstr:
    WHEN 'noop' THEN iLength = 1.
    WHEN 'addx' THEN iLength = 2.
  END CASE.
  
  DO i = 1 TO iLength:
    iCycle = iCycle + 1.
    
    IF iCycle = 20 OR ((iCycle - 20) MOD 40 = 0) THEN
      iSignal = iSignal + (iCycle * iValue).
  END.
  
  IF cInstr = 'addx' THEN iValue = iValue + iParam.

END.
INPUT CLOSE.

MESSAGE iSignal
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
