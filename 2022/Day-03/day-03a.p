/* AoC 2022 day 03a 
 */ 
DEFINE VARIABLE cSack  AS CHARACTER   NO-UNDO. 
DEFINE VARIABLE cCompA AS CHARACTER   NO-UNDO CASE-SENSITIVE.
DEFINE VARIABLE cCompB AS CHARACTER   NO-UNDO CASE-SENSITIVE.
DEFINE VARIABLE cItem  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iLen   AS INTEGER     NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER     NO-UNDO.
DEFINE VARIABLE iScore AS INTEGER     NO-UNDO.
DEFINE VARIABLE i      AS INTEGER     NO-UNDO.

INPUT FROM data.txt.

#ItemLoop:
REPEAT:
  cSack = ''.
  IMPORT cSack.
  IF cSack = '' THEN LEAVE #ItemLoop.
  
  iLen = LENGTH(cSack) / 2.
  
  cCompA = SUBSTRING(cSack,1,iLen).
  cCompB = SUBSTRING(cSack,iLen + 1).
  
  DO i = 1 TO iLen:
    cItem = SUBSTRING(cCompA,i,1).
    IF INDEX(cCompB, cItem) > 0 THEN
    DO:
      iScore = ASC(cItem) - 96.
      IF iScore < 0 THEN iScore = iScore + 58.
      iTotal = iTotal + iScore.
      
      NEXT #ItemLoop.
    END.
  END.  
END.

INPUT CLOSE. 

MESSAGE iTotal
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
