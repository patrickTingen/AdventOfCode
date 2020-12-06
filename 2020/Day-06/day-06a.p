/* AoC 2020 - DAY 6
*/
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttTest NO-UNDO 
  FIELD cData  AS CHARACTER FORMAT 'x(20)'
  FIELD iScore AS INTEGER.

INPUT FROM day-06.dat.
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' OR NOT AVAILABLE ttTest THEN CREATE ttTest.
  ttTest.cData = LOWER(REPLACE(TRIM(ttTest.cData + ' ' + cLine),' ','')).
END.
INPUT CLOSE. 

FOR EACH ttTest:
  DO i = 97 TO 122:
    IF ttTest.cData <> REPLACE(ttTest.cData,CHR(i),'') THEN 
      ttTest.iScore = ttTest.iScore + 1.
  END.
  iTotal = iTotal + ttTest.iScore.
END.

MESSAGE iTotal /* 6297 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

