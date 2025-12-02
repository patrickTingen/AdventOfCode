/* AoC 2025 day 02b
 */ 
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cRange  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INT64     NO-UNDO.
DEFINE VARIABLE j       AS INT64     NO-UNDO.
DEFINE VARIABLE k       AS INT64     NO-UNDO.
DEFINE VARIABLE iTotal  AS INT64     NO-UNDO.
DEFINE VARIABLE iLo     AS INT64     NO-UNDO.
DEFINE VARIABLE iHi     AS INT64     NO-UNDO.
DEFINE VARIABLE cId     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLen    AS INT64     NO-UNDO.

ETIME(YES).

COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').

DO i = 1 TO NUM-ENTRIES(cData):

  cRange = ENTRY(i,cData).
  iLo = INT64(ENTRY(1,cRange,"-")).
  iHi = INT64(ENTRY(2,cRange,"-")).

  #Range:
  DO j = iLo TO iHi:
    
    cId  = STRING(j).
    iLen = TRUNC(LENGTH(cId) / 2,0). // Max length of a repeated id can be half of the length

    DO k = 1 TO iLen:

      // Elemininate all occurences of ID. 
      // If nothing left, we have a valid one
      IF REPLACE(cId,SUBSTRING(cId,1,k),"") = "" THEN 
      DO:
        iTotal = iTotal + j.
        NEXT #Range.
      END. 

    END. // do k
  END. // do j
END. // do i 

MESSAGE iTotal "in" ETIME "ms" 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


// -------------------------------
// Information 
// -------------------------------
// Laptop: 35950619148 in 5411 ms
// -------------------------------


