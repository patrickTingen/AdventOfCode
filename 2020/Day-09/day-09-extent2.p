/* AoC 2020 - day 9 with array
*/
DEFINE VARIABLE dVal      AS DECIMAL NO-UNDO EXTENT 1000.
DEFINE VARIABLE iPreamble AS INTEGER NO-UNDO INITIAL 5.
DEFINE VARIABLE dInvalid  AS DECIMAL NO-UNDO.
DEFINE VARIABLE i         AS INTEGER NO-UNDO.
DEFINE VARIABLE a         AS INTEGER NO-UNDO.
DEFINE VARIABLE b         AS INTEGER NO-UNDO.
DEFINE VARIABLE dSum      AS DECIMAL NO-UNDO.
DEFINE VARIABLE dMin      AS DECIMAL NO-UNDO.
DEFINE VARIABLE dMax      AS DECIMAL NO-UNDO.

ETIME(YES).
INPUT FROM "test.txt".

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

DEFINE VARIABLE iStart AS INTEGER NO-UNDO INITIAL 1.
DEFINE VARIABLE iEnd   AS INTEGER NO-UNDO INITIAL 1.

dSum = dVal[1].
REPEAT WHILE dSum <> dInvalid: 
  IF dSum < dInvalid THEN 
    ASSIGN iEnd = iEnd + 1 dSum = dSum + dVal[iEnd].
  ELSE
    ASSIGN iStart = iStart + 1 dSum = dSum - dVal[iStart].

 MESSAGE iStart iEnd dSum VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* debug */
END.

/* Get min/max */
dMin = dVal[iStart].
dMax = dVal[iStart].

DO i = iStart TO iEnd:
  dMin = MINIMUM(dMin, dVal[i]).
  dMax = MAXIMUM(dMax, dVal[i]).
END.

MESSAGE 'Part 2:' dMin + dMax SKIP 'Time:' ETIME 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

