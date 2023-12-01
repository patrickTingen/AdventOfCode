/* AoC 2023 day 01b
 */ 
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE j       AS INTEGER   NO-UNDO.
DEFINE VARIABLE d       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDigit  AS CHARACTER NO-UNDO EXTENT 9 INITIAL ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"].
  
COPY-LOB FILE "data.txt" TO cData.

DO i = 1 TO NUM-ENTRIES(cData,'~n'):

  cLine = ENTRY(i,cData,'~n').
  
  /* Replace written digits */
  #ReplaceLeft:
  DO j = 1 TO LENGTH(cLine):
    DO d = 1 TO 9:
      IF LOOKUP(SUBSTRING(cLine,j,1), "0,1,2,3,4,5,6,7,8,9") > 0 THEN LEAVE #ReplaceLeft.
      IF SUBSTRING(cLine,j,LENGTH(cDigit[d])) = cDigit[d] THEN
      DO:
        SUBSTRING(cLine,j,LENGTH(cDigit[d])) = STRING(d).
        LEAVE #ReplaceLeft.
      END.
    END.
  END.

  /* Replace written digits */
  #ReplaceRight:
  DO j = LENGTH(cLine) TO 1 BY -1:
    IF LOOKUP(SUBSTRING(cLine,j,1), "0,1,2,3,4,5,6,7,8,9") > 0 THEN LEAVE #ReplaceRight.
    DO d = 1 TO 9:
      IF SUBSTRING(cLine,j,LENGTH(cDigit[d])) = cDigit[d] THEN
      DO:
        SUBSTRING(cLine,j,LENGTH(cDigit[d])) = STRING(d).
        LEAVE #ReplaceRight.
      END.
    END.
  END.  

  DO j = 1 TO 26:
    cLine = REPLACE(cLine, CHR(96 + j), '').
  END.  
    
  IF cLine > "" THEN iAnswer = iAnswer + INTEGER(SUBSTRING(cLine,1,1) + SUBSTRING(cLine,LENGTH(cLine) - 1,1)).
END.

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  

  
  
  
  
  
