/* Advent of code 2020 - day 2a
*/
DEFINE VARIABLE iValid    AS INTEGER NO-UNDO.
DEFINE VARIABLE cRule     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cChar     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cPassword AS CHARACTER NO-UNDO.

INPUT FROM day-02.dat.
REPEAT:
  IMPORT cRule cChar cPassword.
  cChar = ENTRY(1,cChar,':').

  IF    (LENGTH(cPassword) - LENGTH(REPLACE(cPassword, cChar, ''))) >= INTEGER(ENTRY(1,cRule,'-'))
    AND (LENGTH(cPassword) - LENGTH(REPLACE(cPassword, cChar, ''))) <= INTEGER(ENTRY(2,cRule,'-')) THEN iValid = iValid + 1.
END.
INPUT CLOSE. 

MESSAGE iValid VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 515 */

/*
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc 
*/
