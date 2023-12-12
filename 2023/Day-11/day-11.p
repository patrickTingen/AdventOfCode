/* AoC 2023 day 11 a + b
 */ 
DEFINE TEMP-TABLE ttGalaxy NO-UNDO
  FIELD iNr   AS INTEGER
  FIELD iOldX AS INTEGER
  FIELD iOldY AS INTEGER
  FIELD iNewX AS INTEGER
  FIELD iNewY AS INTEGER
  INDEX iPrim IS PRIMARY iNr
  INDEX idxX iOldX
  INDEX idxY iOldY.

DEFINE BUFFER ttOther FOR ttGalaxy.

DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iPart   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFactor AS INTEGER   NO-UNDO EXTENT 2 INITIAL [2,1000000].
DEFINE VARIABLE iGalaxy AS INTEGER   NO-UNDO.
DEFINE VARIABLE iX      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iY      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iAnswer AS INT64     NO-UNDO EXTENT 2.
DEFINE VARIABLE iPrev   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.

COPY-LOB FILE "data.txt" TO cData.

DO iY = 1 TO NUM-ENTRIES(cData,"~n"):
  cLine = ENTRY(iY,cData,"~n").

  DO iX = 1 TO LENGTH(cLine):
    IF SUBSTRING(cLine,iX,1) = "#" THEN 
    DO:
      iGalaxy = iGalaxy + 1.
      CREATE ttGalaxy.
      ASSIGN ttGalaxy.iNr   = iGalaxy
             ttGalaxy.iOldX = iX
             ttGalaxy.iOldY = iY.
    END.
  END.
END.

DO iPart = 1 TO 2:

  /* Reset the galaxies :) */
  FOR EACH ttGalaxy:
    ttGalaxy.iNewX = ttGalaxy.iOldX.
    ttGalaxy.iNewY = ttGalaxy.iOldY.
  END.
  
  iPrev = 1.
  FOR EACH ttGalaxy BREAK BY ttGalaxy.iOldX:
  
    PROCESS EVENTS.

    IF FIRST-OF(ttGalaxy.iOldX) THEN
    DO i = iPrev TO ttGalaxy.iOldX:
      FOR EACH ttOther WHERE ttOther.iOldX > iPrev:
        IF NOT CAN-FIND(FIRST ttGalaxy WHERE ttGalaxy.iOldX = i) THEN ttOther.iNewX = ttOther.iNewX + (iFactor[iPart] - 1).
      END.
    END.
    iPrev = ttGalaxy.iOldX.
  END.
  
  iPrev = 1.
  FOR EACH ttGalaxy BREAK BY ttGalaxy.iOldY:
  
    IF FIRST-OF(ttGalaxy.iOldY) THEN
    DO i = iPrev TO ttGalaxy.iOldY:
      FOR EACH ttOther WHERE ttOther.iOldY > iPrev:
        IF NOT CAN-FIND(FIRST ttGalaxy WHERE ttGalaxy.iOldY = i) THEN ttOther.iNewY = ttOther.iNewY + (iFactor[iPart] - 1).
      END.
    END.
    iPrev = ttGalaxy.iOldY.
  END.
  
  FOR EACH ttGalaxy
    , EACH ttOther WHERE ttOther.iNr > ttGalaxy.iNr:
  
    iAnswer[iPart] = iAnswer[iPart] + ABS(ttGalaxy.iNewX - ttOther.iNewX) 
                                    + ABS(ttGalaxy.iNewY - ttOther.iNewY).
  END.
  
END.

MESSAGE 'Part 1: ' iAnswer[1] SKIP
        'Part 2: ' iAnswer[2] 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  

