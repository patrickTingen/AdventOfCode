/* AoC 2019 - 10a
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
  dAngle = Math:Atan2(piBaseY - piObjY, piObjX - piBaseX) * (180 / Math:PI).
  IF dAngle < 0 THEN dAngle = dAngle + 360.
  RETURN dAngle.
END FUNCTION. /* getAngle */

RUN readData('2019-10-test5.dat').

FOR EACH ttAsteroid:
  RUN calcAngles(BUFFER ttAsteroid).
  PROCESS EVENTS.
END.

FOR EACH ttAsteroid BREAK BY ttAsteroid.iNumSee DESCENDING:
  MESSAGE SUBSTITUTE('Part 1: best is &1,&2 with &3 in sight', ttAsteroid.iPosX, ttAsteroid.iPosY, ttAsteroid.iNumSee) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  LEAVE.
END.

/* For part 2, save data to xml */
TEMP-TABLE ttAsteroid:WRITE-XML 
  ( 'file'           /* cTargetType */
  , 'ttAsteroid.xml' /* cFile */
  , YES              /* lFormatted */
  , ?                /* cEncoding */
  , ?                /* cSchemaLocation */
  , FALSE            /* lWriteSchema */
  , FALSE            /* lMinSchema*/
  ).


PROCEDURE calcAngles:
  DEFINE PARAMETER BUFFER bView FOR ttAsteroid.
  DEFINE BUFFER bAsteroid FOR ttAsteroid. 

  FOR EACH bAsteroid:
    IF ROWID(bAsteroid) = ROWID(bView) THEN
      ASSIGN
        bAsteroid.dAngle = 999
        bAsteroid.dDist  = 0.
    ELSE
      ASSIGN 
        bAsteroid.dAngle = getAngle(bView.iPosX, bView.iPosY, bAsteroid.iPosX, bAsteroid.iPosY)
        bAsteroid.dDist  = SQRT(EXP(bAsteroid.iPosX - bView.iPosX,2) + EXP(bAsteroid.iPosY - bView.iPosY,2) ).
  END.

  FOR EACH bAsteroid
    WHERE ROWID(bAsteroid) <> ROWID(bView)
    BREAK BY bAsteroid.dAngle BY bAsteroid.dDist:

    IF FIRST-OF(bAsteroid.dAngle) THEN bView.iNumSee = bView.iNumSee + 1.
  END.
END PROCEDURE. /* calcAngles */


PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iLine AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.

  DEFINE BUFFER bAsteroid FOR ttAsteroid. 
  
  INPUT FROM VALUE(pcFile).
  REPEAT:
    IMPORT UNFORMATTED cLine.
    DO i = 1 TO LENGTH(cLine).
      IF SUBSTRING(cLine,i,1) <> '#' THEN NEXT. 
      CREATE bAsteroid.
      ASSIGN 
        bAsteroid.iPosX = i - 1
        bAsteroid.iPosY = iLine.
    END.
    iLine = iLine + 1.
  END.
  INPUT CLOSE. 
END PROCEDURE. /* readData */

