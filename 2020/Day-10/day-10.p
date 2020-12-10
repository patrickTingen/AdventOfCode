/* AoC 2020 day 10
*/
DEFINE VARIABLE iOne   AS INTEGER NO-UNDO.
DEFINE VARIABLE iThree AS INTEGER NO-UNDO.
DEFINE VARIABLE iPrev  AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE tt NO-UNDO
  FIELD iNr AS INTEGER
  INDEX iPrim iNr.

INPUT FROM "input.txt".
REPEAT:
  CREATE tt.
  IMPORT tt.
END.
INPUT CLOSE. 

FOR EACH tt:
  IF (tt.iNr - iPrev) = 1 THEN iOne = iOne + 1.
  IF (tt.iNr - iPrev) = 3 THEN iThree = iThree + 1.
  iPrev = tt.iNr.
END.
iThree = iThree + 1. /* for the adapter itself */

MESSAGE iOne * iThree VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
