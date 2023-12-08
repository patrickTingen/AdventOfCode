/* AoC 2023 day 08b
 */ 
DEFINE TEMP-TABLE ttNav NO-UNDO
  FIELD cPoint AS CHARACTER 
  FIELD cLeft  AS CHARACTER 
  FIELD cRight AS CHARACTER 
  INDEX iPrim IS PRIMARY UNIQUE cPoint. 

DEFINE TEMP-TABLE ttGhost NO-UNDO
  FIELD cCurrent AS CHARACTER
  FIELD iSteps   AS INTEGER.

DEFINE VARIABLE cRoute  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INT64     NO-UNDO.

FUNCTION gcd RETURNS INT64 (pX AS INT64, pY AS INT64):
  IF py = 0 THEN RETURN pX.
  RETURN gcd(pY, pX MOD pY).
END FUNCTION.

FUNCTION lcm RETURNS INT64 (pX AS INT64, pY AS INT64):
  RETURN INT64((pX * pY) / gcd(pX, pY)).
END FUNCTION.

INPUT FROM "data.txt".
IMPORT cRoute.

REPEAT :
  IMPORT UNFORMATTED cLine.
  IF cLine = "" THEN NEXT. 

  CREATE ttNav.
  ASSIGN 
    ttNav.cPoint = TRIM(ENTRY(1,cLine,' '))
    ttNav.cLeft  = TRIM(ENTRY(1, ENTRY(2,cLine,'('),','))
    ttNav.cRight = TRIM(ENTRY(1, ENTRY(2,cLine,','),')')).

  IF ttNav.cPoint MATCHES "..A" THEN 
  DO:
    CREATE ttGhost.
    ASSIGN ttGhost.cCurrent = ttNav.cPoint.
  END.
END.
INPUT CLOSE. 

FOR EACH ttGhost:

  #FindExit:
  REPEAT:
    DO i = 1 TO LENGTH(cRoute):
      ttGhost.iSteps = ttGhost.iSteps + 1.
      FIND ttNav WHERE ttNav.cPoint = ttGhost.cCurrent. 
      ttGhost.cCurrent = (IF SUBSTRING(cRoute,i,1) = "L" THEN ttNav.cLeft ELSE ttNav.cRight).
      IF ttGhost.cCurrent MATCHES "..Z" THEN LEAVE #FindExit.
    END.
  END.

  iAnswer = (IF iAnswer = 0 THEN ttGhost.iSteps ELSE lcm(iAnswer, ttGhost.iSteps)).
END.

MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


