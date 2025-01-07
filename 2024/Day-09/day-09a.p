/* AoC 2024 day 09a 
 */ 
DEFINE VARIABLE cData   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cMap    AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFileNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE iBlocks AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INT64     NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".
IMPORT UNFORMATTED cData.
INPUT CLOSE. 

FIX-CODEPAGE(cMap) = 'iso8859-1'.

DO i = 1 TO LENGTH(cData):

  IF i MOD 2 = 1 THEN
  DO:
    iBlocks = INTEGER(SUBSTRING(cData,i,1)).
    cMap    = cMap + FILL(STRING(iFileNr) + ",",iBlocks).
    iFileNr = iFileNr + 1.
  END.
  ELSE
  DO:
    iBlocks = INTEGER(SUBSTRING(cData,i,1)).
    cMap    = cMap + FILL("X,",iBlocks).
  END. 
END.
cMap = TRIM(cMap,",").

REPEAT:
  i = LOOKUP('x',cMap).
  IF i = 0 THEN LEAVE.
  ENTRY(i,cMap) = ENTRY(NUM-ENTRIES(cMap),cMap).
  ENTRY(NUM-ENTRIES(cMap),cMap) = ''.
  cMap = TRIM(cMap,",").
END.

DO i = 1 TO NUM-ENTRIES(cMap):
  iAnswer = iAnswer + (i - 1) * INTEGER(ENTRY(i,cMap)).
END.

MESSAGE iAnswer "in" ETIME "ms"   /* 6225730762521 in 60956 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* Work laptop: 6225730762521 in 362354 ms
*/
