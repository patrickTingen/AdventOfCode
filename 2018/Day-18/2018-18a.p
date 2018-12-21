/* Advent of code 2018
** day 15 - Settlers of The North Pole
*/
DEFINE TEMP-TABLE ttMap
  FIELD iPosX  AS INTEGER
  FIELD iPosY  AS INTEGER
  FIELD cType  AS CHARACTER
  FIELD cNext  AS CHARACTER  
  INDEX iPrim iPosX iPosY cType .

DEFINE TEMP-TABLE ttGen
  FIELD iGenNr  AS INTEGER
  FIELD iTrees  AS INTEGER
  FIELD iLumber AS INTEGER
  INDEX iPrim iGenNr.
  
DEFINE STREAM strDebug.
PAUSE 0 BEFORE-HIDE. 

RUN readData('2018-18.dat').  
RUN showData(NO).
RUN play.

PROCEDURE play:
  DEFINE VARIABLE iTime    AS INTEGER NO-UNDO.
  DEFINE VARIABLE iTrees   AS INTEGER NO-UNDO.
  DEFINE VARIABLE iLumber  AS INTEGER NO-UNDO.
  DEFINE VARIABLE i        AS INTEGER NO-UNDO.
  DEFINE VARIABLE j        AS INTEGER NO-UNDO.
  DEFINE VARIABLE iPrevGen AS INTEGER     NO-UNDO.
  
  DEFINE BUFFER bMap  FOR ttMap. 
  DEFINE BUFFER bMap2 FOR ttMap. 
  DEFINE BUFFER bGen FOR ttGen. 
  
  OUTPUT STREAM strDebug TO '2018-18-debug.txt' UNBUFFERED APPEND.
  
  REPEAT: 
    iTime = iTime  + 1.

    FOR EACH bMap:

      /* Get surroundings */
      ASSIGN iTrees = 0 iLumber = 0.
      DO j = -1 TO 1:
        DO i = -1 TO 1:
          IF i = 0 AND j = 0 THEN NEXT.
          FIND bMap2 WHERE bMap2.iPosX = bMap.iPosX + j AND bMap2.iPosY = bMap.iPosY + i NO-ERROR.
          IF NOT AVAILABLE bMap2 THEN NEXT. 
          IF bMap2.cType = '|' THEN iTrees  = iTrees + 1.
          IF bMap2.cType = '#' THEN iLumber = iLumber + 1.
        END.
      END.

      /* Next generation */
      bMap.cNext = bMap.cType.
      CASE bMap.cType:
        WHEN '.' THEN IF iTrees  >= 3 THEN bMap.cNext = '|'. 
        WHEN '|' THEN IF iLumber >= 3 THEN bMap.cNext = '#'.
        WHEN '#' THEN IF iLumber >= 1 AND iTrees >= 1 THEN bMap.cNext = '#'. ELSE bMap.cNext = '.'.
      END CASE. 
    END.

    CREATE ttGen.
    ASSIGN ttGen.iGenNr = iTime. 
    FOR EACH bMap BY bMap.iPosy BY bMap.iPosx: 
      bMap.cType = bMap.cNext.
      IF bMap.cType = '|' THEN ttGen.iTrees  = ttGen.iTrees + 1.
      IF bMap.cType = '#' THEN ttGen.iLumber = ttGen.iLumber + 1.
    END.
    
    /* Search for repeating pattern */
    FIND FIRST bGen WHERE bGen.iGenNr < ttGen.iGenNr AND bGen.iTrees = ttGen.iTrees AND bGen.iLumber = ttGen.iLumber NO-ERROR.
    iPrevGen = (IF AVAILABLE bGen THEN bGen.iGenNr ELSE 0).
    
    EXPORT STREAM strDebug ttGen.iGenNr ttGen.iTrees ttGen.iLumber iPrevGen.

    /* Part one */
/*     IF iTime = 10 THEN                                                               */
/*       MESSAGE ttGen.iTrees * ttGen.iLumber VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. */

    /* Part two has repeating pattern after ~500 seconds. Check debug file for exact sequence then calc: 
    ** (1000000000 - <generation start of cycle>) mod <cycle length> gives nr within cycle
    */
    IF ETIME > 1000 THEN
    DO:
      ETIME(YES).
      MESSAGE iTime.
      PROCESS EVENTS.
    END.  
    
    IF iTime > 1000 THEN LEAVE. /* should be enough */
  END.  
  
  OUTPUT STREAM strDebug CLOSE.  
END PROCEDURE. /* play */ 


PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.

  INPUT FROM VALUE(pcFile).
  REPEAT: 
    IMPORT UNFORMATTED c.
    j = j + 1.
    DO i = 1 TO LENGTH(c):
      CREATE ttMap.
      ASSIGN 
        ttMap.iPosX  = i - 1
        ttMap.iPosY  = j - 1
        ttMap.cType  = SUBSTRING(c,i,1).
    END.
  END. 
  INPUT CLOSE. 
END PROCEDURE. /* readData */


PROCEDURE showData:
  DEFINE INPUT PARAMETER plAppend AS LOGICAL NO-UNDO.
  DEFINE VARIABLE cFile AS CHARACTER NO-UNDO INITIAL '2018-18-debug.txt'.
  IF NOT plAppend THEN OS-DELETE VALUE(cFile).
  OUTPUT TO VALUE(cFile) APPEND.
  FOR EACH ttMap BREAK BY ttMap.iPosY BY ttMap.iPosX:
    PUT UNFORMATTED ttMap.cType.
    IF LAST-OF(ttMap.iPosY) THEN PUT UNFORMATTED '~n'.
  END.
  PUT UNFORMATTED '~n'.
  OUTPUT CLOSE. 
END PROCEDURE. /* showData */


