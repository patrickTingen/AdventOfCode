/* AoC 2024 day 02a 
 */ 
DEFINE VARIABLE iReport  AS INTEGER NO-UNDO EXTENT 100.
DEFINE VARIABLE iNumSafe AS INTEGER NO-UNDO.
DEFINE VARIABLE i        AS INTEGER NO-UNDO.
DEFINE VARIABLE lIncr    AS LOGICAL NO-UNDO.

INPUT FROM "data.txt".

#Report:
REPEAT:

  iReport = ?.
  IMPORT iReport.
  lIncr = (iReport[2] > iReport[1]).

  #Level:
  DO i = 1 TO 99:
    IF iReport[i + 1] = ? THEN LEAVE #Level.
    IF iReport[i + 1] <= iReport[i] AND lIncr THEN NEXT #Report.
    IF iReport[i + 1] >= iReport[i] AND NOT lIncr THEN NEXT #Report.
    IF ABS(iReport[i + 1] - iReport[i]) < 1 THEN NEXT #Report.
    IF ABS(iReport[i + 1] - iReport[i]) > 3 THEN NEXT #Report. 
  END.

  iNumSafe = iNumSafe + 1.
END.
INPUT CLOSE. 

MESSAGE iNumSafe /* 220 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
