/* AoC 2023 day 09 a + b 
 */ 
DEFINE TEMP-TABLE ttData
  FIELD iNr   AS INTEGER
  FIELD iVer  AS INTEGER
  FIELD iVal  AS INTEGER EXTENT 100 INITIAL ? FORMAT '->>>>>>9'
  FIELD iLen  AS INTEGER
  INDEX iPrim IS PRIMARY iNr iVer.

DEFINE BUFFER btData FOR ttData.
DEFINE BUFFER btPrev   FOR ttData.

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLine    AS INTEGER NO-UNDO.  
DEFINE VARIABLE i        AS INTEGER NO-UNDO.
DEFINE VARIABLE iVersion AS INTEGER NO-UNDO.
DEFINE VARIABLE iAnswer  AS INTEGER NO-UNDO.
DEFINE VARIABLE lAllZero AS LOGICAL NO-UNDO.
DEFINE VARIABLE iPart    AS INTEGER NO-UNDO.

DO iPart = 1 TO 2:

  EMPTY TEMP-TABLE ttData.
  iLine = 0.
  iAnswer = 0.

  INPUT FROM "data.txt".
  REPEAT:
  IMPORT UNFORMATTED cLine.
    cLine = TRIM(cLine).
    IF cLine = '' THEN LEAVE.
    
    iLine = iLine + 1.
    
    CREATE ttData.
    ASSIGN 
      ttData.iNr  = iLine
      ttData.iVer = 0
      ttData.iLen = NUM-ENTRIES(cLine,' ').
    
    /* For part 2: just save all numbers in reverse order */
    DO i = 1 TO ttData.iLen:     
      CASE iPart:
        WHEN 1 THEN ttData.iVal[i] = INTEGER(ENTRY(i,cLine,' ')).
        WHEN 2 THEN ttData.iVal[ttData.iLen - i + 1] = INTEGER(ENTRY(i,cLine,' ')).
      END.
    END.
    
  END.
  INPUT CLOSE. 

  /* create new versions */
  FOR EACH ttData WHERE ttData.iVer = 0:

    iVersion = 0.

    #History:
    REPEAT:
      PROCESS EVENTS.

      FIND btPrev WHERE btPrev.iNr = ttData.iNr AND btPrev.iVer = iVersion.

      iVersion = iVersion + 1.
      lAllZero = YES.

      CREATE btData.
      BUFFER-COPY btPrev TO btData
        ASSIGN btData.iVer  = iVersion
               btData.iLen  = btPrev.iLen - 1.

      /* Fill the sequence of nrs and append new last value */         
      DO i = 1 TO btData.iLen:
        btData.iVal[i] = btPrev.iVal[i + 1] - btPrev.iVal[i].
        IF btData.iVal[i] <> 0 THEN lAllZero = NO.
      END.

      IF lAllZero THEN LEAVE #History.
    END. /* #history */
  END. /* f/e ttData */

  FOR EACH ttData:
    iAnswer = iAnswer + ttData.iVal[ttData.iLen].
  END.

  MESSAGE 'Answer part' iPart ':' iAnswer
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
