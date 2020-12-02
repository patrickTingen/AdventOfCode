/* AoC 2019 - 10b
*/
USING System.Math.

DEFINE TEMP-TABLE ttAsteroid NO-UNDO
  FIELD iPosX   AS INTEGER FORMAT '>>9'
  FIELD iPosY   AS INTEGER FORMAT '>>9'
  FIELD dAngle  AS DECIMAL FORMAT '>>9.9999999999'
  FIELD dDist   AS DECIMAL FORMAT '>>9.999'
  FIELD iNumSee AS INTEGER FORMAT '>>9'
  .

FUNCTION getAngle RETURNS DECIMAL
  (piBaseX AS INT, piBaseY AS INT, piObjX AS INT, piObjY AS INT):
  DEFINE VARIABLE dAngle AS DECIMAL NO-UNDO.

  dAngle = -1 * Math:PI - Math:Atan2(piObjX - piBaseX, piObjY - piBaseY).

  DO WHILE dAngle < 0:
    dAngle = dAngle + 2 * Math:PI.
  END.  
  RETURN dAngle.
END FUNCTION. /* getAngle */


DEFINE VARIABLE iVaporized AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLaserX    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLaserY    AS INTEGER   NO-UNDO.

/* Load calc from part 1 */
TEMP-TABLE ttAsteroid:READ-XML('FILE', 'ttAsteroid.xml', 'empty', '', ?, ?, ?). 

/* Find laser position */
FOR EACH ttAsteroid BREAK BY ttAsteroid.iNumSee DESCENDING:
  iLaserX = ttAsteroid.iPosX.
  iLaserY = ttAsteroid.iPosY.
  LEAVE.
END.

/* Recalculate angles */
FOR EACH ttAsteroid:
  ttAsteroid.dAngle = getAngle(iLaserX, iLaserY, ttAsteroid.iPosX, ttAsteroid.iPosY).
END.


#Vaporize:
REPEAT:

  FOR EACH ttAsteroid BREAK BY ttAsteroid.dAngle BY ttAsteroid.dDist:
    IF FIRST-OF(ttAsteroid.dAngle) THEN 
    DO:
      iVaporized = iVaporized + 1.

      MESSAGE SUBSTITUTE('Vaped:&1 (&2,&3) &4', iVaporized, ttAsteroid.iPosX, ttAsteroid.iPosY, ttAsteroid.dAngle)
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

      IF iVaporized = 200 THEN 
      DO:
        MESSAGE ttAsteroid.iPosX ttAsteroid.iPosY VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
        STOP.
      END.
  
      DELETE ttAsteroid.
      NEXT #Vaporize.
    END.
  END.

END.


