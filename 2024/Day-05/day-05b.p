/* AoC 2024 day 05b 
 */ 
DEFINE TEMP-TABLE ttRule NO-UNDO
  FIELD cOrder AS CHARACTER 
  INDEX iPrim cOrder.

FUNCTION orderOk RETURNS LOGICAL (pcLeft AS CHARACTER, pcRight AS CHARACTER):
  RETURN   CAN-FIND(ttRule WHERE ttRule.cOrder = pcLeft + "|" + pcRight) 
    OR NOT CAN-FIND(ttRule WHERE ttRule.cOrder = pcRight + "|" + pcLeft).
END FUNCTION.

FUNCTION sortList RETURNS CHARACTER (pcList AS CHARACTER):
  /* bubble sort 
  */
  DEFINE VARIABLE iOuter   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iInner   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cTemp    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lSwapped AS LOGICAL   NO-UNDO.

  DO iOuter = 1 TO NUM-ENTRIES(pcList) - 1:

    lSwapped = FALSE.

    DO iInner = 1 TO NUM-ENTRIES(pcList) - iOuter:
      IF NOT orderOk(ENTRY(iInner,pcList), ENTRY(iInner + 1,pcList)) THEN 
      DO:
        cTemp = ENTRY(iInner,pcList).
        ENTRY(iInner,pcList) = ENTRY(iInner + 1,pcList).
        ENTRY(iInner + 1,pcList) = cTemp.
        lSwapped = TRUE.
      END.
    END.

    IF NOT lSwapped THEN LEAVE.
  END.

  RETURN pcList.
END FUNCTION. /* sortList */

/* Main
*/
DEFINE VARIABLE cList    AS CHARACTER NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal   AS INTEGER   NO-UNDO.
DEFINE VARIABLE lOrderOk AS LOGICAL   NO-UNDO.

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

  lOrderOk = TRUE.
  DO i = 1 TO NUM-ENTRIES(cList) - 1:
    IF NOT orderOk(ENTRY(i,cList),ENTRY(i + 1,cList)) THEN lOrderOk = FALSE.
  END.
  IF lOrderOk THEN NEXT #PrintJob.

  cList = sortList(cList).
  iTotal = iTotal + INTEGER(ENTRY(INTEGER(NUM-ENTRIES(cList) / 2), cList)).
END.
INPUT CLOSE. 

MESSAGE iTotal 'in' ETIME 'ms'  /* 4679 in 84 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. 


