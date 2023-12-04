/* AoC 2023 day 04a 
 */ 
DEFINE VARIABLE cLine      AS CHARACTER NO-UNDO.
DEFINE VARIABLE cMyNumbers AS CHARACTER NO-UNDO.
DEFINE VARIABLE cWinning   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iScore     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer    AS INTEGER   NO-UNDO.
DEFINE VARIABLE i          AS INTEGER   NO-UNDO.
DEFINE VARIABLE cNr        AS CHARACTER NO-UNDO.
DEFINE VARIABLE iWin       AS INTEGER   NO-UNDO.

INPUT FROM "test.txt".
REPEAT:
  IMPORT UNFORMATTED cLine.

  cMyNumbers = TRIM(ENTRY(2,cLine,"|")).
  cWinning   = TRIM(ENTRY(2,ENTRY(1,cLine,"|"), ":")).
  iScore     = 0.

  DO i = 1 TO NUM-ENTRIES(cMyNumbers,' '):
    cNr = ENTRY(i,cMyNumbers,' ').
    iWin = LOOKUP(cNr, cWinning,' ').
    IF iWin > 0 THEN iScore = (IF iScore = 0 THEN 1 ELSE iScore * 2).
  END.
  iAnswer = iAnswer + iScore.

END.
INPUT CLOSE. 

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
