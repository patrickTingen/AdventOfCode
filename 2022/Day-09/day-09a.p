/* AoC 2022 day 09a 
 */ 
DEFINE VARIABLE cList   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cTail   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iHeadX  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iHeadY  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTailX  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTailY  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDir    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSteps  AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  IMPORT cDir iSteps.

  DO i = 1 TO iSteps:
  
    CASE cDir:
      WHEN 'U' THEN iHeadY = iHeadY + 1.
      WHEN 'D' THEN iHeadY = iHeadY - 1.
      WHEN 'L' THEN iHeadX = iHeadX - 1.
      WHEN 'R' THEN iHeadX = iHeadX + 1.
    END CASE.
    
    /* Head two steps ahead hor/ver */
    IF   ( (iHeadX = iTailX) AND ABS(iHeadY - iTailY) = 2 )
      OR ( (iHeadY = iTailY) AND ABS(iHeadX - iTailX) = 2 ) THEN 
    DO:
      iTailX = iTailX + (IF iHeadX > iTailX THEN 1 ELSE IF iHeadX < iTailX THEN -1 ELSE 0).
      iTailY = iTailY + (IF iHeadY > iTailY THEN 1 ELSE IF iHeadY < iTailY THEN -1 ELSE 0).
    END.

    ELSE
    /* Not touching and not in same row or col */
    IF    ( ABS(iHeadX - iTailX) > 1 OR ABS(iHeadY - iTailY) > 1 ) /* not touching */
      AND ( (iHeadX <> iTailX) OR (iHeadY <> iTailY) ) THEN /* not in same row or col */
    DO:
      iTailX = iTailX + (IF iHeadX > iTailX THEN 1 ELSE IF iHeadX < iTailX THEN -1 ELSE 0).
      iTailY = iTailY + (IF iHeadY > iTailY THEN 1 ELSE IF iHeadY < iTailY THEN -1 ELSE 0).
    END.

    cTail = SUBSTITUTE('&1,&2', iTailX, iTailY).
    IF LOOKUP(cTail, cList, '|') = 0 THEN cList = TRIM(cList + '|' + cTail, '|').
  END.
END.
INPUT CLOSE. 

MESSAGE NUM-ENTRIES(cList, '|')
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
