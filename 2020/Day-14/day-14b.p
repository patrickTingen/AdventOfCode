/* AoC 2020 day 14 part 2
 */ 
DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cMask    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iAddress AS INT64     NO-UNDO.
DEFINE VARIABLE iValue   AS INT64     NO-UNDO.
DEFINE VARIABLE iSum     AS INT64     NO-UNDO.

DEFINE TEMP-TABLE ttMem NO-UNDO
  FIELD iNr  AS INT64
  FIELD iVal AS INT64
  INDEX iPrim iNr.

ETIME(YES).

INPUT FROM "input.txt".
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine BEGINS 'mask' THEN cMask = TRIM(ENTRY(2,cLine,'=')).
  IF cLine BEGINS 'mem[' THEN 
  DO:
    iAddress = INT64(ENTRY(1, ENTRY(2,cLine,'['),']')).
    iValue = INT64(TRIM(ENTRY(2,cLine,'='))).
    RUN addValue(iAddress, iValue, cMask).
  END.
END.
INPUT CLOSE. 

FOR EACH ttMem:
  iSum = iSum + ttMem.iVal.
END.

MESSAGE 'Part 2:' iSum SKIP 'Time:' ETIME
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


PROCEDURE addValue:
  DEFINE INPUT PARAMETER piMem  AS INT64     NO-UNDO.
  DEFINE INPUT PARAMETER piVal  AS INT64     NO-UNDO.
  DEFINE INPUT PARAMETER pcMask AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cMem AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i    AS INT64     NO-UNDO.

  /* Apply bitmask to mem address */
  cMem = System.Convert:ToString(piMem,2).
  IF LENGTH(cMem) < 36 THEN cMem = FILL('0', 36 - LENGTH(cMem)) + cMem.
  DO i = 1 TO LENGTH(pcMask):
    IF SUBSTRING(pcMask,i,1) <> '0' THEN SUBSTRING(cMem,i,1) = SUBSTRING(pcMask,i,1).
  END.

  RUN writeMem(cMem, piVal, pcMask).
END PROCEDURE. 


PROCEDURE writeMem:
  DEFINE INPUT PARAMETER pcMem  AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piVal  AS INT64     NO-UNDO.
  DEFINE INPUT PARAMETER pcMask AS CHARACTER NO-UNDO.

  DEFINE VARIABLE i    AS INT64 NO-UNDO.
  DEFINE VARIABLE iMem AS INT64 NO-UNDO.
  DEFINE BUFFER bMem FOR ttMem.

  i = INDEX(pcMem,'X').
  IF i > 0 THEN 
  DO:
    SUBSTRING(pcMem,i,1) = '0'.
    RUN writeMem(pcMem, piVal, pcMask).

    SUBSTRING(pcMem,i,1) = '1'.
    RUN writeMem(pcMem, piVal, pcMask).

    RETURN. 
  END.
    
  iMem = System.Convert:ToInt64(pcMem,2).
  FIND bMem WHERE bMem.iNr = iMem NO-ERROR.
  IF NOT AVAILABLE bMem THEN DO:
    CREATE bMem.
    ASSIGN bMem.iNr = iMem.
  END.

  ASSIGN bMem.iVal = piVal.

END PROCEDURE. 

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 2: 3905642473893       */
/* Time: 3994                  */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
