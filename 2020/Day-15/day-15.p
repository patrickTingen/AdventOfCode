/* AoC 2020 day 15
 */
DEFINE TEMP-TABLE ttNr NO-UNDO
  FIELD iTurn   AS INTEGER /* turn nr */
  FIELD iNumber AS INTEGER /* what number */
  FIELD iPrev   AS INTEGER /* last time spoken */
  INDEX iPrim iTurn
  INDEX iNumber iNumber.
 
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cStart  AS CHARACTER NO-UNDO INITIAL '0,20,7,16,1,18,15'.
DEFINE VARIABLE iStart  AS INTEGER     NO-UNDO.

ETIME(YES).
DO i = 1 TO NUM-ENTRIES(cStart):
  RUN addNumber (i, ENTRY(i,cStart)).
END.

REPEAT:
  FIND LAST ttNr.

  IF (ETIME - iStart) > 1000 THEN 
  DO:
    HIDE MESSAGE NO-PAUSE.
    MESSAGE ttNr.iTurn.
    PROCESS EVENTS. 
    iStart = ETIME.
  END.

  IF ttNr.iPrev = 0 THEN 
    RUN addNumber(ttNr.iTurn + 1, 0).
  ELSE 
    RUN addNumber(ttNr.iTurn + 1, (ttNr.iTurn - ttNr.iPrev)).

  IF ttNr.iTurn = 2020 THEN DO:
    MESSAGE 'Part 1:' ttNr.iNumber SKIP 'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  END.
  
  IF ttNr.iTurn = 30000000 THEN DO:
    MESSAGE 'Part 2:' ttNr.iNumber SKIP 'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.
END.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 1025                */
/* Part 2: 129262              */
/* Time: 2727320               */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

PROCEDURE addNumber:
  DEFINE INPUT PARAMETER piTurn   AS INTEGER  NO-UNDO.
  DEFINE INPUT PARAMETER piNumber AS INTEGER  NO-UNDO.

  DEFINE VARIABLE iPrevTurn AS INTEGER     NO-UNDO.
  DEFINE BUFFER bNr FOR ttNr.

  FIND LAST bNr WHERE bNr.iNumber = piNumber NO-ERROR.
  IF AVAILABLE bNr THEN iPrevTurn = bNr.iTurn.

  CREATE bNr.
  ASSIGN 
    bNr.iTurn   = piTurn
    bNr.iNumber = piNumber
    bNr.iPrev   = iPrevTurn.

END PROCEDURE. 
