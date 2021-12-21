/* AoC 2021 day 21a 
 */ 
DEFINE VARIABLE iScore  AS INTEGER NO-UNDO EXTENT 2 INITIAL [0,0].
DEFINE VARIABLE iPos    AS INTEGER NO-UNDO EXTENT 2 INITIAL [7,1].
DEFINE VARIABLE iPlayer AS INTEGER NO-UNDO INITIAL 1. 

DEFINE VARIABLE iTurn   AS INTEGER NO-UNDO.
DEFINE VARIABLE iDie    AS INTEGER NO-UNDO.
DEFINE VARIABLE iRolls  AS INTEGER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER NO-UNDO.
DEFINE VARIABLE cMsg    AS CHARACTER NO-UNDO.

/* 
Player 1 starting position: 7
Player 2 starting position: 1
*/

REPEAT:

  cMsg = SUBSTITUTE("Player &1 rolls ", iPlayer).
  
  /* roll the die 3 times */
  DO i = 1 TO 3:
    
    /* Next value */
    iRolls = iRolls + 1.
    iDie = iDie + 1.
    IF iDie = 101 THEN iDie = 1.
    
    cMsg = SUBSTITUTE("&1&2&3", cMsg, TRIM(STRING(i = 1, " /+")), iDie).
    
    /* Move pawn */
    iPos[iPlayer] = iPos[iPlayer] + iDie.
    iPos[iPlayer] = iPos[iPlayer] MOD 10.
    IF iPos[iPlayer] = 0 THEN iPos[iPlayer] = 10.
  END.
  
  /* Add score */
  iScore[iPlayer] = iScore[iPlayer] + iPos[iPlayer].

  /* Debugging */
  cMsg = SUBSTITUTE("&1 and moves to space &2 for a total score of &3", cMsg, iPos[iPlayer], iScore[iPlayer]).
  .MESSAGE cMsg VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
  /* Winner? */
  IF iScore[iPlayer] >= 1000 THEN
  DO:
    MESSAGE "Player" iPlayer "wins with" iScore[iPlayer] "to" iScore[3 - iPlayer] SKIP
            "Num rolls:" iRolls SKIP
            "Answer:" iRolls * iScore[3 - iPlayer]
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.

  /* Other player's turn */
  iPlayer = (3 - iPlayer).
END.

/* ---------------------------    */
/* Player 1 wins with 1008 to 795 */
/* Num rolls: 861                 */
/* Answer: 684495                 */
/* ---------------------------    */

