/*------------------------------------------------------------------------
    File        : 2017-03a.p
    Purpose     : Day 3 of AoC 2017

    5-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE TEMP-TABLE ttMaze NO-UNDO RCODE-INFORMATION
  FIELD nr AS INTEGER
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
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

DO i = 1 TO 325489:

  CREATE ttMaze.
  ASSIGN
    ttMaze.xx = iPosX
    ttMaze.yy = iPosY
    ttMaze.nr = i.

  iPosX = iPosX + iDifX.
  iPosY = iPosY + iDifY.

  IF iPosX > iMaxX THEN ASSIGN iDifX =  0 iDifY = -1 iMaxX = iPosX.
  IF iPosY < iMinY THEN ASSIGN iDifX = -1 iDifY =  0 iMinY = iPosY.
  IF iPosX < iMinX THEN ASSIGN iDifX =  0 iDifY =  1 iMinX = iPosX.
  IF iPosY > iMaxY THEN ASSIGN iDifX =  1 iDifY =  0 iMaxY = iPosY.

END.

FIND ttMaze WHERE ttMaze.nr = 325489.
MESSAGE ABSOLUTE(ttMaze.xx) + ABSOLUTE(ttMaze.yy) VIEW-AS ALERT-BOX INFORMATION.

/*---------------------------                 */
/*Information (Press HELP to view stack trace)*/
/*---------------------------                 */
/*552                                         */
/*---------------------------                 */
/*OK   Help                                   */
/*---------------------------                 */
