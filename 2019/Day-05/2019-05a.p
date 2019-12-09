/* AoC 2019 day 5a
*/
DEFINE VARIABLE iData  AS INTEGER EXTENT NO-UNDO INITIAL [{2019-05.dat}].
        
FUNCTION setVal RETURNS LOGICAL(i AS INT, v AS INT):
  iData[i + 1] = v. 
  RETURN TRUE. 
END FUNCTION. 

FUNCTION getVal RETURNS INTEGER(i AS INT):
  RETURN iData[i + 1].
END FUNCTION. 

&GLOBAL-DEFINE Position-Mode  '0'
&GLOBAL-DEFINE Immediate-Mode '1'

FUNCTION compute RETURNS INTEGER(piInput AS INTEGER):

  DEFINE VARIABLE iPntr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cCode AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iCode AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cMode AS CHARACTER NO-UNDO EXTENT 2.
  DEFINE VARIABLE iParm AS INTEGER   NO-UNDO EXTENT 2.

  REPEAT:
    cCode = STRING(getVal(iPntr),'99999').

    cMode[1] = SUBSTRING(cCode,3,1).
    cMode[2] = SUBSTRING(cCode,2,1).
    iCode  = getVal(iPntr) MOD 100.

    iParm = 0.
    IF LOOKUP(STRING(iCode), "1,2,4,5,6,7,8") > 0 THEN iParm[1] = (IF cMode[1] = {&Position-Mode} THEN getVal(getVal(iPntr + 1)) ELSE getVal(iPntr + 1)). 
    IF LOOKUP(STRING(iCode), "1,2,5,6,7,8")   > 0 THEN iParm[2] = (IF cMode[2] = {&Position-Mode} THEN getVal(getVal(iPntr + 2)) ELSE getVal(iPntr + 2)). 

    CASE iCode:
      WHEN 99 /* end */ THEN DO: RETURN -1. END.
      WHEN  1 /* add */ THEN DO: setVal( getVal(iPntr + 3), iParm[1] + iParm[2]). iPntr = iPntr + 4. END. 
      WHEN  2 /* mul */ THEN DO: setVal( getVal(iPntr + 3), iParm[1] * iParm[2]). iPntr = iPntr + 4. END.  
      WHEN  3 /* sav */ THEN DO: setVal( getVal(iPntr + 1), piInput).  iPntr = iPntr + 2. END. 
      WHEN  4 /* msg */ THEN DO: IF iParm[1] > 0 THEN MESSAGE 'output:' iParm[1] VIEW-AS ALERT-BOX. iPntr = iPntr + 2. END. 
    END CASE.

  END.

  RETURN -1.
END FUNCTION.

compute(1).

/* --------------------------- */
/* Message                     */
/* --------------------------- */
/* output: 13978427            */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

