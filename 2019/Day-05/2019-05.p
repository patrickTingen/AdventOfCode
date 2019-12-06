/* AoC 2019 day 5
*/
DEFINE VARIABLE iData  AS INTEGER EXTENT NO-UNDO INITIAL [{2019-05.dat}].
DEFINE VARIABLE iInput AS INTEGER NO-UNDO INITIAL 1.
        
FUNCTION setVal RETURNS LOGICAL(i AS INT, v AS INT):
  iData[i + 1] = v. 
  RETURN TRUE. 
END FUNCTION. 

FUNCTION getVal RETURNS INTEGER(i AS INT):
  RETURN iData[i + 1].
END FUNCTION. 


FUNCTION compute RETURNS INTEGER():
  DEFINE VARIABLE iPntr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cCode AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iCode AS INTEGER   NO-UNDO.
  DEFINE VARIABLE lMode AS LOGICAL   NO-UNDO EXTENT 2.
  DEFINE VARIABLE iParm AS INTEGER   NO-UNDO EXTENT 2.

  REPEAT:
    cCode = STRING(getVal(iPntr),'99999').

    lMode[1] = (SUBSTRING(cCode,3,1) = '0').
    lMode[2] = (SUBSTRING(cCode,2,1) = '0').
    iCode  = getVal(iPntr) MOD 100.

    iParm = 0.
    IF LOOKUP(STRING(iCode), "1,2,4") > 0 THEN iParm[1] = (IF lMode[1] THEN getVal(getVal(iPntr + 1)) ELSE getVal(iPntr + 1)). 
    IF LOOKUP(STRING(iCode), "1,2")   > 0 THEN iParm[2] = (IF lMode[2] THEN getVal(getVal(iPntr + 2)) ELSE getVal(iPntr + 2)). 

    CASE iCode:
      WHEN 99 THEN RETURN -1. 
      WHEN  1 THEN DO: setVal( getVal(iPntr + 3), iParm[1] + iParm[2]). iPntr = iPntr + 4. END.
      WHEN  2 THEN DO: setVal( getVal(iPntr + 3), iParm[1] * iParm[2]). iPntr = iPntr + 4. END.
      WHEN  3 THEN DO: setVal( getVal(iPntr + 1), iInput). iPntr = iPntr + 2. END.
      WHEN  4 THEN DO: IF iParm[1] > 0 THEN MESSAGE 'output:' iParm[1] VIEW-AS ALERT-BOX. iPntr = iPntr + 2. END.
    END CASE.
  END.

  RETURN -1.
END FUNCTION.

/* setVal(1,12). */
/* setVal(2,2).  */

compute().


/* --------------------------- */
/* Message                     */
/* --------------------------- */
/* output: 13978427            */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

