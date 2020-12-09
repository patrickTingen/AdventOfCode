/* AoC 2020 - day 9 with array
*/
DEFINE VARIABLE dVal      AS DECIMAL NO-UNDO EXTENT 1000.
DEFINE VARIABLE iPreamble AS INTEGER NO-UNDO INITIAL 25.
DEFINE VARIABLE dInvalid  AS DECIMAL NO-UNDO.
DEFINE VARIABLE i         AS INTEGER NO-UNDO.
DEFINE VARIABLE a         AS INTEGER NO-UNDO.
DEFINE VARIABLE b         AS INTEGER NO-UNDO.
DEFINE VARIABLE dSum      AS DECIMAL NO-UNDO.
DEFINE VARIABLE dMin      AS DECIMAL NO-UNDO.
DEFINE VARIABLE dMax      AS DECIMAL NO-UNDO.

ETIME(YES).
INPUT FROM "input.txt".

#main:
REPEAT:
  i = i + 1.
  IMPORT dVal[i].

  IF i > iPreamble THEN 
  DO:
    DO a = (i - iPreamble) TO i:
      DO b = a TO i:
        IF dVal[a] + dVal[b] = dVal[i] THEN NEXT #main.
      END.
    END.

    dInvalid = dVal[i].
    MESSAGE 'Part 1:' dInvalid SKIP 'Time:' ETIME 
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 373803594 */

    LEAVE #main.
  END.

END.
INPUT CLOSE. 

/* Part 2, find series of nrs that add up to result from step 1 */
ETIME(YES).

#main:
DO a = 1 TO EXTENT(dVal):
  dSum = 0.
  dMin = dVal[a].
  dMax = dVal[a].
  DO b = a TO EXTENT(dVal):
    dSum = dSum + dVal[b].
    dMin = MINIMUM(dMin, dVal[b]).
    dMax = MAXIMUM(dMax, dVal[b]).

    IF dSum > dInvalid THEN NEXT #main.
    IF dSum = dInvalid AND b > a THEN 
    DO:
      MESSAGE 'Part 2:' dMin + dMax SKIP 'Time:' ETIME 
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      STOP.
    END.
  END.
END.
