/* AoC 2015 day 02 
 */ 
DEFINE VARIABLE cDimensions AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iWidth      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLength     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iHeight     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPaper      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRibbon     AS INTEGER     NO-UNDO.

INPUT FROM data.txt.

REPEAT:
  IMPORT cDimensions.

  iWidth  = INTEGER(ENTRY(1,cDimensions,'x')).
  iLength = INTEGER(ENTRY(2,cDimensions,'x')).
  iHeight = INTEGER(ENTRY(3,cDimensions,'x')).

  iPaper = iPaper
         + 2 * iWidth * iLength
         + 2 * iWidth * iHeight
         + 2 * iLength * iHeight
         + MINIMUM(MINIMUM((iWidth * iLength),(iWidth * iHeight)),(iLength * iHeight)).

  iRibbon = iRibbon + 2 * (iWidth + iHeight + iLength 
                    - MAX(MAX(iWidth,iLength),iHeight))
                    + (iWidth * iHeight * iLength).

END.
INPUT CLOSE.

MESSAGE "Part 1:" iPaper SKIP 
        "Part 2:" iRibbon VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 1606483             */
/* Part 2: 3842356             */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
/*                             */
