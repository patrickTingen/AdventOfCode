/* Advent of code 2019
** day 1a
*/
DEFINE VARIABLE iSum  AS INTEGER NO-UNDO.
DEFINE VARIABLE iMass AS INTEGER NO-UNDO.

INPUT FROM "2019-01.dat".
REPEAT:
  IMPORT iMass.
  iSum = iSum + TRUNCATE(iMass / 3,0) - 2.
END.

MESSAGE iSum VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 3330521                     */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
