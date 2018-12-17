/* Advent of code 2018
** day 12a
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
DEFINE VARIABLE iSum        AS INTEGER   NO-UNDO.

INPUT FROM '2018-12-test.dat'.
IMPORT UNFORMATTED cLine.
cState = '...' + TRIM(ENTRY(2,cLine,':')) + '....'.

REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' THEN NEXT. 
  CREATE ttRule.
  ASSIGN 
    ttRule.cCondition = TRIM(ENTRY(1,cLine,'='))
    ttRule.cPlant     = (IF cLine MATCHES '*=> #*' THEN '#' ELSE '.').
END.
INPUT CLOSE. 

DO iGeneration = 1 TO 20:
  cNewState = cState.
  DO iPot = 1 TO LENGTH(cState):
    cChunk = SUBSTRING(cState, iPot, 5).
    FIND FIRST ttRule WHERE ttRule.cCondition = cChunk NO-ERROR. /* ..#.. */
    OVERLAY(cNewState,iPot + 2,1) = (IF AVAILABLE ttRule THEN ttRule.cPlant ELSE '.').
  END.
  cState = cNewState.
END.

DO iPot = 1 TO LENGTH(cState) - 2:
  IF SUBSTRING(cState,iPot,1) = '#' THEN iSum = iSum + (iPot - 4).
END. 

MESSAGE iSum
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

