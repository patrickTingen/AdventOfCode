/* AoC 2024 day 11b
 */ 
DEFINE TEMP-TABLE ttCache
  FIELD iBlinks AS INT64
  FIELD iValue  AS INT64
  FIELD iLength AS INT64
  INDEX iPrim IS UNIQUE iValue iBlinks.

FUNCTION split RETURNS INT64(piPart AS INT64, piVal AS INT64):
  DEFINE VARIABLE cVal AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iLen AS INT64   NO-UNDO.

  cVal = STRING(piVal).
  iLen = LENGTH(cVal) / 2.
  
  IF piPart = 1 THEN RETURN INT64(SUBSTRING(cVal,1,iLen)).
  IF piPart = 2 THEN RETURN INT64(SUBSTRING(cVal,iLen + 1)).
END FUNCTION. 

FUNCTION numStones RETURNS INT64 
  ( piValue  AS INT64
  , piBlinks AS INT64
  ):
  DEFINE VARIABLE iNumbers AS INT64 NO-UNDO.
  DEFINE BUFFER btCache FOR ttCache.
  
  IF piBlinks = 0 THEN RETURN 1.

  FIND btCache WHERE btCache.iBlinks = piBlinks AND btCache.iValue = piValue NO-ERROR.
  IF AVAILABLE btCache THEN RETURN btCache.iLength.

  IF piValue = 0 THEN /* 0 -> 1 */
    iNumbers = numStones(1, piBlinks - 1).

  ELSE 
  IF LENGTH(STRING(piValue)) MOD 2 = 0 THEN /* Split */
    iNumbers = numStones(split(1,piValue), piBlinks - 1) 
             + numStones(split(2,piValue), piBlinks - 1).
    
  ELSE 
    iNumbers = numStones(piValue * 2024, piBlinks - 1). /* x 2024 */

  CREATE btCache.
  ASSIGN 
    btCache.iValue  = piValue
    btCache.iBlinks = piBlinks
    btCache.iLength = iNumbers.

  RETURN iNumbers.
END FUNCTION.

DEFINE VARIABLE cData  AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i      AS INTEGER  NO-UNDO.
DEFINE VARIABLE iPartB AS INT64    NO-UNDO.

ETIME(YES).
COPY-LOB FILE 'data.txt' TO cData.
cData = REPLACE(REPLACE(cData,'~n',''),'~r',',').

DO i = 1 TO NUM-ENTRIES(cData,' '):
  iPartB = iPartB + numStones(INTEGER(ENTRY(i,cData,' ')),75).
END.

MESSAGE iPartB "in" ETIME "ms" /* 261936432123724 in 2927 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* Part A: 220999 in 43 ms */

