/*------------------------------------------------------------------------
    File        : 2017-03b.p
    Purpose     : Day 3 of AoC 2017

    5-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE TEMP-TABLE ttMaze NO-UNDO RCODE-INFORMATION
  FIELD nr AS INTEGER
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  FIELD vv AS INTEGER
  INDEX i1 AS PRIMARY UNIQUE nr
  INDEX i2 AS UNIQUE xx yy.

DEFINE VARIABLE iMaxX  AS INTEGER NO-UNDO.
DEFINE VARIABLE iMinX  AS INTEGER NO-UNDO.
DEFINE VARIABLE iMaxY  AS INTEGER NO-UNDO.
DEFINE VARIABLE iMinY  AS INTEGER NO-UNDO.
DEFINE VARIABLE iPosX  AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iPosY  AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iDifX  AS INTEGER NO-UNDO INITIAL 1.
DEFINE VARIABLE iDifY  AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE i      AS INTEGER NO-UNDO.
DEFINE VARIABLE j      AS INTEGER NO-UNDO.
DEFINE VARIABLE jx     AS INTEGER NO-UNDO.
DEFINE VARIABLE jy     AS INTEGER NO-UNDO.

DEFINE BUFFER bMaze FOR ttMaze.

REPEAT:
  i = i + 1. /* maze nr */

  CREATE ttMaze.
  ASSIGN
    ttMaze.nr = i
    ttMaze.xx = iPosX
    ttMaze.yy = iPosY
    ttMaze.vv = 1 WHEN i = 1
    .

  iPosX = iPosX + iDifX.
  iPosY = iPosY + iDifY.

  IF iPosX > iMaxX THEN ASSIGN iDifX =  0 iDifY = -1 iMaxX = iPosX.
  IF iPosY < iMinY THEN ASSIGN iDifX = -1 iDifY =  0 iMinY = iPosY.
  IF iPosX < iMinX THEN ASSIGN iDifX =  0 iDifY =  1 iMinX = iPosX.
  IF iPosY > iMaxY THEN ASSIGN iDifX =  1 iDifY =  0 iMaxY = iPosY.

  DO jx = -1 TO 1:
    DO jy = -1 TO 1:
      IF jx = 0 AND jy = 0 THEN NEXT.

      FIND bMaze WHERE bMaze.xx = ttMaze.xx + jx AND bMaze.yy = ttMaze.yy + jy NO-ERROR.
      IF AVAILABLE bMaze THEN ttMaze.vv = ttMaze.vv + bMaze.vv.
    END.
  END.

  IF ttMaze.vv > 325489 THEN
  DO:
    MESSAGE ttMaze.vv VIEW-AS ALERT-BOX INFORMATION.
    LEAVE.
  END.
END.

/*---------------------------                 */
/*Information (Press HELP to view stack trace)*/
/*---------------------------                 */
/*330785                                      */
/*---------------------------                 */
/*OK   Help                                   */
/*---------------------------                 */
