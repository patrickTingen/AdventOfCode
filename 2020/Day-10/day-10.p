/* AoC 2020 day 10
*/
DEFINE VARIABLE iOne   AS INTEGER NO-UNDO.
DEFINE VARIABLE iThree AS INTEGER NO-UNDO.
DEFINE VARIABLE iPrev  AS INTEGER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER NO-UNDO.
DEFINE VARIABLE jolts  AS INTEGER NO-UNDO EXTENT.

DEFINE TEMP-TABLE tt NO-UNDO
  FIELD j AS INTEGER
  INDEX iPrim j.

ETIME(YES).
INPUT FROM "test2.txt".
REPEAT:
  i = i + 1.
  CREATE tt.
  IMPORT tt.
END.
INPUT CLOSE. 

EXTENT(jolts) = i + 1. /* one for own device */
i = 0.
FOR EACH tt:
  i = i + 1.
  jolts[i] = tt.j.
END.
jolts[EXTENT(jolts)] = jolts[EXTENT(jolts) - 1] + 3.

DO i = 1 TO EXTENT(jolts):
  IF (jolts[i] - iPrev) = 1 THEN iOne = iOne + 1.
  IF (jolts[i] - iPrev) = 3 THEN iThree = iThree + 1.
  iPrev = jolts[i].
END.

MESSAGE 'Part 1:' iOne * iThree SKIP 
        'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

FUNCTION getArrangements RETURNS INTEGER (a AS INTEGER):
  DEFINE VARIABLE j AS INTEGER NO-UNDO.
  DEFINE VARIABLE r AS INTEGER NO-UNDO.

  IF a >= EXTENT(jolts) THEN RETURN 1.

  j = jolts[a].
  r = getArrangements(a + 1).

  IF a + 2 < EXTENT(jolts) AND jolts[a + 2] - j <= 3 THEN
    r = r + getArrangements(a + 2).

  IF a + 3 < EXTENT(jolts) AND jolts[a + 3] - j <= 3 THEN 
    r = r + getArrangements(a + 3).

  RETURN r.
END FUNCTION.

ETIME(YES).
MESSAGE 'Part 2:' getArrangements(1) SKIP 
        'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
