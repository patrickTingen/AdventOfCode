/* Advent Of Code 2016, day 3 */
DEFINE VARIABLE iSide AS INTEGER EXTENT 3 NO-UNDO.
DEFINE VARIABLE iValid AS INTEGER NO-UNDO.

INPUT FROM 'd:\Data\Dropbox\AdventOfCode\2016-03-input.txt'.
REPEAT :
  IMPORT iSide.

  IF    iSide[1] + iSide[2] > iSide[3]
    AND iSide[1] + iSide[3] > iSide[2]
    AND iSide[2] + iSide[3] > iSide[1] THEN iValid = iValid + 1.

END.
INPUT CLOSE.

MESSAGE iValid
  VIEW-AS ALERT-BOX INFO BUTTONS OK.