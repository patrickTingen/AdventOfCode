/* AoC 2022 day 09b 
 */ 
DEFINE VARIABLE cList  AS LONGCHAR  NO-UNDO EXTENT 2.
DEFINE VARIABLE cTail  AS CHARACTER NO-UNDO EXTENT 2.
DEFINE VARIABLE iKnotX AS INTEGER   NO-UNDO EXTENT 10.
DEFINE VARIABLE iKnotY AS INTEGER   NO-UNDO EXTENT 10.
DEFINE VARIABLE cDir   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSteps AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE j      AS INTEGER   NO-UNDO.

ETIME(YES).

INPUT FROM data.txt.
REPEAT:
  IMPORT cDir iSteps.

  DO i = 1 TO iSteps:
  
    CASE cDir:
      WHEN 'U' THEN iKnotY[1] = iKnotY[1] + 1.
      WHEN 'D' THEN iKnotY[1] = iKnotY[1] - 1.
      WHEN 'L' THEN iKnotX[1] = iKnotX[1] - 1.
      WHEN 'R' THEN iKnotX[1] = iKnotX[1] + 1.
    END CASE.
    
    DO j = 2 TO 10:

      /* Head two steps ahead hor/ver */
      IF   ( (iKnotX[j - 1] = iKnotX[j]) AND ABS(iKnotY[j - 1] - iKnotY[j]) = 2 )
        OR ( (iKnotY[j - 1] = iKnotY[j]) AND ABS(iKnotX[j - 1] - iKnotX[j]) = 2 ) THEN 
      DO:
        iKnotX[j] = iKnotX[j] + (IF iKnotX[j - 1] > iKnotX[j] THEN 1 ELSE IF iKnotX[j - 1] < iKnotX[j] THEN -1 ELSE 0).
        iKnotY[j] = iKnotY[j] + (IF iKnotY[j - 1] > iKnotY[j] THEN 1 ELSE IF iKnotY[j - 1] < iKnotY[j] THEN -1 ELSE 0).
      END.
  
      ELSE
      /* Not touching and not in same row or col */
      IF    ( ABS(iKnotX[j - 1] - iKnotX[j]) > 1 OR ABS(iKnotY[j - 1] - iKnotY[j]) > 1 ) /* not touching */
        AND ( (iKnotX[j - 1] <> iKnotX[j]) OR (iKnotY[j - 1] <> iKnotY[j]) ) THEN /* not in same row or col */
      DO:
        iKnotX[j] = iKnotX[j] + (IF iKnotX[j - 1] > iKnotX[j] THEN 1 ELSE IF iKnotX[j - 1] < iKnotX[j] THEN -1 ELSE 0).
        iKnotY[j] = iKnotY[j] + (IF iKnotY[j - 1] > iKnotY[j] THEN 1 ELSE IF iKnotY[j - 1] < iKnotY[j] THEN -1 ELSE 0).
      END.
    END.
  
    /* Part A */
    cTail[1] = SUBSTITUTE('&1,&2', iKnotX[2], iKnotY[2]).
    IF LOOKUP(cTail[1], cList[1], '|') = 0 THEN cList[1] = TRIM(cList[1] + '|' + cTail[1], '|').

    /* Part B */
    cTail[2] = SUBSTITUTE('&1,&2', iKnotX[10], iKnotY[10]).
    IF LOOKUP(cTail[2], cList[2], '|') = 0 THEN cList[2] = TRIM(cList[2] + '|' + cTail[2], '|').
  END.
END.
INPUT CLOSE. 

MESSAGE "Part A:" NUM-ENTRIES(cList[1], '|')
   SKIP "Part B:" NUM-ENTRIES(cList[2], '|')
   SKIP "In" ETIME "ms"
   VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
