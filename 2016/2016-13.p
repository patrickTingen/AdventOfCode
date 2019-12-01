/* Advent of code, day 13, part 1 */

DEFINE TEMP-TABLE ttMaze
  FIELD xx AS INT
  FIELD yy AS INT
  FIELD wall AS LOG
  FIELD beenHere AS LOG
  INDEX i xx yy.

DEFINE VARIABLE iShortestPath AS INTEGER   NO-UNDO INITIAL 99999.
DEFINE VARIABLE cShortestPath AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTargetX      AS INTEGER   NO-UNDO INITIAL 31.
DEFINE VARIABLE iTargetY      AS INTEGER   NO-UNDO INITIAL 39.
DEFINE VARIABLE iPuzzelInput  AS INTEGER   NO-UNDO INITIAL 1358.

DEFINE VARIABLE lVisited      AS LOGICAL   NO-UNDO EXTENT 10000 INITIAL ?.
DEFINE VARIABLE lWall         AS LOGICAL   NO-UNDO EXTENT 10000 INITIAL ?.

FUNCTION isWall RETURNS LOGICAL (X AS INT, Y AS INT):
  DEFINE VARIABLE iNr   AS INTEGER NO-UNDO.
  DEFINE VARIABLE iBin  AS INTEGER NO-UNDO EXTENT 17 INITIAL [65536,32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1].
  DEFINE VARIABLE idx   AS INTEGER NO-UNDO.
  DEFINE VARIABLE wall  AS LOGICAL NO-UNDO.
  
  /* x*x + 3*x + 2*x*y + y + y*y */
  iNr = (X * X) + (3 * X) + (2 * X * Y) + Y + (Y * Y) + iPuzzelInput.

  REPEAT idx = 1 TO 17:
    IF iBin[idx] <= iNr THEN
    DO:
      iNr = iNr - iBin[idx].
      wall = NOT wall.
    END.
  END.

  RETURN wall.
END.

OS-DELETE d:\Data\Progress\AdventOfCode\2016-13-routes.txt.
iTargetX = 5.
iTargetY = 5.

RUN checkMaze('',0,1,1).

PROCEDURE checkMaze:
  DEFINE INPUT PARAMETER cPath AS CHARACTER NO-UNDO.
	DEFINE INPUT PARAMETER steps AS INTEGER   NO-UNDO.
	DEFINE INPUT PARAMETER px    AS INTEGER   NO-UNDO.
	DEFINE INPUT PARAMETER py    AS INTEGER   NO-UNDO.
	
	DEFINE VARIABLE ii AS INTEGER NO-UNDO.
	.IF steps > iShortestPath THEN RETURN. /* already too long */ 

	IF px < 0 OR py < 0 THEN RETURN. /* off the map */
	
	ii = py * 100 + px + 1.
	IF lWall[ii] THEN RETURN. 
	IF lVisited[ii] THEN RETURN.
	
	lWall[ii] = isWall(px,py).
	lVisited[ii] = TRUE. 
	
/*	IF isWall(px, py) THEN RETURN. /* cannot walk */*/

  cPath = TRIM(SUBSTITUTE('&1 &2,&3', cPath, px,py)). 
	IF px = iTargetX AND py = iTargetY THEN 
	DO:
    IF steps < iShortestPath THEN
      ASSIGN cShortestPath = cPath
		         iShortestPath = steps.

    OUTPUT TO d:\Data\Progress\AdventOfCode\2016-13-routes.txt APPEND.
    PUT UNFORMATTED steps cPath SKIP.
    OUTPUT CLOSE. 

		RETURN. 
	END.

	RUN checkMaze(cPath, steps + 1, px + 1, py). /* right */
	RUN checkMaze(cPath, steps + 1, px, py + 1). /* down */
	RUN checkMaze(cPath, steps + 1, px - 1, py). /* left */
	RUN checkMaze(cPath, steps + 1, px, py - 1). /* up */
END.

.RUN dumpMaze(60,60).

MESSAGE iShortestPath cShortestPath
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*PROCEDURE dumpMaze:                                        */
/*  DEFINE VARIABLE c AS CHARACTER  NO-UNDO.                 */
/*  DEFINE VARIABLE x AS INTEGER    NO-UNDO.                 */
/*  DEFINE VARIABLE y AS INTEGER    NO-UNDO.                 */
/*  DEFINE VARIABLE MaxX AS INTEGER NO-UNDO.                 */
/*  DEFINE VARIABLE MaxY AS INTEGER NO-UNDO.                 */
/*  DEFINE VARIABLE x2 AS INTEGER   NO-UNDO.                 */
/*  DEFINE VARIABLE y2 AS INTEGER   NO-UNDO.                 */
/*  DEFINE VARIABLE i  AS INTEGER   NO-UNDO.                 */
/*                                                           */
/*  DEFINE BUFFER bfMaze FOR ttMaze.                         */
/*                                                           */
/*  FOR EACH bfMaze:                                         */
/*    maxX = MAXIMUM(maxX,bfMaze.xx).                        */
/*    maxY = MAXIMUM(maxY,bfMaze.yy).                        */
/*  END.                                                     */
/*                                                           */
/*  OUTPUT TO d:\Data\Progress\AdventOfCode\2016-13-maze.txt.*/
/*                                                           */
/*  /* header */                                             */
/*  DO Y = 1 TO 2:                                           */
/*    c = '   '.                                             */
/*    DO X = 0 TO maxx.                                      */
/*      IF Y = 1 THEN c = c + STRING(TRUNCATE(X / 10,0),'9').*/
/*      IF Y = 2 THEN c = c + STRING(X MODULO 10,'9').       */
/*    END.                                                   */
/*    PUT UNFORMATTED c SKIP.                                */
/*  END.                                                     */
/*                                                           */
/*  /* maze */                                               */
/*  DO Y = 0 TO maxy:                                        */
/*    c = STRING(y,'99 ').                                   */
/*    DO X = 0 TO maxx.                                      */
/*      IF X = iTargetX AND Y = iTargetY                     */
/*        THEN c = c + 'O'.                                  */
/*        ELSE c = c + STRING(isWall(X,Y),'#/.').            */
/*    END.                                                   */
/*                                                           */
/*    /* route in maze */                                    */
/*    DO i = 1 TO NUM-ENTRIES(cShortestPath,' ').            */
/*      x2 = INTEGER(ENTRY(1,ENTRY(i,cShortestPath,' '))).   */
/*      y2 = INTEGER(ENTRY(2,ENTRY(i,cShortestPath,' '))).   */
/*      IF y2 = Y THEN OVERLAY(c,x2 + 4,1) = 'o'.            */
/*    END.                                                   */
/*                                                           */
/*    PUT UNFORMATTED c SKIP.                                */
/*  END.                                                     */
/*  OUTPUT CLOSE.                                            */
/*END.                                                       */
  
/* 
---------------------------
Information (Press HELP to view stack trace)
---------------------------
16  1,1 1,2 2,2 3,2 3,3 4,3 5,3 6,3 7,3 8,3 8,4 8,5 8,6 7,6 6,6 6,5 5,5
---------------------------
OK   Help   
---------------------------
*/
  
  
  
  
  
  
  
  
  
  
