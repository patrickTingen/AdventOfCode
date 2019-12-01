/*------------------------------------------------------------------------
    File        : 2017-04a.p
    Purpose     : Day 4 of AoC 2017

    5-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE cPass     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNumValid AS INTEGER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER NO-UNDO.

INPUT FROM c:\Data\DropBox\AdventOfCode\2017\2017-04.dat.

#pass:
REPEAT:
  IMPORT UNFORMATTED cPass.
  DO i = 1 TO NUM-ENTRIES(cPass,' '):
    IF LOOKUP(ENTRY(i,cPass,' '),cPass,' ') < i THEN NEXT #pass.
  END.
  iNumValid = iNumValid + 1.
END.

MESSAGE iNumValid VIEW-AS ALERT-BOX INFORMATION.

/*---------------------------                 */
/*Information (Press HELP to view stack trace)*/
/*---------------------------                 */
/*466                                         */
/*---------------------------                 */
/*OK   Help                                   */
/*---------------------------                 */
