/* AoC 2024 day 14a 
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

  /* Read data and strip nasty characters 
  p=0,4 v=3,-3
  */
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

loadGrid("c:\Data\DropBox\AdventOfCode\2024\Day-14\data.txt").

DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMaze  AS CHARACTER NO-UNDO.
DEFINE VARIABLE xx     AS INTEGER   NO-UNDO.
DEFINE VARIABLE yy     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNum   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCount AS INTEGER   NO-UNDO EXTENT 4.

DO i = 1 TO 100:

  FOR EACH ttRobot:

    ttRobot.iCol = ttRobot.iCol + ttRobot.iHor.
    IF ttRobot.iCol < 0 THEN ttRobot.iCol = ttRobot.iCol + iMaxCol + 1.
    IF ttRobot.iCol > iMaxCol THEN ttRobot.iCol = (ttRobot.iCol MOD iMaxCol) - 1.

    ttRobot.iRow = ttRobot.iRow + ttRobot.iVer.
    IF ttRobot.iRow < 0 THEN ttRobot.iRow = ttRobot.iRow + iMaxRow + 1.
    IF ttRobot.iRow > iMaxRow THEN ttRobot.iRow = (ttRobot.iRow MOD iMaxRow) - 1.

  END.
END.

cMaze = ''.
DO yy = 0 TO iMaxRow:
  DO xx = 0 TO iMaxCol:

    iNum = 0.
    FOR EACH ttRobot WHERE ttRobot.iCol = xx AND ttRobot.iRow = yy:
      iNum = iNum + 1.
    END.
    cMaze = cMaze + (IF iNum = 0 THEN "." ELSE STRING(iNum)).
  END.
  cMaze = cMaze + "~n".
END.

MESSAGE cMaze VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

DEFINE VARIABLE iUpLeft    AS INTEGER NO-UNDO.
DEFINE VARIABLE iUpRight   AS INTEGER NO-UNDO.
DEFINE VARIABLE iDownLeft  AS INTEGER NO-UNDO.
DEFINE VARIABLE iDownRight AS INTEGER NO-UNDO.
DEFINE VARIABLE iAxis-X    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAxis-Y    AS INTEGER   NO-UNDO.

iAxis-X = TRUNC(iMaxCol / 2,0).
iAxis-Y = TRUNC(iMaxRow / 2,0).

FOR EACH ttRobot WHERE ttRobot.iCol < iAxis-X AND ttRobot.iRow < iAxis-Y: iCount[1] = iCount[1] + 1. END.
FOR EACH ttRobot WHERE ttRobot.iCol > iAxis-X AND ttRobot.iRow < iAxis-Y: iCount[2] = iCount[2] + 1. END.
FOR EACH ttRobot WHERE ttRobot.iCol < iAxis-X AND ttRobot.iRow > iAxis-Y: iCount[3] = iCount[3] + 1. END.
FOR EACH ttRobot WHERE ttRobot.iCol > iAxis-X AND ttRobot.iRow > iAxis-Y: iCount[4] = iCount[4] + 1. END.

MESSAGE iCount[1] * iCount[2] * iCount[3] * iCount[4] /* 216772608 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


