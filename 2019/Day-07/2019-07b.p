/* AoC 2019 day 7a
*/
DEFINE VARIABLE giData AS INTEGER EXTENT NO-UNDO INITIAL [{2019-07.dat}].
        
FUNCTION setVal RETURNS LOGICAL(i AS INT, v AS INT):
  giData[i + 1] = v. 
  RETURN TRUE. 
END FUNCTION. 

FUNCTION getVal RETURNS INTEGER(i AS INT):
  RETURN giData[i + 1].
END FUNCTION. 

&GLOBAL-DEFINE Position-Mode  '0'
&GLOBAL-DEFINE Immediate-Mode '1'

PROCEDURE intCode:
  DEFINE INPUT  PARAMETER pcInput  AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER piOutput AS INTEGER   NO-UNDO.

  DEFINE VARIABLE iInNr AS INTEGER   NO-UNDO INITIAL 1.
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
      WHEN 99 /* end */ THEN DO: RETURN. END.
      WHEN  1 /* add */ THEN DO: setVal( getVal(iPntr + 3), iParm[1] + iParm[2]). iPntr = iPntr + 4. END. 
      WHEN  2 /* mul */ THEN DO: setVal( getVal(iPntr + 3), iParm[1] * iParm[2]). iPntr = iPntr + 4. END.  
      WHEN  3 /* sav */ THEN DO: setVal( getVal(iPntr + 1), INTEGER(ENTRY(iInNr,pcInput))).  iInNr = iInNr + 1. iPntr = iPntr + 2. END. 
      WHEN  4 /* msg */ THEN DO: IF iParm[1] > 0 THEN piOutput = iParm[1]. iPntr = iPntr + 2. END. 
      WHEN  5 /* jit */ THEN DO: IF iParm[1] > 0 THEN iPntr = iParm[2]. ELSE iPntr = iPntr + 3. END. 
      WHEN  6 /* jif */ THEN DO: IF iParm[1] = 0 THEN iPntr = iParm[2]. ELSE iPntr = iPntr + 3. END. 
      WHEN  7 /* les */ THEN DO: IF iParm[1] < iParm[2] THEN setVal(getVal(iPntr + 3), 1). ELSE setVal(getVal(iPntr + 3), 0). iPntr = iPntr + 4. END. 
      WHEN  8 /* eql */ THEN DO: IF iParm[1] = iParm[2] THEN setVal(getVal(iPntr + 3), 1). ELSE setVal(getVal(iPntr + 3), 0). iPntr = iPntr + 4. END. 
    END CASE.
  END.

END PROCEDURE. 

DEFINE VARIABLE iOutput AS INTEGER NO-UNDO.
DEFINE VARIABLE iPhase  AS INTEGER NO-UNDO EXTENT 5.
DEFINE VARIABLE iAnswer AS INTEGER NO-UNDO.

DO iPhase[1] = 0 TO 4:

  DO iPhase[2] = 0 TO 4:
    IF iPhase[2] = iPhase[1] THEN NEXT.

    DO iPhase[3] = 0 TO 4:
      IF iPhase[3] = iPhase[2] THEN NEXT.
      IF iPhase[3] = iPhase[1] THEN NEXT.

      DO iPhase[4] = 0 TO 4:
        IF iPhase[4] = iPhase[3] THEN NEXT.
        IF iPhase[4] = iPhase[2] THEN NEXT.
        IF iPhase[4] = iPhase[1] THEN NEXT.

        DO iPhase[5] = 0 TO 4:
          IF iPhase[5] = iPhase[4] THEN NEXT.
          IF iPhase[5] = iPhase[3] THEN NEXT.
          IF iPhase[5] = iPhase[2] THEN NEXT.
          IF iPhase[5] = iPhase[1] THEN NEXT.

          RUN intCode(SUBSTITUTE('&1,&2',iPhase[1], 0      ), OUTPUT iOutput).
          RUN intCode(SUBSTITUTE('&1,&2',iPhase[2], iOutput), OUTPUT iOutput).
          RUN intCode(SUBSTITUTE('&1,&2',iPhase[3], iOutput), OUTPUT iOutput).
          RUN intCode(SUBSTITUTE('&1,&2',iPhase[4], iOutput), OUTPUT iOutput).
          RUN intCode(SUBSTITUTE('&1,&2',iPhase[5], iOutput), OUTPUT iOutput).

          iAnswer = MAXIMUM(iOutput,iAnswer).
        END.
      END.
    END.
  END.
END.

MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 11189491                    */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */
