/* AoC 2022 day 15a 
 */ 
DEFINE VARIABLE cData  AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPartA AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRowNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMinX  AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE iMaxX  AS INTEGER   NO-UNDO INITIAL ?.

DEFINE TEMP-TABLE ttSensor NO-UNDO
  FIELD iX         AS INTEGER 
  FIELD iY         AS INTEGER 
  FIELD iBeaconX   AS INTEGER 
  FIELD iBeaconY   AS INTEGER 
  FIELD iManhattan AS INTEGER 
  FIELD iLeft      AS INTEGER
  FIELD iRight     AS INTEGER
  INDEX iBeacon iBeaconX iBeaconY
  INDEX iLeft iRight.

/* Read file and strip nasty characters */
COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').

/* Sensor at x=2, y=18: closest beacon is at x=-2, y=15 */
/* Sensor at x=2 y=18 closest beacon is at x=-2 y=15 */
cData = REPLACE(cData,",", "").
cData = REPLACE(cData,":", "").
cData = REPLACE(cData,"=", " ").

/* Part A */
iRowNr = 2000000.

DO i = 1 TO NUM-ENTRIES(cData, "~n"):

  cLine = TRIM(ENTRY(i, cData, "~n")).
  IF cLine = "" THEN NEXT.

  /* Sensor at x 2 y 18 closest beacon is at x -2 y 15 */
  CREATE ttSensor.
  ASSIGN 
    ttSensor.iX         = INTEGER(ENTRY( 4,cLine," "))
    ttSensor.iY         = INTEGER(ENTRY( 6,cLine," "))
    ttSensor.iBeaconX   = INTEGER(ENTRY(12,cLine," "))
    ttSensor.iBeaconY   = INTEGER(ENTRY(14,cLine," "))
    ttSensor.iManhattan = ABS(ttSensor.iX - ttSensor.iBeaconX) + ABS(ttSensor.iY - ttSensor.iBeaconY)
    ttSensor.iLeft      = ttSensor.iX - ttSensor.iManhattan + ABS(ttSensor.iY - iRowNr).
    ttSensor.iRight     = ttSensor.iX + ttSensor.iManhattan - ABS(ttSensor.iY - iRowNr).
    .
END. /* ReadBlock: */
         

FOR EACH ttSensor WHERE ttSensor.iLeft < ttSensor.iRight BREAK BY 1:
  IF FIRST-OF(1) THEN 
    ASSIGN iMinX = ttSensor.iLeft
           iMaxX = ttSensor.iRight.
  ELSE
    ASSIGN iMinX = MINIMUM(iMinX,ttSensor.iLeft,ttSensor.iRight)
           iMaxX = MAXIMUM(iMaxX,ttSensor.iLeft,ttSensor.iRight).
END.


DO i = iMinX TO iMaxX:

  IF ETIME > 1000 THEN 
  DO:
    PROCESS EVENTS. 
    HIDE MESSAGE NO-PAUSE. 
    MESSAGE iMinX iMaxX i.
    ETIME(YES).
  END.

  IF CAN-FIND(FIRST ttSensor WHERE ttSensor.iBeaconX = i AND ttSensor.iBeaconY = iRowNr) THEN NEXT.
  IF CAN-FIND(FIRST ttSensor WHERE ttSensor.iLeft <= i AND ttSensor.iRight >= i) THEN iPartA = iPartA + 1.
END.

MESSAGE iPartA VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 5525847                     */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */
