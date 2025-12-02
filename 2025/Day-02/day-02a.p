/* AoC 2025 day 02a 
 */ 
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cRange  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INT64     NO-UNDO.
DEFINE VARIABLE j       AS INT64     NO-UNDO.
DEFINE VARIABLE iTotal  AS INT64     NO-UNDO.
DEFINE VARIABLE iLo     AS INT64     NO-UNDO.
DEFINE VARIABLE iHi     AS INT64     NO-UNDO.
DEFINE VARIABLE cId     AS CHARACTER NO-UNDO.

ETIME(YES).

COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').

DO i = 1 TO NUM-ENTRIES(cData):

  cRange = ENTRY(i,cData).
  iLo = INT64(ENTRY(1,cRange,"-")).
  iHi = INT64(ENTRY(2,cRange,"-")).

  DO j = iLo TO iHi:
    cId   = STRING(j).
    IF cId = SUBSTRING(cId,1,INT64(LENGTH(cId) / 2)) + SUBSTRING(cId,1,INT64(LENGTH(cId) / 2)) THEN 
      iTotal = iTotal + j.
  END.
  
END.

MESSAGE iTotal "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
// ---------------------------
// Information 
// ---------------------------
// 23039913998 in 1750 ms
// ---------------------------
// OK   Help   
// ---------------------------
