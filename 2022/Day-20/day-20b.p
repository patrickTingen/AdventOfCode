/* AoC 2022 day 20
 * 
 * Note: run with a large -s setting (I used -s 100000)
 */ 
DEFINE TEMP-TABLE ttNr NO-UNDO
  FIELD iOrgPos AS INT64
  FIELD iValue  AS INT64.

RUN solve_it(1,1). /* part a */
RUN solve_it(811589153,10). /* part b */ 

PROCEDURE solve_it:
  DEFINE INPUT  PARAMETER piSeed    AS INT64 NO-UNDO.
  DEFINE INPUT  PARAMETER piNumRuns AS INT64 NO-UNDO.
  
  DEFINE VARIABLE cList   AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iLen    AS INT64     NO-UNDO.
  DEFINE VARIABLE cEntry  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iCurPos AS INT64     NO-UNDO.
  DEFINE VARIABLE iNewPos AS INT64     NO-UNDO.
  DEFINE VARIABLE iShift  AS INT64     NO-UNDO.
  DEFINE VARIABLE i       AS INT64     NO-UNDO.
  DEFINE VARIABLE j       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cSep    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iResult AS INT64     NO-UNDO.
  DEFINE VARIABLE iAnswer AS INT64     NO-UNDO.

  ETIME(YES).
  
  /* Read file and strip nasty characters */
  EMPTY TEMP-TABLE ttNr.
  COPY-LOB FILE "data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  cData = REPLACE(cData,"~n",",").
  iLen  = NUM-ENTRIES(cData).

  /* Read into tt to handle duplicate values */
  DO i = 1 TO iLen:
    CREATE ttNr. 
    ASSIGN 
      ttNr.iOrgPos = i
      ttNr.iValue  = INT64(ENTRY(i,cData)) * piSeed.
      
    cList = SUBSTITUTE("&1&2&3", cList, cSep, RECID(ttNr)).
    cSep = ",".
  END.

  iLen = NUM-ENTRIES(cList).
  cData = cList.

  DO j = 1 TO piNumRuns:
  
    DO i = 1 TO iLen:
      cEntry = ENTRY(i,cData).

      FIND ttNr WHERE RECID(ttNr) = INT64(cEntry).
      iShift = ttNr.iValue.

      iCurPos = LOOKUP(cEntry, cList) - 1. /* make 0-based */
      iNewPos = (iCurPos + iShift) MOD (iLen - 1).

      iCurPos = iCurPos + 1. /* make 1-based */
      iNewPos = iNewPos + 1. /* make 1-based */

      /* remove old */
      ENTRY(iCurPos,cList) = ''.
      cList = REPLACE(cList,',,',',').
      cList = TRIM(cList,',').

      /* add new */
      IF iNewPos = 1 THEN 
        cList = cList + ',' + cEntry.
      ELSE
        ENTRY(iNewPos,cList) = cEntry + ',' + ENTRY(iNewPos,cList).
    END.
  END.

  /* Find zero */
  FIND ttNr WHERE ttNr.iValue = 0.
  i = LOOKUP(STRING(RECID(ttNr)), cList).

  /* Fast forward 1000/2000/3000 elements 
  */
  iResult = INT64(ENTRY( ((i - 1 + 1000) MOD iLen) + 1, cList)).
  FIND ttNr WHERE RECID(ttNr) = iResult.
  iAnswer = ttNr.iValue.

  iResult = INT64(ENTRY( ((i - 1 + 2000) MOD iLen) + 1, cList)).
  FIND ttNr WHERE RECID(ttNr) = iResult.
  iAnswer = iAnswer + ttNr.iValue.

  iResult = INT64(ENTRY( ((i - 1 + 3000) MOD iLen) + 1, cList)).
  FIND ttNr WHERE RECID(ttNr) = iResult.
  iAnswer = iAnswer + ttNr.iValue.

  MESSAGE iAnswer 'in' ETIME 'ms' VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

END PROCEDURE. 

/*
---------------------------
Information 
---------------------------
A: 1087 in 4492 ms
B: 13084440324666 in 41578 ms
---------------------------
*/
