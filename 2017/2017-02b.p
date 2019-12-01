/*------------------------------------------------------------------------
    File        : 2017-02b.p
    Purpose     : Day 2 of AoC 2017

    5-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE iInput AS INTEGER NO-UNDO EXTENT 16.
DEFINE VARIABLE iMax   AS INTEGER NO-UNDO.
DEFINE VARIABLE iMin   AS INTEGER NO-UNDO.
DEFINE VARIABLE iSum   AS INTEGER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER NO-UNDO.
DEFINE VARIABLE j      AS INTEGER NO-UNDO.

INPUT FROM c:\Data\DropBox\AdventOfCode\2017\2017-02.dat.

REPEAT:
  IMPORT iInput.

  DO i = 1 TO 16:
    loop:
    DO j = 1 TO 16:
      IF i = j THEN NEXT loop.
      IF (iInput[i] / iInput[j]) = trunc(iInput[i] / iInput[j],0) THEN iSum = iSUm + (iInput[i] / iInput[j]).
    END.
  END.
END.

MESSAGE iSum VIEW-AS ALERT-BOX INFORMATION.

/*---------------------------                 */
/*Information (Press HELP to view stack trace)*/
/*---------------------------                 */
/*226                                         */
/*---------------------------                 */
/*OK   Help                                   */
/*---------------------------                 */
