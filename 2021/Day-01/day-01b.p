/* AoC 2021 day 01b 
 */ 
DEFINE VARIABLE iNumber AS INTEGER NO-UNDO EXTENT 2000. 
DEFINE VARIABLE i       AS INTEGER NO-UNDO.
DEFINE VARIABLE iCount  AS INTEGER NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  i = i + 1.
  IMPORT iNumber[i].
END.
INPUT CLOSE.

DO i = 1 TO 1997:
  IF  (iNumber[i + 1] + iNumber[i + 2] + iNumber[i + 3])
    > (iNumber[i + 0] + iNumber[i + 1] + iNumber[i + 2]) THEN iCount = iCount + 1.
END.

MESSAGE 'Part 2:' iCount VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
