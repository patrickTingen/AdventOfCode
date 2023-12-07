/* AoC 2023 day 07a 
 */ 
DEFINE TEMP-TABLE ttHand NO-UNDO
  FIELD cHand  AS CHARACTER 
  FIELD iBid   AS INTEGER
  FIELD iScore AS INTEGER
  FIELD iRank  AS INTEGER
  FIELD cSort  AS CHARACTER 
  .

&GLOBAL-DEFINE FIVE-OF-A-KIND  7
&GLOBAL-DEFINE FOUR-OF-A-KIND  6
&GLOBAL-DEFINE FULL-HOUSE      5
&GLOBAL-DEFINE THREE-OF-A-KIND 4
&GLOBAL-DEFINE TWO-PAIR        3
&GLOBAL-DEFINE ONE-PAIR        2
&GLOBAL-DEFINE HIGH-CARD       1

FUNCTION getScore RETURNS INTEGER ( pcHand AS CHARACTER ) FORWARD.
FUNCTION numDiffCards RETURNS INTEGER ( pcHand AS CHARACTER EXTENT 5 ) FORWARD.
FUNCTION hasThreeTheSame RETURNS LOGICAL ( pcHand AS CHARACTER, pcHand AS CHARACTER EXTENT 5 ) FORWARD.
FUNCTION getNumPairs RETURNS INTEGER( pcHand AS CHARACTER, pcCard AS CHARACTER EXTENT 5 ) FORWARD.
FUNCTION allDifferent RETURNS LOGICAL( pcHand AS CHARACTER, pcCard AS CHARACTER EXTENT 5 ) FORWARD.
FUNCTION getSubSort RETURNS CHARACTER (pcCards AS CHARACTER) FORWARD.

DEFINE VARIABLE iRankNr AS INTEGER NO-UNDO.
DEFINE VARIABLE iAnswer AS INTEGER NO-UNDO.

INPUT FROM "data.txt".
REPEAT:
  CREATE ttHand.
  IMPORT ttHand.cHand ttHand.iBid.
END.
INPUT CLOSE. 

FOR EACH ttHand WHERE ttHand.cHand = "":
  DELETE ttHand.
END.

FOR EACH ttHand:
  ttHand.iScore = getScore(ttHand.cHand).
  ttHand.cSort = getSubSort(ttHand.cHand).
END.

FOR EACH ttHand BY ttHand.iScore BY ttHand.cSort:
  iRankNr = iRankNr + 1.
  ttHand.iRank = iRankNr.
  iAnswer = iAnswer + (ttHand.iRank * ttHand.iBid).
END.
MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


FUNCTION getScore RETURNS INTEGER 
  ( pcHand AS CHARACTER ):

  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cCard AS CHARACTER NO-UNDO EXTENT 5.

  /* Turn into array */
  DO i = 1 TO 5:
    cCard[i] = SUBSTRING(pcHand,i,1).
  END.

  /* five of a kind */
  IF REPLACE(pcHand, cCard[1], "") = "" THEN RETURN {&FIVE-OF-A-KIND}.

  /* Four of a kind */
  IF   LENGTH(REPLACE(pcHand, cCard[1], "")) = 1
    OR LENGTH(REPLACE(pcHand, cCard[2], "")) = 1 THEN RETURN {&FOUR-OF-A-KIND}.

  /* Full house */
  IF numDiffCards(cCard) = 2 THEN RETURN {&FULL-HOUSE}.

  /* Three of a kind */
  IF numDiffCards(cCard) = 3 AND hasThreeTheSame(pcHand, cCard) THEN RETURN {&THREE-OF-A-KIND}.

  /* Two pairs */
  IF getNumPairs(pcHand, cCard) = 2 THEN RETURN {&TWO-PAIR}.

  /* One pair */
  IF getNumPairs(pcHand, cCard) = 1 THEN RETURN {&ONE-PAIR}.

  /* High score */
  IF allDifferent(pcHand, cCard) = TRUE THEN RETURN {&HIGH-CARD}.

  RETURN 0.
END FUNCTION. /* getScore */


FUNCTION numDiffCards RETURNS INTEGER 
  ( pcCard AS CHARACTER EXTENT 5 ):

  DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cUnique AS CHARACTER NO-UNDO.

  cUnique = pcCard[1].
  DO i = 2 TO 5:
    IF INDEX(cUnique, pcCard[i]) = 0 THEN cUnique = cUnique + pcCard[i].
  END.

  RETURN LENGTH(cUnique).

END FUNCTION. /* numDiffCards */


FUNCTION hasThreeTheSame RETURNS LOGICAL 
  ( pcHand AS CHARACTER
  , pcCard AS CHARACTER EXTENT 5 ):

  DEFINE VARIABLE i AS INTEGER NO-UNDO.

  DO i = 1 TO 3:
    IF LENGTH(REPLACE(pcHand, pcCard[i], "")) = 2 THEN RETURN YES.
  END.

  RETURN FALSE.
END FUNCTION. /* hasThreeTheSame */


FUNCTION getNumPairs RETURNS INTEGER
  ( pcHand AS CHARACTER
  , pcCard AS CHARACTER EXTENT 5 ):

  DEFINE VARIABLE i      AS INTEGER NO-UNDO.
  DEFINE VARIABLE iPairs AS INTEGER NO-UNDO.

  DO i = 1 TO 4:
    IF LENGTH(REPLACE(pcHand, pcCard[i], "")) = 3 THEN iPairs = iPairs + 1.
  END.

  RETURN INTEGER(iPairs / 2).
END FUNCTION. /* getNumPairs */


FUNCTION allDifferent RETURNS LOGICAL
  ( pcHand AS CHARACTER
  , pcCard AS CHARACTER EXTENT 5 ):

  DEFINE VARIABLE i      AS INTEGER NO-UNDO.
  DEFINE VARIABLE iPairs AS INTEGER NO-UNDO.

  DO i = 1 TO 5:
    IF LENGTH(REPLACE(pcHand, pcCard[i], "")) < 4 THEN RETURN FALSE.
  END.

  RETURN TRUE.
END FUNCTION. /* allDifferent */


FUNCTION getSubSort RETURNS CHARACTER (pcCards AS CHARACTER):

  DEFINE VARIABLE i AS INTEGER NO-UNDO.

  DO i = 1 TO 5:
    SUBSTRING(pcCards,i,1) = ENTRY(LOOKUP(SUBSTRING(pcCards,i,1), 'A,K,Q,J,T,9,8,7,6,5,4,3,2')
                                                                , 'E,D,C,B,A,9,8,7,6,5,4,3,2').
  END.

  RETURN pcCards.
END FUNCTION. /* getSubSort */

