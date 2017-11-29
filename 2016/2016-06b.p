/* Advent Of Code 2016, day 6, part 2 */

DEFINE TEMP-TABLE ttChar NO-UNDO
  FIELD iPos   AS INTEGER
  FIELD cChar  AS CHARACTER
  FIELD iCount AS INTEGER
  .

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
DEFINE VARIABLE ii    AS INTEGER     NO-UNDO.
DEFINE VARIABLE cPass AS CHARACTER   NO-UNDO.

INPUT FROM 'd:\Data\Progress\AdventOfCode\2016-06-input.txt'.

REPEAT:

  IMPORT cLine.
  DO ii = 1 TO LENGTH(cLine):
    FIND ttChar WHERE ttChar.iPos = ii AND ttChar.cChar = SUBSTRING(cLine,ii,1) NO-ERROR.
    IF NOT AVAILABLE ttChar THEN CREATE ttChar.
    ASSIGN 
      ttChar.iPos   = ii
      ttChar.cChar  = SUBSTRING(cLine,ii,1)
      ttChar.iCount = ttChar.iCount + 1.
  END.
END. 

DO ii = 1 TO LENGTH(cLine):
  FOR EACH ttChar WHERE ttChar.iPos = ii BY ttChar.iCount  BY ttChar.cChar:
    cPass = cPass + ttChar.cChar.
    LEAVE.
  END.
END.

MESSAGE cPass
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* jucfoary                    */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */
