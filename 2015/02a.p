/* Advent of code #2a */

DEFINE VARIABLE cDimensions AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iWidth      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLength     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iHeight     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPaper      AS INTEGER     NO-UNDO.

INPUT FROM d:\Data\Dropbox\Progress\AdventOfCode\02-input.txt.

REPEAT:
    IMPORT cDimensions.
    iWidth  = INTEGER(ENTRY(1,cDimensions,'x')).
    iLength = INTEGER(ENTRY(2,cDimensions,'x')).
    iHeight = INTEGER(ENTRY(3,cDimensions,'x')).
    iPaper = iPaper 
           + 2 * iWidth * iLength
           + 2 * iWidth * iHeight
           + 2 * iLength * iHeight
           + MINIMUM(MINIMUM((iWidth * iLength),(iWidth * iHeight)),(iLength * iHeight))
        .
END.
INPUT CLOSE.

MESSAGE iPaper VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 1586300                     */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
