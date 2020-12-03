/* Advent of code 2020 - day 3a
*/
FUNCTION getNumTrees RETURNS INTEGER
  ( piRight AS INTEGER
  , piDown  AS INTEGER ):

  DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iPos   AS INTEGER   NO-UNDO INITIAL 1.
  DEFINE VARIABLE iTrees AS INTEGER   NO-UNDO.
  
  INPUT FROM day-03.dat.
  REPEAT:
    IMPORT cLine.
    IF SUBSTRING(cLine,iPos,1) = '#' THEN iTrees = iTrees + 1.
    iPos = iPos + piRight.
    IF iPos > LENGTH(cLine) THEN iPos = iPos - LENGTH(cLine).
    DO i = 1 TO piDown - 1:
      IMPORT cLine.
    END.
  END.
  INPUT CLOSE. 

  RETURN iTrees.
END FUNCTION. 

MESSAGE 
  'Part 1:' getNumTrees(3,1) SKIP
  'Part 2:' getNumTrees(1,1) * getNumTrees(3,1) * getNumTrees(5,1) * getNumTrees(7,1) * getNumTrees(1,2) 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* ---------------------------                  */
/* Information (Press HELP to view stack trace) */
/* ---------------------------                  */
/* Part 1: 171                                  */
/* Part 2: 1206576000                           */
/* ---------------------------                  */
/* OK   Help                                    */
/* ---------------------------                  */

