/* AoC 2024 day 05a 
 */ 
DEFINE TEMP-TABLE ttRule NO-UNDO
  FIELD cOrder AS CHARACTER 
  INDEX iPrim cOrder.

FUNCTION orderOk RETURNS LOGICAL (pcLeft AS CHARACTER, pcRight AS CHARACTER):
  RETURN   CAN-FIND(ttRule WHERE ttRule.cOrder = pcLeft + "|" + pcRight) 
    OR NOT CAN-FIND(ttRule WHERE ttRule.cOrder = pcRight + "|" + pcLeft).
END FUNCTION.

/* Main 
*/
DEFINE VARIABLE cList  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER   NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".
REPEAT:
  CREATE ttRule.
  IMPORT ttRule.
  IF ttRule.cOrder = '' THEN LEAVE.
END.

#PrintJob:
REPEAT:
  IMPORT UNFORMATTED cList.

  DO i = 1 TO NUM-ENTRIES(cList) - 1:
    IF NOT orderOk(ENTRY(i,cList), ENTRY(i + 1,cList)) THEN NEXT #PrintJob.
  END.

  iTotal = iTotal + INTEGER(ENTRY(INTEGER(NUM-ENTRIES(cList) / 2), cList)).
END.
INPUT CLOSE. 

MESSAGE iTotal 'in' ETIME 'ms'
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/*
** 5166 in 16 ms
*/
