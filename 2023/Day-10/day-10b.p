/* AoC 2023 day 10b (does not work :( )
 */ 
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iCurX   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCurY   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartX AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartY AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSteps  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDir    AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttPipe NO-UNDO
  FIELD iX AS INTEGER
  FIELD iY AS INTEGER
  INDEX iPrim iX iY.
  
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
cData = cData.

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
  FIND ttPipe WHERE ttPipe.iX = iCurX AND ttPipe.iY = iCurY NO-ERROR.
  IF NOT AVAILABLE ttPipe THEN CREATE ttPipe.
  ASSIGN ttPipe.iX = iCurX ttPipe.iY = iCurY.
  
  IF iCurX = iStartX AND iCurY = iStartY THEN LEAVE.   
END.

DEFINE VARIABLE i  AS INTEGER     NO-UNDO.
DEFINE VARIABLE xx AS INTEGER     NO-UNDO.
DEFINE VARIABLE yy AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCount AS INTEGER NO-UNDO.
DEFINE VARIABLE iNum AS INTEGER     NO-UNDO.
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.

DO yy = 1 TO NUM-ENTRIES(cData,"~n"):
  
  cLine = ENTRY(yy,cData,"~n").
  iNum = 0.    

  DO xx = 1 TO LENGTH(cLine):

    IF ETIME > 1000 THEN
    DO:
      HIDE MESSAGE NO-PAUSE.
      MESSAGE xx '/' yy ' (' iCount ')'.
      PROCESS EVENTS.
      ETIME(YES).      
    END.     

    IF LOOKUP(point(xx,yy),'|,L,J') > 0 AND CAN-FIND(ttPipe WHERE ttPipe.iX = xx AND ttPipe.iY = yy) THEN iNum = iNum + 1.
    IF point(xx,yy) = '.' AND iNum MOD 2 = 1 THEN iCount = iCount + 1.
    
  END.
END.

MESSAGE iCount
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
/* answer somewhere < 1235 */  











