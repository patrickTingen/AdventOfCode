/* Advent of code 
 * 2016-1a
 */
&GLOBAL-DEFINE NORTH 1
&GLOBAL-DEFINE EAST  2
&GLOBAL-DEFINE SOUTH 3
&GLOBAL-DEFINE WEST  4

DEFINE VARIABLE cRoute    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iPosX     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPosY     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iNose     AS INTEGER     NO-UNDO. 
DEFINE VARIABLE i         AS INTEGER     NO-UNDO.
DEFINE VARIABLE cTurn     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iNumSteps AS INTEGER     NO-UNDO.
DEFINE VARIABLE iStep     AS INTEGER     NO-UNDO.

cRoute   = 'L1, L5, R1, R3, L4, L5, R5, R1, L2, L2, L3, R4, L2, R3, R1, L2, R5, R3, L4, R4, L3, R3, R3, L2, R1, L3, R2, L1, R4, L2, R4, L4, R5, L3, R1, R1, L1, L3, L2, R1, R3, R2, L1, R4, L4, R2, L189, L4, R5, R3, L1, R47, R4, R1, R3, L3, L3, L2, R70, L1, R4, R185, R5, L4, L5, R4, L1, L4, R5, L3, R2, R3, L5, L3, R5, L1, R5, L4, R1, R2, L2, L5, L2, R4, L3, R5, R1, L5, L4, L3, R4, L3, L4, L1, L5, L5, R5, L5, L2, L1, L2, L4, L1, L2, R3, R1, R1, L2, L5, R2, L3, L5, L4, L2, L1, L2, R3, L1, L4, R3, R3, L2, R5, L1, L3, L3, L3, L5, R5, R1, R2, L3, L2, R4, R1, R1, R3, R4, R3, L3, R3, L5, R2, L2, R4, R5, L4, L3, L1, L5, L1, R1, R2, L1, R3, R4, R5, R2, R3, L2, L1, L5'.
iNose = {&NORTH}.

DO i = 1 TO NUM-ENTRIES(cRoute):
  cTurn = TRIM(ENTRY(i,cRoute)).

  IF cTurn BEGINS 'L' THEN iNose = iNose - 1.
  IF iNose = 0 THEN iNose = 4.

  IF cTurn BEGINS 'R' THEN iNose = iNose + 1.
  IF iNose = 5 THEN iNose = 1.

  iNumSteps = INTEGER(SUBSTRING(cTurn,2)).

  CASE iNose:
    WHEN {&NORTH} THEN iPosY = iPosY - iNumSteps. /* N */
    WHEN {&EAST}  THEN iPosX = iPosX + iNumSteps. /* E */
    WHEN {&SOUTH} THEN iPosY = iPosY + iNumSteps. /* S */
    WHEN {&WEST}  THEN iPosX = iPosX - iNumSteps. /* W */
  END CASE.
END.

MESSAGE iPosX iPosY '=' ABS(iPosX) + ABS(iPosY) VIEW-AS ALERT-BOX INFO BUTTONS OK.

