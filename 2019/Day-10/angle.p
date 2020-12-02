

USING System.Math.

FUNCTION getAngle RETURNS DECIMAL 
  (piBaseX AS INT, piBaseY AS INT, piObjX AS INT, piObjY AS INT):
  DEFINE VARIABLE dAngle AS DECIMAL NO-UNDO.

  dAngle = Math:Atan2(piObjX - piBaseX, piObjY - piBaseY) * (180 / Math:PI).

  IF dAngle < 0 THEN dAngle = dAngle + 360.
  RETURN dAngle.
END FUNCTION. /* getAngle */


MESSAGE getAngle(11,13 , 13,15)
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
