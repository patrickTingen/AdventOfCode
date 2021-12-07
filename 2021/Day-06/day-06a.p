/* AoC 2021 day 06a
 */ 
DEFINE TEMP-TABLE ttFish NO-UNDO
  FIELD iFishId AS INTEGER
  FIELD iTimer  AS INTEGER
  .

DEFINE VARIABLE seqFish AS INTEGER   NO-UNDO.
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDay    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cFish   AS CHARACTER NO-UNDO.

FUNCTION addFish RETURNS INTEGER(piTimer AS INTEGER):
  DEFINE BUFFER btFish FOR ttFish.

  seqFish = seqFish + 1.
  CREATE btFish.
  ASSIGN btFish.iFishId = seqFish
         btFish.iTimer  = piTimer.

END FUNCTION.

COPY-LOB FILE "c:\Data\DropBox\AdventOfCode\2021\Day-06\data.txt" TO cData.
DO i = 1 TO NUM-ENTRIES(cData):
  addFish(INTEGER(ENTRY(i,cData))).
END.

DO iDay = 1 TO 80:

  FOR EACH ttFish WHERE ttFish.iFishId <= seqFish:
    ttFish.iTimer = ttFish.iTimer - 1.
    IF ttFish.iTimer = -1 THEN 
    DO:
      addFish(8).
      ttFish.iTimer = 6.
    END.
  END.

  HIDE MESSAGE NO-PAUSE.
  MESSAGE iDay '/' seqFish.
  PROCESS EVENTS. 
END.

MESSAGE seqFish VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    

