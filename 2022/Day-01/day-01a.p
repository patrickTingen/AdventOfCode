/* AoC 2022 day 01a 
 */ 
DEFINE VARIABLE iElf    AS INTEGER NO-UNDO INITIAL 1. 
DEFINE VARIABLE iElfMax AS INTEGER NO-UNDO.
DEFINE VARIABLE iCal    AS INTEGER NO-UNDO.
DEFINE VARIABLE iCalElf AS INTEGER NO-UNDO.
DEFINE VARIABLE iCalMax AS INTEGER NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  iCal = 0.
  IMPORT iCal.
  
  IF iCal = 0 THEN 
  DO:
    IF iCalElf > iCalMax THEN
      ASSIGN iCalMax = iCalElf
             iElfMax = iElf.
             
    iElf = iElf + 1.  
    iCalElf = 0.
  END.
  iCalElf = iCalElf + iCal.
END.
INPUT CLOSE. 

MESSAGE iElfMax iCalMax
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
