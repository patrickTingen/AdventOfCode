/* AoC 2020 day 13 part 1
 */ 
DEFINE VARIABLE cDep   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTime  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iBus   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFirst AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE iPart1 AS INTEGER   NO-UNDO.

INPUT FROM "input.txt".
IMPORT iTime.
IMPORT cDep.
INPUT CLOSE. 

DO i = 1 TO NUM-ENTRIES(cDep):
  IF ENTRY(i,cDep) = 'x' THEN NEXT.
  iBus = INTEGER(ENTRY(i,cDep)).
  IF iFirst = ? OR (iBus - (iTime MOD iBus)) < iFirst THEN 
    ASSIGN iFirst = iBus - (iTime MOD iBus)
           iPart1 = (iBus - (iTime MOD iBus)) * iBus.
END.

MESSAGE iPart1 VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
