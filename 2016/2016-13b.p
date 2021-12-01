/* Advent of code, day 13, part 1 */

DEFINE VARIABLE lVisited AS LOGICAL NO-UNDO EXTENT 10000.
DEFINE VARIABLE lWall    AS LOGICAL NO-UNDO EXTENT 10000 INITIAL ?.
DEFINE VARIABLE maxX     AS INTEGER NO-UNDO INITIAL 20.
DEFINE VARIABLE maxY     AS INTEGER NO-UNDO INITIAL 20.
DEFINE VARIABLE ptr      AS INTEGER NO-UNDO.
DEFINE VARIABLE seq      AS INTEGER NO-UNDO.
DEFINE VARIABLE xxx      AS INTEGER     NO-UNDO.
DEFINE VARIABLE yyy      AS INTEGER     NO-UNDO.

FUNCTION isWall RETURNS LOGICAL (X AS INT, Y AS INT) FORWARD.

DEFINE TEMP-TABLE ttStack NO-UNDO RCODE-INFORMATION
	FIELD ii AS INTEGER
	FIELD iX AS INTEGER
	FIELD iY AS INTEGER
	FIELD cRoute    AS CHARACTER
	FIELD iNumSteps AS INTEGER
	.

FUNCTION push RETURNS LOGICAL
	(px AS INT, py AS INT, ps AS CHAR):

  DEFINE VARIABLE idx AS INTEGER NO-UNDO.
  DEFINE BUFFER ttStack FOR ttStack. 

  IF pX < 0 OR pY < 0 THEN RETURN FALSE. /* off the map */

  idx = pY * 100 + pX + 1.
  IF lVisited[idx] THEN RETURN FALSE.
  lVisited[idx] = TRUE.

  IF isWall(pX,pY) THEN RETURN FALSE. /* wall */ 
  
	seq = seq + 1.
	CREATE ttStack. 
	ASSIGN ttStack.ii = seq ttStack.iX = px ttStack.iY = py 
         ttStack.cRoute    = TRIM(SUBST('&1 &2,&3',ps,ttStack.iX,ttStack.iY),' ')
         ttStack.iNumSteps = NUM-ENTRIES(ttStack.cRoute,' ') - 1.

  maxx = MAXIMUM(maxx,px).
  maxy = MAXIMUM(maxy,py).

	RETURN TRUE.
END FUNCTION. /* push */

OS-DELETE 'd:\Data\Progress\AdventOfCode\2016-13-routes.txt'.
OS-DELETE 'd:\Data\Progress\AdventOfCode\2016-13-maze.txt'.
SESSION:APPL-ALERT-BOXES = FALSE. 

&GLOBAL-DEFINE part 2

IF {&part} = 1 THEN 
DO:
  RUN prepare.
  RUN findPos(31,39,?).
END.

ELSE
DO xxx = 0 TO 51:
  DO yyy = 0 TO 51:

    IF ETIME > 1000 THEN DO:
      PROCESS EVENTS.
      MESSAGE xxx yyy. 
      ETIME(YES).
    END.

    RUN prepare.
    RUN findPos(xxx,yyy,50).
  END.
END.

PROCEDURE findPos:
  DEFINE INPUT PARAMETER iPosX     AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER iPosY     AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER iMaxSteps AS INTEGER     NO-UNDO.

  push(1,1,'').
  
  REPEAT:
    ptr = ptr + 1.
    FIND ttStack WHERE ttStack.ii = ptr NO-ERROR.
    IF NOT AVAILABLE ttStack THEN LEAVE. 
  
    IF (ttStack.iNumSteps > iMaxSteps) THEN LEAVE. 

    IF (ttStack.iX = iPosX AND ttStack.iY = iPosY) THEN DO: 
      RUN dumpMaze(iPosX, iPosY, ttStack.cRoute).
      OUTPUT TO 'd:\Data\Progress\AdventOfCode\2016-13-routes.txt' APPEND.
      PUT UNFORMATTED ttStack.cRoute SKIP.
      OUTPUT CLOSE. 
    END.
    
    push(ttStack.iX + 1,ttStack.iY,ttStack.cRoute).
    push(ttStack.iX - 1,ttStack.iY,ttStack.cRoute).
    push(ttStack.iX,ttStack.iY + 1,ttStack.cRoute).
    push(ttStack.iX,ttStack.iY - 1,ttStack.cRoute).
  END.

END. 

PROCEDURE dumpMaze:
  DEFINE INPUT PARAMETER pX      AS INTEGER     NO-UNDO.
  DEFINE INPUT PARAMETER pY      AS INTEGER     NO-UNDO.
  DEFINE INPUT PARAMETER pcRoute AS CHARACTER   NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE x AS INTEGER    NO-UNDO.
  DEFINE VARIABLE y AS INTEGER    NO-UNDO.
  DEFINE VARIABLE x2 AS INTEGER   NO-UNDO.
  DEFINE VARIABLE y2 AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i  AS INTEGER   NO-UNDO.

  OUTPUT TO d:\Data\Progress\AdventOfCode\2016-13-maze.txt APPEND.

  /* Header */
  PUT UNFORMATTED FILL('-',50) SKIP 'Found ' px ',' py ' in ' NUM-ENTRIES(pcRoute,' ') - 1 ' steps' SKIP(1).

  /* header */
  DO Y = 1 TO 2:
    c = '   '.
    DO X = 0 TO maxx.
      IF Y = 1 THEN c = c + STRING(TRUNCATE(X / 10,0),'9').
      IF Y = 2 THEN c = c + STRING(X MODULO 10,'9').
    END.
    PUT UNFORMATTED c SKIP.
  END.

  /* maze */
  DO Y = 0 TO maxy:
    c = STRING(y,'99 ').
    DO X = 0 TO maxx.
      IF X = pX AND Y = pY
        THEN c = c + 'O'.
        ELSE c = c + STRING(isWall(X,Y),'#/.').
    END.

   /* route in maze */                                 
   DO i = 1 TO NUM-ENTRIES(pcRoute,' ').         
     x2 = INTEGER(ENTRY(1,ENTRY(i,pcRoute,' '))).
     y2 = INTEGER(ENTRY(2,ENTRY(i,pcRoute,' '))).
     IF y2 = Y THEN OVERLAY(c,x2 + 4,1) = 'o'.         
   END.                                                

    PUT UNFORMATTED c SKIP.
  END.
  OUTPUT CLOSE.
END.
  
PROCEDURE prepare:
  EMPTY TEMP-TABLE ttStack.
  lVisited = ?.
  lWall = ?.
  ptr = 0.
  seq = 0.
  maxx = 0.
  maxy = 0.
END PROCEDURE. 


FUNCTION isWall RETURNS LOGICAL (X AS INT, Y AS INT):
  DEFINE VARIABLE iNr   AS INTEGER NO-UNDO.
  DEFINE VARIABLE iBin  AS INTEGER NO-UNDO EXTENT 17 INITIAL [65536,32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1].
  DEFINE VARIABLE idx   AS INTEGER NO-UNDO.
  DEFINE VARIABLE wall  AS LOGICAL NO-UNDO.
  
  /* x*x + 3*x + 2*x*y + y + y*y */
  iNr = (X * X) + (3 * X) + (2 * X * Y) + Y + (Y * Y) + 1358.

  REPEAT idx = 1 TO 17:
    IF iBin[idx] <= iNr THEN
    DO:
      iNr = iNr - iBin[idx].
      wall = NOT wall.
    END.
  END.

  RETURN wall.
END FUNCTION.


/* 
---------------------------
Information (Press HELP to view stack trace)
---------------------------
16  1,1 1,2 2,2 3,2 3,3 4,3 5,3 6,3 7,3 8,3 8,4 8,5 8,6 7,6 6,6 6,5 5,5
---------------------------
OK   Help   
---------------------------
*/
  
  
  
  
  
  
  
  
  
  
