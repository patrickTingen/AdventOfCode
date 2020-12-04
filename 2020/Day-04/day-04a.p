/* Advent of code 2020 - day 4a
*/
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iValid AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttPass NO-UNDO 
  FIELD cData AS CHARACTER FORMAT 'x(200)'.

INPUT FROM day-04.dat.
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' OR NOT AVAILABLE ttPass THEN CREATE ttPass.
  ttPass.cData = TRIM(ttPass.cData + ' ' + cLine).
  ttPass.cData = REPLACE(ttPass.cData,':',' ').
END.
INPUT CLOSE. 

FOR EACH ttPass:
  IF    LOOKUP('byr', ttPass.cData, ' ') > 0
    AND LOOKUP('iyr', ttPass.cData, ' ') > 0
    AND LOOKUP('eyr', ttPass.cData, ' ') > 0
    AND LOOKUP('hgt', ttPass.cData, ' ') > 0
    AND LOOKUP('hcl', ttPass.cData, ' ') > 0
    AND LOOKUP('ecl', ttPass.cData, ' ') > 0
    AND LOOKUP('pid', ttPass.cData, ' ') > 0 THEN iValid = iValid + 1.
END.

MESSAGE iValid VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 264 */
