/* AoC 2023 day 05a 
 */ 
DEFINE TEMP-TABLE ttMap NO-UNDO
  FIELD iType  AS INT64
  FIELD iBegin AS INT64
  FIELD iEnd   AS INT64
  FIELD iDest  AS INT64.
  .

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSeeds   AS CHARACTER NO-UNDO EXTENT 25.
DEFINE VARIABLE iSection AS INT64     NO-UNDO.
DEFINE VARIABLE i        AS INT64     NO-UNDO.
DEFINE VARIABLE iSeed    AS INT64     NO-UNDO.
DEFINE VARIABLE iAnswer  AS INT64     NO-UNDO INITIAL ?.

INPUT FROM "data.txt".
IMPORT cSeeds.

REPEAT :
  IMPORT UNFORMATTED cLine.
  IF cLine = '' THEN NEXT.

  IF cLine MATCHES "* map:" THEN iSection = iSection + 1.
  IF NUM-ENTRIES(cLine,' ') = 3 THEN 
  DO:
    CREATE ttMap.
    ASSIGN ttMap.iType = iSection
           ttMap.iBegin = INT64(ENTRY(2,cLine,' '))
           ttMap.iEnd   = ttMap.iBegin + INT64(ENTRY(3,cLine,' ')) - 1
           ttMap.iDest  = INT64(ENTRY(1,cLine,' ')).
  END.
END.
INPUT CLOSE. 

DO i = 2 TO EXTENT(cSeeds).

  iSeed = INT64(cSeeds[i]). 
  IF iSeed = 0 THEN LEAVE.

  DO iSection = 1 TO 7:
    FIND ttMap WHERE ttMap.iType   = iSection 
                 AND ttMap.iBegin <= iSeed
                 AND ttMap.iEnd   >= iSeed NO-ERROR.

    IF AVAILABLE ttMap THEN 
      iSeed = (iSeed - ttMap.iBegin) + ttMap.iDest.
  END.

  iAnswer = (IF iAnswer = ? THEN iSeed ELSE MINIMUM(iAnswer,iSeed)).
END.

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


