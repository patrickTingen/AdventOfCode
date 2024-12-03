/* AoC 2024 day 03b 
 */ 
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cChunk  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iMul    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iClose  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iOne    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTwo    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iResult AS INT64     NO-UNDO.
DEFINE VARIABLE iDo     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDont   AS INTEGER   NO-UNDO.

ETIME(YES).

COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').

REPEAT :
  iMul   = INDEX(cData,'mul(',iMul + 1).
  iClose = INDEX(cData,')', iMul + 1).
  IF iMul = 0 OR iClose = 0 THEN LEAVE. 

  iDo   = R-INDEX(SUBSTRING(cData,1,iMul), "do()").
  iDont = R-INDEX(SUBSTRING(cData,1,iMul), "don't()").

  IF iDo <> 0 AND iDo < iDont THEN NEXT. 
  IF iDo = 0 AND iDont <> 0 THEN NEXT. 

  cChunk = SUBSTRING(cData,iMul, iClose - iMul + 1).
  IF NUM-ENTRIES(cChunk,",") <> 2 THEN NEXT.
  IF NUM-ENTRIES(cChunk," ")  > 1 THEN NEXT.

  cChunk = TRIM(SUBSTRING(cChunk,4),"()").
  ASSIGN 
    iOne = INTEGER(ENTRY(1,cChunk)) 
    iTwo = INTEGER(ENTRY(2,cChunk)) NO-ERROR.

  IF NOT ERROR-STATUS:ERROR THEN
    iResult = iResult + (iOne * iTwo).
END.

MESSAGE iResult 'in' ETIME 'ms'
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* 85508223 in 23 ms */
