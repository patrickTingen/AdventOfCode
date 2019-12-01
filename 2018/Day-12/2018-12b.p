/* Advent of code 2018
** day 12b
*/
DEFINE TEMP-TABLE ttRule
  FIELD cCondition AS CHARACTER
  FIELD cPlant     AS CHARACTER
  INDEX iPrim cCondition.

DEFINE VARIABLE cState      AS CHARACTER NO-UNDO.
DEFINE VARIABLE cNewState   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLine       AS CHARACTER NO-UNDO.
DEFINE VARIABLE iGeneration AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPot        AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChunk      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSum        AS INT64     NO-UNDO.
DEFINE VARIABLE iOffset     AS INT64     NO-UNDO.

INPUT FROM '2018-12.dat'.
IMPORT UNFORMATTED cLine.
cState = TRIM(ENTRY(2,cLine,':')) + '..'.
iOffset = 0.

REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' THEN NEXT. 
  CREATE ttRule.
  ASSIGN 
    ttRule.cCondition = TRIM(ENTRY(1,cLine,'='))
    ttRule.cPlant     = (IF cLine MATCHES '*=> #*' THEN '#' ELSE '.').
END.
INPUT CLOSE. 

OUTPUT TO '2018-12-debug.txt'.
REPEAT:
  iGeneration = iGeneration + 1.
  IF NOT cState BEGINS '....' THEN ASSIGN cState = '....' + cState iOffset = iOffset - 4.
  IF NOT SUBSTRING(cState, LENGTH(cState) - 4,4) = '....' THEN cState = cState + '....'.

  cNewState = cState.
  DO iPot = 1 TO LENGTH(cState) - 2:
    cChunk = SUBSTRING(cState, iPot, 5).
    FIND FIRST ttRule WHERE ttRule.cCondition = cChunk NO-ERROR. /* ..#.. */
    OVERLAY(cNewState,iPot + 2,1) = (IF AVAILABLE ttRule THEN ttRule.cPlant ELSE '.').
  END.
  cState = cNewState.

  PUT UNFORMATTED STRING(iGeneration,'>>>>9') ': ' cState SKIP.
  IF iGeneration = 111 THEN LEAVE. /* repeating after 111 generations */
END.

/* Pattern repeats from generation 111 and shifts 1 to the right on each gen. */
iOffset = iOffset + 50000000000 - 111 + 1.
iSum = 0.
DO iPot = 0 TO LENGTH(cState) - 1:
  IF SUBSTRING(cState,iPot + 1,1) = '#' THEN iSum = iSum + (iPot - 1 + iOffset).
END. 

MESSAGE iSum VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


