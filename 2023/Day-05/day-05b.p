/* AoC 2023 day 05b 
 */ 
DEFINE TEMP-TABLE ttMap NO-UNDO
  FIELD iType  AS INT64
  FIELD iBegin AS INT64
  FIELD iEnd   AS INT64
  FIELD iDest  AS INT64
  INDEX iPrim iType iBegin iEnd.

DEFINE TEMP-TABLE ttRange NO-UNDO
  FIELD iFrom AS INT64 
  FIELD iTo   AS INT64 
  INDEX iPrim iFrom iTo.

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSeeds   AS CHARACTER NO-UNDO EXTENT 25.
DEFINE VARIABLE iSection AS INT64     NO-UNDO.
DEFINE VARIABLE i        AS INT64     NO-UNDO.
DEFINE VARIABLE iRange   AS INT64     NO-UNDO.
DEFINE VARIABLE iSeed    AS INT64     NO-UNDO.
DEFINE VARIABLE iStep    AS INTEGER   NO-UNDO INITIAL 10000000.

/* Read data */
INPUT FROM "data.txt".
IMPORT cSeeds.

DO i = 2 TO EXTENT(cSeeds) BY 2.
  CREATE ttRange.
  ASSIGN ttRange.iFrom = INT64(cSeeds[i])
         ttRange.iTo   = ttRange.iFrom + INT64(cSeeds[i + 1]). 
END.

REPEAT :
 IMPORT UNFORMATTED cLine.
 IF cLine = '' THEN NEXT.

 IF cLine MATCHES "* map:" THEN iSection = iSection + 1.
 IF NUM-ENTRIES(cLine,' ') = 3 THEN 
 DO:
   CREATE ttMap.
   ASSIGN ttMap.iType = iSection
          ttMap.iBegin = INT64(ENTRY(1,cLine,' '))
          ttMap.iEnd   = ttMap.iBegin + INT64(ENTRY(3,cLine,' ')) - 1
          ttMap.iDest  = INT64(ENTRY(2,cLine,' ')).
 END.
END.
INPUT CLOSE. 

/* Solve it! */
ETIME(YES).

#Main:
REPEAT:

  REPEAT:
    iRange = iRange + iStep.
    iSeed = iRange.
  
    /* Reversed search */
    DO iSection = 7 TO 1 BY -1:
      FIND ttMap WHERE ttMap.iType   = iSection 
                   AND ttMap.iBegin <= iSeed
                   AND ttMap.iEnd   >= iSeed NO-ERROR.
   
      IF AVAILABLE ttMap THEN 
        iSeed = (iSeed - ttMap.iBegin) + ttMap.iDest.
    END.
   
    /* See if it is in a desired range */
    FIND ttRange WHERE ttRange.iFrom <= iSeed AND ttRange.iTo >= iSeed NO-ERROR.
    IF AVAILABLE ttRange THEN 
    DO:
      /* Refine the search */
      IF iStep > 1 THEN 
      DO:
        iRange = iRange - iStep.
        iStep = iStep / 10.
        NEXT #Main.
      END.

      MESSAGE iRange 'in' ETIME 'ms' VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      LEAVE #Main.
    END.
  
  END.
END.
