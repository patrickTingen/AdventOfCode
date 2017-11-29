/* Advent Of Code 2016, day 3, part 2 */

FUNCTION validTriangle RETURNS LOGICAL
  ( iSide-1 AS INTEGER
  , iSide-2 AS INTEGER
  , iSide-3 AS INTEGER):
  
  RETURN iSide-1 + iSide-2 > iSide-3
     AND iSide-1 + iSide-3 > iSide-2
     AND iSide-2 + iSide-3 > iSide-1 .

END FUNCTION. /* validTriangle */

DEFINE VARIABLE iSide-1 AS INTEGER EXTENT 3 NO-UNDO.
DEFINE VARIABLE iSide-2 AS INTEGER EXTENT 3 NO-UNDO.
DEFINE VARIABLE iSide-3 AS INTEGER EXTENT 3 NO-UNDO.
DEFINE VARIABLE iValid AS INTEGER NO-UNDO.

INPUT FROM 'd:\Data\Dropbox\AdventOfCode\2016-03-input.txt'.
REPEAT :

  IMPORT iSide-1.
  IMPORT iSide-2.
  IMPORT iSide-3.

  IF ValidTriangle(iSide-1[1], iSide-2[1], iSide-3[1]) THEN iValid = iValid + 1.
  IF ValidTriangle(iSide-1[2], iSide-2[2], iSide-3[2]) THEN iValid = iValid + 1.
  IF ValidTriangle(iSide-1[3], iSide-2[3], iSide-3[3]) THEN iValid = iValid + 1.

END.
INPUT CLOSE.

MESSAGE iValid
  VIEW-AS ALERT-BOX INFO BUTTONS OK.
