/* Advent of code 2018
** day 2
*/
DEFINE VARIABLE i2      AS INTEGER   NO-UNDO.
DEFINE VARIABLE i3      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDone   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cChar   AS CHARACTER NO-UNDO.
DEFINE VARIABLE lFound2 AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lFound3 AS LOGICAL   NO-UNDO.

INPUT FROM "2018-02.dat".
REPEAT:
  IMPORT cLine.
  cDone = ''.
  lFound2 = FALSE.
  lFound3 = FALSE.
  DO i = 1 TO LENGTH(cLine):
    cChar = SUBSTRING(cLine,i,1).
    
    IF LOOKUP(cChar,cDone) > 0 THEN NEXT.
    cDone = cDone + cChar + ','.
    
    IF LENGTH(cLine) = LENGTH(REPLACE(cLine,cChar,'')) + 2 THEN lFound2 = TRUE.
    IF LENGTH(cLine) = LENGTH(REPLACE(cLine,cChar,'')) + 3 THEN lFound3 = TRUE.
  END.
  
  IF lFound2 THEN i2 = i2 + 1.
  IF lFound3 THEN i3 = i3 + 1.
END.
INPUT CLOSE. 

MESSAGE cLine SKIP i2 * i3 VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
