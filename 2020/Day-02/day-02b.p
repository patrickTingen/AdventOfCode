/* Advent of code 2020 - day 2b
*/
DEFINE VARIABLE iValid    AS INTEGER NO-UNDO.
DEFINE VARIABLE cRule     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cChar     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cPassword AS CHARACTER NO-UNDO.

INPUT FROM day-02.dat.
REPEAT:
  IMPORT cRule cChar cPassword.
  cChar = ENTRY(1,cChar,':').

  IF   (SUBSTRING(cPassword, INTEGER(ENTRY(1,cRule,'-')),1) = cChar)
    <> (SUBSTRING(cPassword, INTEGER(ENTRY(2,cRule,'-')),1) = cChar) THEN iValid = iValid + 1.
END.
INPUT CLOSE. 

MESSAGE iValid VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 711 */

/*
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc 
*/
