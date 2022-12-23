/* AoC 2022 day 20a
 * 
 * Note: run with a large -s setting (I used -s 100000)
 */ 
DEFINE TEMP-TABLE ttNr NO-UNDO
  FIELD iOrgPos AS INTEGER
  FIELD iValue  AS INTEGER.

DEFINE VARIABLE cList   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iLen    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cEntry  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iCurPos AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNewPos AS INTEGER   NO-UNDO.
DEFINE VARIABLE iShift  AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cSep    AS CHARACTER NO-UNDO.

/* Read file and strip nasty characters */
COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').

cData = REPLACE(cData,"~n",",").
iLen  = NUM-ENTRIES(cData).

/* Read into tt to handle duplicate values */
DO i = 1 TO iLen:
  CREATE ttNr. 
  ASSIGN 
    ttNr.iOrgPos = i
    ttNr.iValue  = INTEGER(ENTRY(i,cData)).
    
  cList = SUBSTITUTE("&1&2&3", cList, cSep, RECID(ttNr)).
  cSep = ",".
END.

iLen = NUM-ENTRIES(cList).
cData = cList.

DO i = 1 TO iLen:
  cEntry = ENTRY(i,cData).

  FIND ttNr WHERE RECID(ttNr) = INTEGER(cEntry).
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

/* Find zero */
FIND ttNr WHERE ttNr.iValue = 0.
i = LOOKUP(STRING(RECID(ttNr)), cList).

/* Fast forward 1000/2000/3000 elements */
DEFINE VARIABLE r AS INTEGER   NO-UNDO.
DEFINE VARIABLE a AS INTEGER   NO-UNDO.

r = INTEGER(ENTRY( ((i - 1 + 1000) MOD iLen) + 1, cList)).
FIND ttNr WHERE RECID(ttNr) = r.
a = ttNr.iValue.

r = INTEGER(ENTRY( ((i - 1 + 2000) MOD iLen) + 1, cList)).
FIND ttNr WHERE RECID(ttNr) = r.
a = a + ttNr.iValue.

r = INTEGER(ENTRY( ((i - 1 + 3000) MOD iLen) + 1, cList)).
FIND ttNr WHERE RECID(ttNr) = r.
a = a + ttNr.iValue.

MESSAGE a VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* ---------------------------                  */
/* Information (Press HELP to view stack trace) */
/* ---------------------------                  */
/* 1087                                         */
/* ---------------------------                  */
/* OK   Help                                    */
/* ---------------------------                  */
