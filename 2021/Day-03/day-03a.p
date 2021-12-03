/* AoC 2021 day 03a
 */ 

DEFINE VARIABLE cData    AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE j        AS INTEGER   NO-UNDO.
DEFINE VARIABLE cBit     AS CHARACTER NO-UNDO EXTENT 12.
DEFINE VARIABLE iGamma   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iEpsilon AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLen     AS INTEGER   NO-UNDO.
  
COPY-LOB FILE "data.txt" TO cData. 
iLen = LENGTH(ENTRY(1,cData,'~n')) - 1.

DO i = 1 TO NUM-ENTRIES(cData,'~n'):
  DO j = 1 TO iLen:
    cBit[j] = cBit[j] + SUBSTRING(ENTRY(i,cData,'~n'), j,1).
  END.
END.

DO j = 1 TO iLen:
  /* More ones than zeros */
  IF LENGTH(REPLACE(cBit[j],'1','')) < LENGTH(REPLACE(cBit[j],'0','')) THEN 
    iGamma = iGamma + EXP(2, iLen - j).
  ELSE 
    iEpsilon = iEpsilon + EXP(2, iLen - j).
END.

MESSAGE iGamma * iEpsilon
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 1997414                     */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
