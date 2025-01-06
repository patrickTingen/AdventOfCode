/* AoC 2024 day 14b 
 */ 
DEFINE TEMP-TABLE ttRobot NO-UNDO
  FIELD iNr  AS INTEGER
  FIELD iCol AS INTEGER FORMAT "->>9"
  FIELD iRow AS INTEGER FORMAT "->>9"
  FIELD iHor AS INTEGER FORMAT "->>9"
  FIELD iVer AS INTEGER FORMAT "->>9"
  INDEX idxPrim iNr
  INDEX idxPos iCol iRow. 
  
DEFINE VARIABLE iMaxCol AS INTEGER NO-UNDO INITIAL 100.
DEFINE VARIABLE iMaxRow AS INTEGER NO-UNDO INITIAL 102.
  
FUNCTION loadGrid RETURNS LOGICAL 
  ( pcFile AS CHARACTER 
  ): 
  DEFINE VARIABLE cPos   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cMove  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iRobot AS INTEGER   NO-UNDO.
  DEFINE BUFFER btRobot FOR ttRobot.

  INPUT FROM VALUE(pcFile).
  REPEAT:
    IMPORT DELIMITER " " cPos cMove.
    iRobot = iRobot + 1.
    CREATE btRobot.
    ASSIGN 
      btRobot.iNr  = iRobot
      btRobot.iCol = INTEGER(ENTRY(1,ENTRY(2,cPos,"=")))
      btRobot.iRow = INTEGER(ENTRY(2,ENTRY(2,cPos,"=")))
      btRobot.iHor = INTEGER(ENTRY(1,ENTRY(2,cMove,"="))) 
      btRobot.iVer = INTEGER(ENTRY(2,ENTRY(2,cMove,"="))).
  END.
END FUNCTION. /* loadGrid */

FUNCTION maze RETURNS CHARACTER
  ( piTime AS INTEGER ):

  DEFINE VARIABLE cMaze    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE xx       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE yy       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNum     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iOverlap AS INTEGER   NO-UNDO.

  DEFINE BUFFER btRobot FOR ttRobot.
  
  // assumption: when tree shows, there is minimal overlap
  FOR EACH btRobot BREAK BY btRobot.iCol BY btRobot.iRow:
    IF NOT FIRST-OF(btRobot.iRow) THEN iOverlap = iOverlap + 1.
  END.
  IF iOverlap > 2 THEN RETURN "".

  DO yy = 0 TO iMaxRow:
    DO xx = 0 TO iMaxCol - 10:

      iNum = 0.
      FOR EACH btRobot WHERE btRobot.iCol = xx AND btRobot.iRow = yy:
        iNum = iNum + 1.
      END.
      cMaze = cMaze + (IF iNum = 0 THEN "." ELSE STRING(iNum)).
    END.
    cMaze = cMaze + "~n".
  END.

  RETURN SUBSTITUTE('Time:&1~n&2~n~n', piTime, cMaze).
END FUNCTION. 

DEFINE VARIABLE i     AS INTEGER NO-UNDO.
DEFINE VARIABLE lStop AS LOGICAL NO-UNDO.

loadGrid("data.txt").
OS-DELETE "grid.txt".

DO i = 1 TO 10000:

  FOR EACH ttRobot:

    ttRobot.iCol = ttRobot.iCol + ttRobot.iHor.
    IF ttRobot.iCol < 0 THEN ttRobot.iCol = ttRobot.iCol + iMaxCol + 1.
    IF ttRobot.iCol > iMaxCol THEN ttRobot.iCol = (ttRobot.iCol MOD iMaxCol) - 1.

    ttRobot.iRow = ttRobot.iRow + ttRobot.iVer.
    IF ttRobot.iRow < 0 THEN ttRobot.iRow = ttRobot.iRow + iMaxRow + 1.
    IF ttRobot.iRow > iMaxRow THEN ttRobot.iRow = (ttRobot.iRow MOD iMaxRow) - 1.

  END.

  OUTPUT TO "grid.txt" APPEND.
  PUT UNFORMATTED Maze(i).
  OUTPUT CLOSE. 

  IF i MOD 1000 = 0 THEN MESSAGE 'stop after' i VIEW-AS ALERT-BOX INFORMATION BUTTONS YES-NO UPDATE lStop.
  IF lStop THEN LEAVE.
END.

