/* Advent of code 2018
** day 9
*/
DEFINE TEMP-TABLE ttPlayer NO-UNDO
 FIELD iNr    AS INTEGER
 FIELD iScore AS INT64
 INDEX iPrim IS PRIMARY UNIQUE iNr
 INDEX iNr iScore DESCENDING.

DEFINE TEMP-TABLE ttMarble NO-UNDO
 FIELD iNr    AS INTEGER
 FIELD iPrev AS INTEGER
 FIELD iNext AS INTEGER
 INDEX iPrim IS PRIMARY UNIQUE iNr.

DEFINE BUFFER bNext    FOR ttMarble.
DEFINE BUFFER bPrev    FOR ttMarble.
DEFINE BUFFER bCurrent FOR ttMarble.
                            
DEFINE VARIABLE giMarble    AS INTEGER NO-UNDO.
DEFINE VARIABLE giCurrent   AS INTEGER NO-UNDO.
DEFINE VARIABLE giMaxMarble AS INTEGER NO-UNDO.
/* 
412 players; last marble is worth 71646 points
*/
giMaxMarble = 71646. /* x 100 for part 2 */
RUN addPlayers(412).

DO TRANSACTION:
  CREATE ttMarble. 
  giCurrent = ttMarble.iNr.
END.

FUNCTION toString RETURNS CHARACTER ():
  DEFINE BUFFER bMarble FOR ttMarble.
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  FIND bMarble WHERE bMarble.iNr = 0.
  REPEAT:
    c = c + (IF bMarble.iNr = giCurrent 
               THEN SUBSTITUTE(' (&1)', STRING(bMarble.iNr,'z9'))
               ELSE SUBSTITUTE('  &1 ', STRING(bMarble.iNr,'z9'))).
    i = bMarble.iNext.
    IF i = 0 THEN LEAVE.
    FIND bMarble WHERE bMarble.iNr = i NO-ERROR.
  END.
  RETURN c.
END FUNCTION. 

DEFINE VARIABLE i AS INTEGER NO-UNDO.
CURRENT-WINDOW:WIDTH = 200.
CURRENT-WINDOW:HEIGHT = 30.

#Main:
REPEAT WITH FRAME f:
  FOR EACH ttPlayer:

    giMarble = giMarble + 1.
    IF giMarble > giMaxMarble THEN LEAVE #Main. 

    IF giMarble MOD 23 = 0 THEN
    DO:
      /* Add points to player */
      ttPlayer.iScore = ttPlayer.iScore + giMarble.

      /* Get 7th marble left to player and add score */
      RUN getMarble(BUFFER ttMarble, -7).
      ttPlayer.iScore = ttPlayer.iScore + ttMarble.iNr.

      /* And remove it */
      RUN removeMarble(BUFFER ttMarble).
    END.

    ELSE
    DO:
      /* Get marble left of current */
      RUN getMarble(BUFFER ttMarble, 2).
      RUN insertMarble(BUFFER ttMarble, FALSE).
    END.

/*     DISPLAY STREAM sLog                                                 */
/*       ttPlayer.iNr FORMAT '>9'                                          */
/*       toString() FORMAT 'x(160)' WITH FRAME f DOWN WIDTH 198 STREAM-IO. */
/*     DOWN WITH FRAME f.                                                  */
  END.
END.

FOR EACH ttPlayer BY ttPlayer.iScore DESCENDING:
  MESSAGE ttPlayer.iScore VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  LEAVE.
END.


PROCEDURE getMarble:
  DEFINE PARAMETER BUFFER bMarble FOR ttMarble.
  DEFINE INPUT PARAMETER piShift AS INTEGER NO-UNDO.

  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE VARIABLE j AS INTEGER NO-UNDO.

  FIND bMarble WHERE bMarble.iNr = giCurrent.

  DO i = 1 TO ABS(piShift):
    j = (IF piShift < 0 THEN bMarble.iPrev ELSE bMarble.iNext).
    FIND bMarble WHERE bMarble.iNr = j.
  END.
END PROCEDURE. 

PROCEDURE removeMarble:
  DEFINE PARAMETER BUFFER bMarble FOR ttMarble.
  DEFINE BUFFER bNext FOR ttMarble.
  DEFINE BUFFER bPrev FOR ttMarble.

  FIND bPrev WHERE bPrev.iNr = bMarble.iPrev.
  FIND bNext WHERE bNext.iNr = bMarble.iNext.
  ASSIGN 
    giCurrent = bNext.iNr
    bPrev.iNext     = bNext.iNr
    bNext.iPrev     = bPrev.iNr
    .
  DELETE ttMarble.
END PROCEDURE. 

PROCEDURE insertMarble:
  DEFINE PARAMETER BUFFER bMarble FOR ttMarble.
  DEFINE INPUT PARAMETER plForward AS LOGICAL NO-UNDO.

  DEFINE BUFFER bNext FOR ttMarble.
  DEFINE BUFFER bPrev FOR ttMarble.

  IF plForward THEN DO:
    FIND bNext WHERE bNext.iNr = bMarble.iNext.
    FIND bPrev WHERE bPrev.iNr = bMarble.iNr.
  END.
  ELSE 
  DO:
    FIND bNext WHERE bNext.iNr = bMarble.iNr.
    FIND bPrev WHERE bPrev.iNr = bMarble.iPrev.
  END.

  CREATE bMarble.
  ASSIGN 
    bMarble.iNr   = giMarble
    bMarble.iNext = bNext.iNr
    bMarble.iPrev = bPrev.iNr
    bNext.iPrev   = bMarble.iNr
    bPrev.iNext   = bMarble.iNr
    giCurrent     = bMarble.iNr.

END PROCEDURE. 


PROCEDURE addPlayers:
  DEFINE INPUT PARAMETER piNumPlayers AS INTEGER NO-UNDO.
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE BUFFER bPlayer FOR ttPlayer. 

  DO i = 1 TO piNumPlayers:
    CREATE bPlayer. 
    ASSIGN bPlayer.iNr = i.
  END.
END PROCEDURE. 
