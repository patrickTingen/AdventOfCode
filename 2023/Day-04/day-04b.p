/* AoC 2023 day 04b 
 */ 
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iAnswer AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cNr     AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttCard NO-UNDO
  FIELD iId      AS INTEGER   FORMAT ">>>9"
  FIELD cWinning AS CHARACTER FORMAT "x(20)"
  FIELD cNumbers AS CHARACTER FORMAT "x(25)"
  FIELD iMatches AS INTEGER   FORMAT ">9"
  FIELD iScore   AS INTEGER   FORMAT ">9"
  INDEX iPrim iId.

DEFINE BUFFER btCard FOR ttCard.

INPUT FROM "data.txt".
REPEAT:
  IMPORT UNFORMATTED cLine.

  REPEAT WHILE INDEX(cLine,'  ') > 0:
    cLine = REPLACE(cLine,'  ', ' ').
  END.

  CREATE ttCard.
  ASSIGN 
    ttCard.iId      = INTEGER(ENTRY(2, ENTRY(1, cLine, ":"),' '))
    ttCard.cWinning = TRIM(ENTRY(2,ENTRY(1,cLine,"|"), ":"))
    ttCard.cNumbers = TRIM(ENTRY(2,cLine,"|"))
    ttCard.iScore   = 1.

  DO i = 1 TO NUM-ENTRIES(ttCard.cNumbers,' '):
    cNr = ENTRY(i,ttCard.cNumbers,' ').
    IF cNr = '' THEN NEXT. 

    IF LOOKUP(cNr, ttCard.cWinning,' ') > 0 THEN 
      ASSIGN ttCard.iMatches = ttCard.iMatches + 1.
  END.
END.
INPUT CLOSE. 

/* Part b */
FOR EACH ttCard:
  iAnswer = iAnswer + ttCard.iScore.

  DO i = 1 TO ttCard.iMatches:
    FIND btCard WHERE btCard.iId = ttCard.iId + i.
    btCard.iScore = btCard.iScore + ttCard.iScore.
  END.
END.

MESSAGE iAnswer 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.



