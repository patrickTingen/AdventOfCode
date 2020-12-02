/* AoC 2019 day 9a
*/
DEFINE VARIABLE giData AS INT64 EXTENT NO-UNDO INITIAL [{2019-09-1.dat}].
DEFINE VARIABLE giRam  AS INT64 EXTENT 4096.
        
FUNCTION setVal RETURNS LOGICAL(i AS INT64, v AS INT64):
  giRam[i + 1] = v. 
  RETURN TRUE. 
END FUNCTION. 

FUNCTION getVal RETURNS INT64(i AS INT64):
  RETURN giRam[i + 1].
END FUNCTION. 

FUNCTION loadRam RETURNS LOGICAL (piData AS INT64 EXTENT):
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  giRam = 0.
  DO i = 1 TO EXTENT(piData):
    giRam[i] = piData[i].
  END.
END FUNCTION.

&GLOBAL-DEFINE Position-Mode  '0'
&GLOBAL-DEFINE Immediate-Mode '1'
&GLOBAL-DEFINE Relative-Mode  '2'

PROCEDURE intCode:
  DEFINE INPUT  PARAMETER pcInput  AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER pcOutput AS CHARACTER NO-UNDO.

  DEFINE VARIABLE iInNr AS INT64     NO-UNDO INITIAL 1.
  DEFINE VARIABLE iPntr AS INT64     NO-UNDO.
  DEFINE VARIABLE cCode AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iCode AS INT64     NO-UNDO.
  DEFINE VARIABLE cMode AS CHARACTER NO-UNDO EXTENT 3.
  DEFINE VARIABLE iParm AS INT64     NO-UNDO EXTENT 3.
  DEFINE VARIABLE iBase AS INT64     NO-UNDO.
  DEFINE VARIABLE i     AS INT64     NO-UNDO.
  DEFINE VARIABLE cParamList AS CHARACTER NO-UNDO EXTENT 3 INITIAL ["1,2,4,5,6,7,8", "1,2,5,6,7,8", "1,2,7,8"].

  REPEAT:
    cCode = STRING(getVal(iPntr),'99999').

    cMode[1] = SUBSTRING(cCode,3,1).
    cMode[2] = SUBSTRING(cCode,2,1).
    cMode[3] = SUBSTRING(cCode,1,1).
    iCode    = getVal(iPntr) MOD 100.

    DISPLAY iCode cmode[1] cmode[2] cmode[3].

    iParm = 0.

    DO i = 1 TO 3:
      iParm[i] = getVal( IF cMode[i] = '1' THEN iPntr + i ELSE IF cMode[i] = '2' THEN getVal(iPntr + i) + iBase ELSE getVal(iPntr + i) ).
    END.

/*       IF LOOKUP(STRING(iCode), cParamList[i]) > 0 THEN                */
/*       DO:                                                             */
/*         CASE cMode[i]:                                                */
/*           WHEN '1' THEN iParm[i] = getVal(iPntr + i).                 */
/*           WHEN '0' THEN iParm[i] = getVal(getVal(iPntr + i)).         */
/*           WHEN '2' THEN iParm[i] = getVal(getVal(iPntr + i) + iBase). */
/*         END CASE.                                                     */
/*       END.                                                            */

    CASE iCode:
      WHEN  1 /* add */ THEN DO: 
        setVal( iParm[3], iParm[1] + iParm[2]). 
        iPntr = iPntr + 4. 
      END. 

      WHEN  2 /* mul */ THEN DO: 
        setVal( iParm[3], iParm[1] * iParm[2]). 
        iPntr = iPntr + 4. 
      END.  

      WHEN  3 /* sav */ THEN DO: 
        setVal( iParm[1], INT64(ENTRY(iInNr,pcInput))).  
        iInNr = iInNr + 1. 
        iPntr = iPntr + 2. 
      END. 

      WHEN  4 /* msg */ THEN DO: 
        IF iParm[1] > 0 THEN pcOutput = pcOutput + "," + STRING(iParm[1]). 
        iPntr = iPntr + 2. 
      END. 

      WHEN  5 /* jit */ THEN DO: 
        iPntr = (IF iParm[1] > 0 THEN iParm[2] ELSE iPntr + 3).
      END. 

      WHEN  6 /* jif */ THEN DO: 
        iPntr = (IF iParm[1] = 0 THEN iParm[2] ELSE iPntr + 3).
      END. 

      WHEN  7 /* les */ THEN DO: 
        setVal(iParm[3], (IF iParm[1] < iParm[2] THEN 1 ELSE 0)). 
        iPntr = iPntr + 4. 
      END. 

      WHEN  8 /* eql */ THEN DO: 
        setVal(iParm[3], (IF iParm[1] = iParm[2] THEN 1 ELSE 0)). 
        iPntr = iPntr + 4. 
      END. 

      WHEN  9 /* rel */ THEN DO: 
        iBase = iBase + iParm[1]. 
        iPntr = iPntr + 2. 
      END. 

      WHEN 99 /* end */ THEN DO: 
        RETURN. 
      END.
    END CASE.
  END.

END PROCEDURE. 


DEFINE VARIABLE cOutput AS CHARACTER NO-UNDO.
DEFINE VARIABLE iPhase  AS INT64 NO-UNDO EXTENT 5.
DEFINE VARIABLE iAnswer AS INT64 NO-UNDO.

loadRam(giData).

RUN intCode('', OUTPUT cOutput).
MESSAGE cOutput VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/*                                                                                */
/* DO iPhase[1] = 0 TO 4:                                                         */
/*                                                                                */
/*   DO iPhase[2] = 0 TO 4:                                                       */
/*     IF iPhase[2] = iPhase[1] THEN NEXT.                                        */
/*                                                                                */
/*     DO iPhase[3] = 0 TO 4:                                                     */
/*       IF iPhase[3] = iPhase[2] THEN NEXT.                                      */
/*       IF iPhase[3] = iPhase[1] THEN NEXT.                                      */
/*                                                                                */
/*       DO iPhase[4] = 0 TO 4:                                                   */
/*         IF iPhase[4] = iPhase[3] THEN NEXT.                                    */
/*         IF iPhase[4] = iPhase[2] THEN NEXT.                                    */
/*         IF iPhase[4] = iPhase[1] THEN NEXT.                                    */
/*                                                                                */
/*         DO iPhase[5] = 0 TO 4:                                                 */
/*           IF iPhase[5] = iPhase[4] THEN NEXT.                                  */
/*           IF iPhase[5] = iPhase[3] THEN NEXT.                                  */
/*           IF iPhase[5] = iPhase[2] THEN NEXT.                                  */
/*           IF iPhase[5] = iPhase[1] THEN NEXT.                                  */
/*                                                                                */
/*           RUN intCode(SUBSTITUTE('&1,&2',iPhase[1], 0      ), OUTPUT iOutput). */
/*           RUN intCode(SUBSTITUTE('&1,&2',iPhase[2], iOutput), OUTPUT iOutput). */
/*           RUN intCode(SUBSTITUTE('&1,&2',iPhase[3], iOutput), OUTPUT iOutput). */
/*           RUN intCode(SUBSTITUTE('&1,&2',iPhase[4], iOutput), OUTPUT iOutput). */
/*           RUN intCode(SUBSTITUTE('&1,&2',iPhase[5], iOutput), OUTPUT iOutput). */
/*                                                                                */
/*           iAnswer = MAXIMUM(iOutput,iAnswer).                                  */
/*         END.                                                                   */
/*       END.                                                                     */
/*     END.                                                                       */
/*   END.                                                                         */
/* END.                                                                           */
/*                                                                                */
/* MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.                      */

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 77500                       */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */


