/*------------------------------------------------------------------------
    File        : 2017-02a.p
    Purpose     : Day 2 of AoC 2017

    5-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE iInput AS INTEGER NO-UNDO EXTENT 16.
DEFINE VARIABLE iMax   AS INTEGER NO-UNDO.
DEFINE VARIABLE iMin   AS INTEGER NO-UNDO.
DEFINE VARIABLE iSum   AS INTEGER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER NO-UNDO.

INPUT FROM c:\Data\DropBox\AdventOfCode\2017\2017-02.dat.

REPEAT:
  IMPORT iInput.

  iMax = iInput[1].
  iMin = iInput[1].

  DO i = 2 TO 16:
    iMax = MAXIMUM(iMax,iInput[i]).
    iMin = MINIMUM(iMin,iInput[i]).
  END.
  iSum = iSum + (iMax - iMin).
END.

MESSAGE iSum VIEW-AS ALERT-BOX INFORMATION.

/*---------------------------                 */
/*Information (Press HELP to view stack trace)*/
/*---------------------------                 */
/*41887                                       */
/*---------------------------                 */
/*OK   Help                                   */
/*---------------------------                 */
