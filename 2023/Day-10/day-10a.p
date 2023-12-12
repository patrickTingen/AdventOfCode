/* AoC 2023 day 10a 
 */ 
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iCurX   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCurY   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartX AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartY AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSteps  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDir    AS CHARACTER NO-UNDO.
  
FUNCTION point RETURNS CHARACTER (pX AS INTEGER, pY AS INTEGER):
  RETURN (IF pX > 0 AND pY > 0 AND pX < LENGTH(ENTRY(1,cData,'~n')) AND pY < NUM-ENTRIES(cData,'~n') THEN STRING(SUBSTRING(ENTRY(pY,cData,'~n'),pX,1)) ELSE "").
END FUNCTION.

FUNCTION canDown RETURNS LOGICAL (pX AS INTEGER, pY AS INTEGER):
  RETURN LOOKUP(point(iCurX + pX,iCurY + pY),'|,F,7') > 0.
END FUNCTION.

FUNCTION canLeft RETURNS LOGICAL (pX AS INTEGER, pY AS INTEGER):
  RETURN LOOKUP(point(iCurX + pX,iCurY + pY),'-,7,J') > 0.
END FUNCTION.

FUNCTION canUp RETURNS LOGICAL (pX AS INTEGER, pY AS INTEGER):
  RETURN LOOKUP(point(iCurX + pX,iCurY + pY),'|,J,L') > 0.
END FUNCTION.

FUNCTION canRight RETURNS LOGICAL (pX AS INTEGER, pY AS INTEGER):
  RETURN LOOKUP(point(iCurX + pX,iCurY + pY),'-,L,F') > 0.
END FUNCTION.

COPY-LOB FILE "data.txt" TO cData.

/* Find start position */
iStartX = INDEX(cData,'S') - R-INDEX(cData,'~n',INDEX(cData,'S')).
iStartY = NUM-ENTRIES(SUBSTRING(cData,1,INDEX(cData,'S')),'~n').

iCurX = iStartX. 
iCurY = iStartY.

/* Replace S with appropriate letter */
OVERLAY(cData, ((iCurY - 1) * LENGTH(ENTRY(1,cData,'~n'))) + (iCurY - 1) + iCurX) 
  = (IF       canUp(0,1)     AND canDown(0,-1)  THEN '|'
      ELSE IF canRight(-1,0) AND canLeft(1,0)   THEN '-'
      ELSE IF canDown(0,-1)  AND canLeft(1,0)   THEN 'L'
      ELSE IF canDown(0,-1)  AND canRight(-1,0) THEN 'J'
      ELSE IF canUp(0,1)     AND canRight(-1,0) THEN '7'
      ELSE IF canUp(0,1)     AND canLeft(1,0)   THEN 'F' ELSE '').

REPEAT:

  IF       ( canUp(0,0)    AND canDown(0,0) ) THEN IF cDir = 'U' THEN cDir = 'U'. ELSE cDir = 'D'.
   ELSE IF ( canRight(0,0) AND canLeft(0,0) ) THEN IF cDir = 'R' THEN cDir = 'R'. ELSE cDir = 'L'.
   ELSE IF ( canDown(0,0)  AND canLeft(0,0) ) THEN IF cDir = 'U' THEN cDir = 'L'. ELSE cDir = 'D'.
   ELSE IF ( canDown(0,0)  AND canRight(0,0)) THEN IF cDir = 'U' THEN cDir = 'R'. ELSE cDir = 'D'.
   ELSE IF ( canUp(0,0)    AND canRight(0,0)) THEN IF cDir = 'D' THEN cDir = 'R'. ELSE cDir = 'U'.
   ELSE IF ( canUp(0,0)    AND canLeft(0,0) ) THEN IF cDir = 'D' THEN cDir = 'L'. ELSE cDir = 'U'.
   ELSE ''.

  CASE cDir:
    WHEN 'R' THEN iCurX = iCurX + 1.
    WHEN 'L' THEN iCurX = iCurX - 1.
    WHEN 'D' THEN iCurY = iCurY + 1.
    WHEN 'U' THEN iCurY = iCurY - 1.
  END CASE.

  iSteps = iSteps + 1.
  IF iCurX = iStartX AND iCurY = iStartY THEN LEAVE.   
END.

MESSAGE INTEGER(iSteps / 2) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

           
