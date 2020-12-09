/* AoC 2020 - day 9
*/
DEFINE TEMP-TABLE tt NO-UNDO
  FIELD iNr  AS INTEGER
  FIELD dVal AS DECIMAL 
  INDEX iPrim iNr.

DEFINE VARIABLE i         AS INTEGER NO-UNDO.
DEFINE VARIABLE iPreamble AS INTEGER NO-UNDO INITIAL 25.
DEFINE VARIABLE dInvalid  AS DECIMAL NO-UNDO.
DEFINE VARIABLE dSum      AS DECIMAL NO-UNDO.
DEFINE VARIABLE dMin      AS DECIMAL NO-UNDO.
DEFINE VARIABLE dMax      AS DECIMAL NO-UNDO.

DEFINE BUFFER b2 FOR tt.
DEFINE BUFFER b3 FOR tt.

ETIME(YES).
INPUT FROM "input.txt".

#main:
REPEAT:
  CREATE tt.
  i = i + 1.
  tt.iNr = i.
  IMPORT tt.dVal.

  IF i > iPreamble THEN 
  DO:
    FOR EACH b2 WHERE b2.iNr  >= (i - iPreamble) AND b2.dVal <= tt.dVal:
      IF CAN-FIND(FIRST b3 WHERE b3.iNr >= (i - iPreamble) AND b3.iNr < tt.iNr AND b3.dVal + b2.dVal = tt.dVal) THEN NEXT #main.
    END.

    dInvalid = tt.dVal.
    MESSAGE 'Part 1:' dInvalid SKIP 'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 373803594 */
    LEAVE #main.
  END.

END.
INPUT CLOSE. 

/* Part 2, find series of nrs that add up to result from step 1 */
ETIME(YES).
FOR EACH tt:
  dSum = 0.
  dMin = tt.dVal.
  dMax = tt.dVal.
  FOR EACH b2 WHERE b2.iNr >= tt.iNr:
    dSum = dSum + b2.dVal.
    dMin = MINIMUM(dMin, b2.dVal).
    dMax = MAXIMUM(dMax, b2.dVal).

    IF dSum = dInvalid AND b2.iNr > tt.iNr THEN 
    DO:
      MESSAGE 'Part 2:' dMin + dMax SKIP 'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      STOP.
    END.
  END.
END.


