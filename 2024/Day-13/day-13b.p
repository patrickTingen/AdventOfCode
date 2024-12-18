/* AoC 2024 day 13b 
 */ 
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE btnA   AS INT64     NO-UNDO EXTENT 2 format '>>>>9'.
DEFINE VARIABLE btnB   AS INT64     NO-UNDO EXTENT 2 format '>>>>9'.
DEFINE VARIABLE win    AS INT64     NO-UNDO EXTENT 2 format '>>>>9'.
DEFINE VARIABLE i      AS INT64     NO-UNDO.
DEFINE VARIABLE X      AS INTEGER   NO-UNDO INITIAL 1.
DEFINE VARIABLE Y      AS INTEGER   NO-UNDO INITIAL 2.
DEFINE VARIABLE dPushA AS DECIMAL   NO-UNDO.
DEFINE VARIABLE dPushB AS DECIMAL   NO-UNDO.
DEFINE VARIABLE iTotal AS INT64     NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".
REPEAT:
  DO i = 1 TO 4:
    IMPORT UNFORMATTED cLine. 
    IF cLine = '' THEN NEXT. 
  
    cLine = REPLACE(cLine," ","").  /* ButtonA,X,94,Y,34 */
    cLine = REPLACE(cLine,":",","). /* ButtonA,X+94,Y+34 */
    cLine = REPLACE(cLine,"+",","). /* ButtonA,X,94,Y,34 */
    cLine = REPLACE(cLine,"=",","). /* Prize,X,8400,Y,5400 */
  
    IF i = 1 THEN ASSIGN btnA[x] = INT64(ENTRY(3,cLine))
                         btnA[y] = INT64(ENTRY(5,cLine)).
  
    IF i = 2 THEN ASSIGN btnB[x] = INT64(ENTRY(3,cLine))
                         btnB[y] = INT64(ENTRY(5,cLine)).
  
    IF i = 3 THEN ASSIGN win[x]  = INT64(ENTRY(3,cLine)) + 10000000000000
                         win[y]  = INT64(ENTRY(5,cLine)) + 10000000000000.
  END.

  ASSIGN 
    dPushB = (win[y] * btnA[x] - btnA[y] * win[x]) / (btnB[y] * btnA[x] - btnA[y] * btnB[x])
    dPushA = (win[x] - btnB[x] * dPushB) / btnA[x].

  IF dPushA = INT64(dPushA) AND dPushB = INT64(dPushB) THEN 
    iTotal = iTotal + (dPushA * 3 + dPushB).
END.
INPUT CLOSE. 

MESSAGE iTotal "in" ETIME "ms" /* 108394825772874 in 9 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
