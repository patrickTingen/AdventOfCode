/* Advent of code #2a */

DEFINE VARIABLE cDimensions AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iWidth      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLength     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iHeight     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRibbon     AS INTEGER     NO-UNDO.

INPUT FROM d:\Data\Dropbox\Progress\AdventOfCode\02-input.txt.

REPEAT:
    IMPORT cDimensions.

    iWidth  = INTEGER(ENTRY(1,cDimensions,'x')).
    iLength = INTEGER(ENTRY(2,cDimensions,'x')).
    iHeight = INTEGER(ENTRY(3,cDimensions,'x')).

    iRibbon = iRibbon + 2 * (iWidth + iHeight + iLength - MAX(MAX(iWidth,iLength),iHeight))
                      + (iWidth * iHeight * iLength).
END.
INPUT CLOSE.

MESSAGE iRibbon VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 3737498                     */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

