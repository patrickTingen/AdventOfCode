/* AoC 2020 day 10
*/
DEFINE VARIABLE iOne   AS INT64 NO-UNDO.
DEFINE VARIABLE iThree AS INT64 NO-UNDO.
DEFINE VARIABLE iPrev  AS INT64 NO-UNDO.
DEFINE VARIABLE i      AS INT64 NO-UNDO.
DEFINE VARIABLE iJolts AS INT64 NO-UNDO EXTENT.
DEFINE VARIABLE iCache AS INT64 NO-UNDO EXTENT.

DEFINE TEMP-TABLE tt NO-UNDO
  FIELD j AS INTEGER
  INDEX iPrim j.

/* Import for sorting */
INPUT FROM "input.txt".
REPEAT:
  i = i + 1.
  CREATE tt.
  IMPORT tt.
END.
INPUT CLOSE. 

EXTENT(iJolts) = i + 1. /* one for own device */
i = 0.
FOR EACH tt:
  i = i + 1.
  iJolts[i] = tt.j.
END.
iJolts[EXTENT(iJolts)] = iJolts[EXTENT(iJolts) - 1] + 3.

DO i = 1 TO EXTENT(iJolts):
  IF (iJolts[i] - iPrev) = 1 THEN iOne = iOne + 1.
  IF (iJolts[i] - iPrev) = 3 THEN iThree = iThree + 1.
  iPrev = iJolts[i].
END.

MESSAGE 'Part 1:' iOne * iThree VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* Part 2 
*/
EXTENT(iCache) = EXTENT(iJolts).

FUNCTION getCombi RETURNS INT64 (a AS INT64):
  IF iCache[a] <> 0 THEN RETURN iCache[a].

  IF a >= EXTENT(iJolts) THEN RETURN 1.
  iCache[a] = getCombi(a + 1).

  IF a + 2 < EXTENT(iJolts) AND iJolts[a + 2] - iJolts[a] <= 3 THEN
    iCache[a] = iCache[a] + getCombi(a + 2).

  IF a + 3 < EXTENT(iJolts) AND iJolts[a + 3] - iJolts[a] <= 3 THEN 
    iCache[a] = iCache[a] + getCombi(a + 3).

  RETURN iCache[a].
END FUNCTION.

MESSAGE 'Part 2:' getCombi(1) /* 3947645370368 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.



