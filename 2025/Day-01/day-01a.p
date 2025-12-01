/* AoC 2025 day 01a 
 */ 
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cEntry  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iDial   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iZero   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRotate AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.

COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').

iDial = 50.

DO i = 1 TO NUM-ENTRIES(cData,"~n"):
  cEntry = ENTRY(i,cData,"~n").
  iRotate = INT(SUBSTRING(cEntry,2)).
  IF cEntry BEGINS "L" THEN iRotate = iRotate * -1.
  iDial = (iDial + iRotate) MOD 100.
  IF iDial = 0 THEN iZero = iZero + 1.
END.

MESSAGE iZero 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
