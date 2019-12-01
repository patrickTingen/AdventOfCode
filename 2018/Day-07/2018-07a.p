/* Advent of code 2018
** day 7
*/
DEFINE TEMP-TABLE ttStep
  FIELD cStep AS CHARACTER
  FIELD lDone AS LOGICAL
  FIELD lWait AS LOGICAL
  INDEX iPrim cStep.

DEFINE TEMP-TABLE ttDep
  FIELD cStep AS CHARACTER
  FIELD cPrev AS CHARACTER.

RUN readData('2018-07.dat').
RUN main.

FUNCTION getNext RETURNS CHARACTER():
  DEFINE BUFFER bStep FOR ttStep.
  FOR EACH bStep WHERE bStep.lDone = NO AND bStep.lWait = YES BY bStep.cStep:
    RETURN bStep.cStep.
  END. 
  RETURN ''.
END.

FUNCTION setDone RETURNS LOGICAL (pcStep AS CHARACTER):
  DEFINE BUFFER bStep FOR ttStep.
  DEFINE BUFFER bPrev FOR ttStep.
  DEFINE BUFFER bDep  FOR ttDep. 
  DEFINE VARIABLE lWaiting AS LOGICAL NO-UNDO.

  FIND bStep WHERE bStep.cStep = pcStep.
  ASSIGN bStep.lDone = TRUE bStep.lWait = FALSE.

  FOR EACH bStep WHERE bStep.lDone = FALSE:
    bStep.lWait = TRUE.
    FOR EACH bDep WHERE bDep.cStep = bStep.cStep
      , EACH bPrev WHERE bPrev.cStep = bDep.cPrev AND bPrev.lDone = FALSE:
      bStep.lWait = FALSE.
    END. 
  END.
  RETURN TRUE.
END.

PROCEDURE main:
  DEFINE BUFFER bStep FOR ttStep.
  DEFINE BUFFER bDep  FOR ttDep. 

  DEFINE VARIABLE cList AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cStepId AS CHARACTER NO-UNDO.

  /* Find first step (steps without dependencies) */
  #setFirst:
  FOR EACH bStep WHERE NOT CAN-FIND(FIRST bDep WHERE bDep.cStep = bStep.cStep) BY bStep.cStep:
    cList = bStep.cStep.
    setDone(bStep.cStep).
    LEAVE #setFirst.
  END.
  
  #SetNext:
  REPEAT:
    cStepId = getNext().
    IF cStepId = '' THEN LEAVE #SetNext.
    cList = cList + cStepId.
    setDone(cStepId).
  END.
  
  MESSAGE cList VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END. 

FUNCTION createStep RETURNS LOGICAL(pcStep AS CHARACTER):
  DEFINE BUFFER bStep FOR ttStep.
  FIND bStep WHERE bStep.cStep = pcStep NO-ERROR.
  IF NOT AVAILABLE bStep THEN DO:
    CREATE bStep.
    ASSIGN bStep.cStep = pcStep.
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
      bDep.cStep = ENTRY(8,cLine,' ').

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