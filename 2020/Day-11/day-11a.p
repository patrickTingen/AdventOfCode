/* AoC 2020 day 11a 
 */ 
DEFINE VARIABLE iRows    AS INTEGER.  /* not NO-UNDO */
DEFINE VARIABLE iCols    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iGen     AS INTEGER   NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iOcc     AS INTEGER     NO-UNDO.
DEFINE VARIABLE lChanged AS LOGICAL   NO-UNDO.

DEFINE TEMP-TABLE ttSeat NO-UNDO
  FIELD iCol   AS INTEGER
  FIELD iRow   AS INTEGER
  FIELD iVal   AS INTEGER
  FIELD iScore AS INTEGER
  INDEX iPrim iCol iRow.

INPUT FROM "input.txt".
REPEAT TRANSACTION:
  iRows = iRows + 1.
  IMPORT UNFORMATTED cLine.
  iCols = LENGTH(cLine).

  DO i = 1 TO LENGTH(cLine):
    IF SUBSTRING(cLine,i,1) = '.' THEN NEXT.
    CREATE ttSeat.
    ASSIGN ttSeat.iCol = i
           ttSeat.iRow = iRows
           ttSeat.iVal = 0.
  END.
END.
INPUT CLOSE.

        
FUNCTION getSeatScore RETURNS INTEGER 
  ( piSeatCol AS INTEGER
  , piSeatRow AS INTEGER):

  DEFINE VARIABLE iX     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iScore AS INTEGER   NO-UNDO.

  DEFINE BUFFER bSeat FOR ttSeat. 
  
  DO iX = -1 TO 1:
    DO iY = -1 TO 1:
      IF iX = 0 AND iY = 0 THEN NEXT. 
      FIND bSeat WHERE bSeat.iCol = piSeatCol + iX AND bSeat.iRow = piSeatRow + iY NO-ERROR.
      IF AVAILABLE bSeat THEN iScore = iScore + bSeat.iVal.
    END. /* iY */
  END. /* iX */

  RETURN iScore.
END FUNCTION. /* getSeatScore */


REPEAT:
  iGen = iGen + 1.
  
  HIDE MESSAGE NO-PAUSE. 
  MESSAGE iGen.
  PROCESS EVENTS.

  FOR EACH ttSeat:
    ttSeat.iScore = getSeatScore(ttSeat.iCol, ttSeat.iRow).
  END. /* ttSeat */

  lChanged = FALSE.
  FOR EACH ttSeat:
    CASE ttSeat.iVal:
      WHEN 0 THEN IF ttSeat.iScore = 0 THEN ASSIGN ttSeat.iVal = 1 lChanged = TRUE.
      WHEN 1 THEN IF ttSeat.iScore > 3 THEN ASSIGN ttSeat.iVal = 0 lChanged = TRUE.
    END CASE.
  END.

  IF NOT lChanged THEN LEAVE.
END.

FOR EACH ttSeat: 
  iOcc = iOcc + ttSeat.iVal.
END.

MESSAGE 'Part 1:' iOcc /* 2247 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
