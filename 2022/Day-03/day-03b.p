/* AoC 2022 day 03b
 */ 
DEFINE VARIABLE cSack  AS CHARACTER NO-UNDO CASE-SENSITIVE EXTENT 3.
DEFINE VARIABLE cItem  AS CHARACTER NO-UNDO CASE-SENSITIVE.
DEFINE VARIABLE iTotal AS INTEGER   NO-UNDO.
DEFINE VARIABLE iScore AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.

INPUT FROM data.txt.

#SetOf3:
REPEAT:
  cSack = ''.

  IMPORT cSack[1].
  IMPORT cSack[2].
  IMPORT cSack[3].

  #ItemLoop:
  DO i = 1 TO LENGTH(cSack[1]):

    cItem = SUBSTRING(cSack[1],i,1).
    IF   INDEX(cSack[2], cItem) = 0 
      OR INDEX(cSack[3], cItem) = 0 THEN NEXT #ItemLoop.

    iScore = ASC(cItem) - 96.
    IF iScore < 0 THEN iScore = iScore + 58.
    iTotal = iTotal + iScore.

    NEXT #SetOf3.
  END.  
END.

INPUT CLOSE. 

MESSAGE iTotal
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
