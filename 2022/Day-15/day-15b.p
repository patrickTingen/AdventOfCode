/* AoC 2022 day 15b
 */ 
DEFINE VARIABLE cData     AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxX     AS INTEGER   NO-UNDO INITIAL 4000000.
DEFINE VARIABLE iMaxY     AS INTEGER   NO-UNDO INITIAL 4000000.
DEFINE VARIABLE iCheckX   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCheckY   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDeltaX   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDeltaY   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCheck    AS INTEGER   NO-UNDO.
DEFINE VARIABLE lScanned  AS LOGICAL   NO-UNDO.
DEFINE VARIABLE iDistance AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttSensor NO-UNDO
  FIELD iNr        AS INTEGER
  FIELD iX         AS INTEGER 
  FIELD iY         AS INTEGER 
  FIELD iBeaconX   AS INTEGER 
  FIELD iBeaconY   AS INTEGER 
  FIELD iManhattan AS INTEGER
  INDEX iPrim iNr.

DEFINE BUFFER bSensor FOR ttSensor.

/* Read file and strip nasty characters */
COPY-LOB FILE "c:\Data\DropBox\AdventOfCode\2022\Day-15\data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').
cData = REPLACE(cData,",", "").
cData = REPLACE(cData,":", "").
cData = REPLACE(cData,"=", " ").

DO i = 1 TO NUM-ENTRIES(cData, "~n"):
  cLine = TRIM(ENTRY(i, cData, "~n")).
  IF cLine = "" THEN NEXT.

  CREATE ttSensor.
  ASSIGN 
    ttSensor.iNr        = i
    ttSensor.iX         = INTEGER(ENTRY( 4,cLine," "))
    ttSensor.iY         = INTEGER(ENTRY( 6,cLine," "))
    ttSensor.iBeaconX   = INTEGER(ENTRY(12,cLine," "))
    ttSensor.iBeaconY   = INTEGER(ENTRY(14,cLine," "))
    ttSensor.iManhattan = ABS(ttSensor.iX - ttSensor.iBeaconX) + ABS(ttSensor.iY - ttSensor.iBeaconY)
    .
END. /* ReadBlock: */

/* It takes forever and a day to complete, but it works
*/
#PartB:
FOR EACH ttSensor:

  HIDE MESSAGE NO-PAUSE. 
  MESSAGE ttSensor.iNr.
  PROCESS EVENTS. 

  ASSIGN 
    iCheckX = ttSensor.iX + ttSensor.iManhattan + 1
    iCheckY = ttSensor.iY.
  
  DO iDeltaX = -1 TO +1 BY 2:
    DO iDeltaY = -1 TO +1 BY 2:  
      DO iCheck = 0 TO ttSensor.iManhattan:
      
        lScanned = FALSE.
      
        #Sensor:
        FOR EACH bSensor WHERE bSensor.iNr <> ttSensor.iNr:
          iDistance = ABS(iCheckX - bSensor.iX) + ABS(iCheckY - bSensor.iY).
          IF iDistance <= bSensor.iManhattan THEN lScanned = TRUE.
          IF lScanned THEN LEAVE #Sensor.
        END.
      
        IF lScanned = FALSE 
          AND iCheckX >= 0 AND iCheckX <= iMaxX
          AND iCheckY >= 0 AND iCheckY <= iMaxY THEN 
        DO:
          /* Found it! */
          MESSAGE iCheckX * 4000000 + iCheckY VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
          LEAVE #PartB.
        END. /* Check Point *not* scanned and inside the borders */
      
        ASSIGN 
          iCheckX = iCheckX + iDeltaX
          iCheckY = iCheckY + iDeltaY.
      
      END. /* do iCheck */
    END. /* do iDeltaY */
  END. /* do iDeltaX */
END. /* for each ttSensor */

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 13340867187704              */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */


