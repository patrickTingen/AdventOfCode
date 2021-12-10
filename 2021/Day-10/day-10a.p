/* AoC 2021 day 10a 
 */ 
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cBefore AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iScore  AS INTEGER   NO-UNDO.

INPUT FROM data.txt.

REPEAT:
  IMPORT cLine.

  REPEAT :
    cBefore = cLine.
    cLine = REPLACE(cLine,'()','').
    cLine = REPLACE(cLine,'[]','').
    cLine = REPLACE(cLine,'<>','').
    cLine = REPLACE(cLine,'~{}','').
    IF cLine = '' OR cLine = cBefore THEN LEAVE. 
  END.
  
  DO i = 1 TO LENGTH(cLine):

    IF LOOKUP(SUBSTRING(cLine,i,1), "],},),>") > 0 THEN
    DO:
      CASE SUBSTRING(cLine,i,1):
        WHEN ")" THEN iScore = iScore + 3.
        WHEN "]" THEN iScore = iScore + 57.
        WHEN "}" THEN iScore = iScore + 1197.
        WHEN ">" THEN iScore = iScore + 25137.
      END CASE.
      LEAVE.
    END.
  END.
END.
INPUT CLOSE. 

MESSAGE iScore VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 392097 */

