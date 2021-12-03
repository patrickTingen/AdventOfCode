/* AoC 2015 day 01 
 */ 
DEFINE VARIABLE cData     AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i         AS INTEGER  NO-UNDO.
DEFINE VARIABLE iFloor    AS INTEGER  NO-UNDO.
DEFINE VARIABLE iBasement AS INTEGER  NO-UNDO.

COPY-LOB FILE "data.txt" TO cData.

DO i = 1 TO LENGTH(cData):
  IF SUBSTRING(cData,i,1) = '(' THEN iFloor = iFloor + 1.
  IF SUBSTRING(cData,i,1) = ')' THEN iFloor = iFloor - 1.
  IF iFloor < 0 AND iBasement = 0 THEN iBasement = i.
END.

MESSAGE 'Part 1:' iFloor SKIP
        'Part 2:' iBasement
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 280                 */
/* Part 2: 1797                */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
