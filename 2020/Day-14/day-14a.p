/* AoC 2020 day 14 part 1
 */ 
DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE cMask AS CHARACTER NO-UNDO.
DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSum  AS INT64     NO-UNDO.

DEFINE TEMP-TABLE ttMem NO-UNDO
  FIELD cMem AS CHARACTER 
  FIELD cBin AS CHARACTER 
  INDEX iPrim cMem.

ETIME(YES).
INPUT FROM "input.txt".
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine BEGINS 'mask' THEN cMask = TRIM(ENTRY(2,cLine,'=')).
  IF cLine BEGINS 'mem[' THEN RUN addValue(ENTRY(1,cLine,'='), ENTRY(2,cLine,'='), cMask).
END.
INPUT CLOSE. 

FOR EACH ttMem:
  iSum = iSum + System.Convert:ToInt64(ttMem.cBin,2).
END.

MESSAGE 'Part 1:' iSum SKIP 'Time:' ETIME
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

PROCEDURE addValue:
  DEFINE INPUT PARAMETER pcMem  AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piVal  AS INT64     NO-UNDO.
  DEFINE INPUT PARAMETER pcMask AS CHARACTER NO-UNDO.
  DEFINE BUFFER bMem FOR ttMem.

  FIND bMem WHERE bMem.cMem = pcMem NO-ERROR.
  IF NOT AVAILABLE bMem THEN CREATE bMem.

  bMem.cMem = pcMem.
  bMem.cBin = System.Convert:ToString(piVal,2).
  IF LENGTH(bMem.cBin) < 36 THEN bMem.cBin = FILL('0', 36 - LENGTH(bMem.cBin)) + bMem.cBin.

  DO i = 1 TO LENGTH(pcMask):
    IF SUBSTRING(pcMask,i,1) <> 'X' THEN SUBSTRING(bMem.cBin,i,1) = SUBSTRING(pcMask,i,1).
  END.
END PROCEDURE. 

/*
---------------------------
Information 
---------------------------
Part 1: 12512013221615 
Time: 56
---------------------------
*/
