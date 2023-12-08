/* AoC 2023 day 08a 
 */ 
DEFINE TEMP-TABLE ttNav NO-UNDO
  FIELD cPoint AS CHARACTER 
  FIELD cLeft  AS CHARACTER 
  FIELD cRight AS CHARACTER 
  INDEX iPrim IS PRIMARY UNIQUE cPoint. 

DEFINE VARIABLE cRoute   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE cCurrent AS CHARACTER NO-UNDO INITIAL "AAA".
DEFINE VARIABLE iSteps   AS INTEGER   NO-UNDO.

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
END.
INPUT CLOSE. 

#FindExit:
REPEAT:
  DO i = 1 TO LENGTH(cRoute):
    iSteps = iSteps + 1.
    FIND ttNav WHERE ttNav.cPoint = cCurrent. 
    cCurrent = (IF SUBSTRING(cRoute,i,1) = "L" THEN ttNav.cLeft ELSE ttNav.cRight).
    IF cCurrent = "ZZZ" THEN LEAVE #FindExit.
  END.
END.

MESSAGE iSteps VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
