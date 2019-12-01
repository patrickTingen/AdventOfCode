/* Advent of code 2018
** day 7
*/
&GLOBAL-DEFINE MAX-WORKERS 5
&GLOBAL-DEFINE JOB-TIME    60
&GLOBAL-DEFINE DATA-FILE   '2018-07.dat'

DEFINE VARIABLE giTime AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttStep
  FIELD cStep  AS CHARACTER
  FIELD lDone  AS LOGICAL
  FIELD lWait  AS LOGICAL
  FIELD iTime  AS INTEGER
  FIELD lBusy  AS LOGICAL
  FIELD iStart AS INTEGER
  INDEX iPrim cStep.

DEFINE TEMP-TABLE ttDep
  FIELD cStep AS CHARACTER
  FIELD cPrev AS CHARACTER.

FUNCTION logMsg RETURNS LOGICAL(pcMsg AS CHARACTER):
  OUTPUT TO "2018-07-debug.dat" APPEND.
  PUT UNFORMATTED SUBSTITUTE('&1 &2', giTime, pcMsg) SKIP.
  OUTPUT CLOSE. 
END. 

FUNCTION getNext RETURNS CHARACTER():
  DEFINE BUFFER bStep FOR ttStep.
  FOR EACH bStep WHERE bStep.lDone = NO AND bStep.lWait = YES BY bStep.cStep:
    RETURN bStep.cStep.
  END. 
  RETURN ''.
END.

FUNCTION activeWorkers RETURNS INTEGER():
  DEFINE BUFFER bStep FOR ttStep.
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  FOR EACH bStep WHERE bStep.lBusy = TRUE: i = i + 1. END.
  RETURN i.
END FUNCTION. 


FUNCTION setBusy RETURNS LOGICAL (pcStep AS CHARACTER, piTime AS INTEGER):
  DEFINE BUFFER bStep FOR ttStep.
  DEFINE BUFFER bPrev FOR ttStep.
  DEFINE BUFFER bDep  FOR ttDep. 
  
  DEFINE VARIABLE lWaiting AS LOGICAL NO-UNDO.
  
  IF activeWorkers() >= {&MAX-WORKERS} THEN RETURN FALSE. 
  
  FIND bStep WHERE bStep.cStep = pcStep.
  ASSIGN 
    bStep.lBusy = TRUE 
    bStep.lWait = FALSE
    bStep.iStart = piTime.
  logMsg(SUBSTITUTE('set &1 to busy', bStep.cStep)).
  RETURN TRUE.
END.

FUNCTION setDone RETURNS LOGICAL (piTime AS INTEGER ):
  DEFINE BUFFER bStep FOR ttStep.
  
  FOR EACH bStep 
    WHERE bStep.lBusy = TRUE
      AND bStep.iStart + bStep.iTime - 1 = piTime:
    ASSIGN 
      bStep.lDone = TRUE 
      bStep.lWait = FALSE 
      bStep.lBusy = FALSE.
    logMsg(SUBSTITUTE('set &1 to done', bStep.cStep)).
  END. 
  RETURN TRUE.
END. 

FUNCTION setWait RETURNS LOGICAL():  
  DEFINE BUFFER bStep FOR ttStep.
  DEFINE BUFFER bPrev FOR ttStep.
  DEFINE BUFFER bDep  FOR ttDep. 
  
  FOR EACH bStep WHERE bStep.lDone = FALSE AND bStep.lBusy = FALSE:
    bStep.lWait = TRUE.
    FOR EACH bDep WHERE bDep.cStep = bStep.cStep
      , EACH bPrev WHERE bPrev.cStep = bDep.cPrev AND bPrev.lDone = FALSE:
      bStep.lWait = FALSE.
    END. 
  END.
  RETURN TRUE.
END.

PROCEDURE main:
  DEFINE VARIABLE cStepId AS CHARACTER NO-UNDO.
  OS-DELETE "2018-07-debug.dat".

  #main:
  REPEAT:
  
    #SetNext:
    REPEAT:
      cStepId = getNext().
      IF cStepId = '' THEN LEAVE #SetNext.
      IF NOT setBusy(cStepId,giTime) THEN LEAVE #SetNext.
    END.
    
    setDone(giTime).
    setWait().
    
    giTime = giTime + 1.
    
    /* Finished? */
    IF NOT CAN-FIND(FIRST ttStep WHERE ttStep.lDone = NO) THEN
    DO:
      MESSAGE giTime VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      LEAVE #Main.      
    END.
  END.
  
END. 

RUN readData({&DATA-FILE}).
setWait().
RUN main.

FUNCTION createStep RETURNS LOGICAL(pcStep AS CHARACTER):
  DEFINE BUFFER bStep FOR ttStep.
  FIND bStep WHERE bStep.cStep = pcStep NO-ERROR.
  IF NOT AVAILABLE bStep THEN DO:
    CREATE bStep.
    ASSIGN bStep.cStep = pcStep
           bStep.iTime = ASC(pcStep) - 64 + {&JOB-TIME}.
  END.
END FUNCTION. 

PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iLine AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.

  DEFINE BUFFER bDep FOR ttDep. 

  COPY-LOB FILE pcFile TO cData. 
  DO iLine = 1 TO NUM-ENTRIES(cData,'~n').
    cLine = ENTRY(iLine,cData,'~n').
    CREATE bDep.
    ASSIGN 
      bDep.cPrev = ENTRY(2,cLine,' ')
      bDep.cStep = ENTRY(8,cLine,' ')      .

    createStep(bDep.cStep).
    createStep(bDep.cPrev).
  END.
END PROCEDURE. 

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* GNJOCHKSWTFMXLYDZABIREPVUQ  */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
