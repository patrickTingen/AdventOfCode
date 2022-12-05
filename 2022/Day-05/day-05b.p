/* AoC 2022 day 05b
 */ 
DEFINE TEMP-TABLE ttStack NO-UNDO
  FIELD iStackId   AS INTEGER
  FIELD iElementNr AS INTEGER
  FIELD cData      AS CHARACTER 
  INDEX iPrim IS PRIMARY iStackId iElementNr.

FUNCTION push RETURNS LOGICAL (piStackId AS INTEGER, pcData AS CHARACTER):
  DEFINE BUFFER bStack FOR ttStack.

  DEFINE VARIABLE iTop AS INTEGER NO-UNDO.
  DEFINE VARIABLE i    AS INTEGER NO-UNDO.

  IF pcData = "" THEN RETURN NO.

  FIND LAST bStack WHERE bStack.iStackId = piStackId NO-ERROR.
  iTop = (IF AVAILABLE bStack THEN bStack.iElementNr ELSE 0). 

  DO i = 1 TO NUM-ENTRIES(pcData):
  
    iTop = iTop + 1.

    CREATE bStack.
    ASSIGN 
      bStack.iStackId   = piStackId
      bStack.iElementNr = iTop
      bStack.cData      = ENTRY(i,pcData).
  END.

  RETURN YES.
END FUNCTION. /* push */


FUNCTION pop RETURNS CHARACTER (piStackId AS INTEGER, piNum AS INTEGER):
  DEFINE BUFFER bStack FOR ttStack.
  DEFINE VARIABLE cValue AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i      AS INTEGER   NO-UNDO.

  IF piNum = 1 THEN 
  DO:
    FIND LAST bStack WHERE bStack.iStackId = piStackId NO-ERROR.
    IF AVAILABLE bStack THEN 
    DO:
      cValue = bStack.cData.
      DELETE bStack.
    END.
    RETURN cValue.
  END.

  ELSE
  DO:
    DO i = 1 TO piNum:
      cValue = pop(piStackId,1) + "," + cValue.
    END.
    RETURN TRIM(cValue,",").
  END.

END FUNCTION. /* pop */


DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iStacks AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE j       AS INTEGER   NO-UNDO.
DEFINE VARIABLE k       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMove   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFrom   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTo     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cAnswer AS CHARACTER NO-UNDO.

COPY-LOB FILE "data.txt" TO cData.

#ReadStacks:
DO i = 1 TO NUM-ENTRIES(cData,'~n'):
  cLine = TRIM(ENTRY(i, cData, '~n')).
  IF cLine BEGINS '1' THEN LEAVE #ReadStacks.
END.

DO j = (i - 1) TO 1 BY -1:
  cLine = ENTRY(j, cData, '~n').

  DO k = 1 TO 9:
    push(k, SUBSTRING(cLine, (k * 4) - 2,1)).
  END.
END.

#ReadMoves:
DO i = 1 TO NUM-ENTRIES(cData,'~n'):
  cLine = TRIM(ENTRY(i, cData, '~n')).
  IF NOT cLine BEGINS 'move' THEN NEXT #ReadMoves.

  iMove = INTEGER(ENTRY(2, cLine, ' ')).
  iFrom = INTEGER(ENTRY(4, cLine, ' ')).
  iTo   = INTEGER(ENTRY(6, cLine, ' ')).

  push(iTo, pop(iFrom, iMove)).

END.

FOR EACH ttStack BREAK BY ttStack.iStackId:
  IF LAST-OF(ttStack.iStackId) THEN 
    cAnswer = cAnswer + pop(ttStack.iStackId,1).
END.

MESSAGE cAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

