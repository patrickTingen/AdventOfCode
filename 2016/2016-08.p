/* Advent Of Code 2016, day 8, both parts */
DEFINE TEMP-TABLE ttScreen NO-UNDO RCODE-INFORMATION
	FIELD xx AS INTEGER 
	FIELD yy AS INTEGER
	FIELD cc AS CHARACTER.
	.

DEFINE VARIABLE cScreen AS CHARACTER NO-UNDO EXTENT 6.
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.

FORM 
	cScreen COLON 1 FORMAT 'x(60)' NO-LABEL
	WITH FRAME fScreen CENTERED ROW 8 SIDE-LABELS.

/* Test */
/*RUN createScreen(7,3).                       */
/*RUN doCreateRect('rect 3x2').                */
/*RUN doRotateColumn('rotate column x=1 by 1').*/
/*RUN doRotateRow('rotate row y=0 by 4').      */
/*RUN doRotateColumn('rotate column x=1 by 1').*/
/*                                             */
/*RUN showScreen.                              */
/*STOP.                                        */

/* 
rect 1x1
rotate row y=0 by 20
rotate column x=34 by 2
 */
RUN createScreen(50,6).
INPUT FROM 'd:\Data\Progress\AdventOfCode\2016-08-input.txt'.
REPEAT:
	IMPORT UNFORMATTED cLine.
	
	HIDE MESSAGE NO-PAUSE.
	MESSAGE cLine.
	
	IF cLine BEGINS 'rect ' THEN RUN doCreateRect(cLine).
	IF cLine BEGINS 'rotate column ' THEN RUN doRotateColumn(cLine).
	IF cLine BEGINS 'rotate row ' THEN RUN doRotateRow(cLine).
END. 

DEFINE VARIABLE ii AS INTEGER. 
FOR EACH ttScreen WHERE ttScreen.cc <> ' ': ii = ii + 1. END.
RUN showScreen.
MESSAGE ii.


PROCEDURE doCreateRect:
	/* description
	 */
	DEFINE INPUT PARAMETER pcLine AS CHARACTER NO-UNDO.
	pcLine = SUBSTRING(pcLine,6).
	RUN createRect(INTEGER(ENTRY(1,pcLine,'x')),INTEGER(ENTRY(2,pcLine,'x'))).
	
END PROCEDURE. /* doCreateRect */

PROCEDURE doRotateColumn:
	/* rotate column x=34 by 2
	 */
	DEFINE INPUT PARAMETER pcLine AS CHARACTER NO-UNDO.
	pcLine = ENTRY(2,pcLine,'='). /* '34 by 2' */
	RUN rotateColumn(INTEGER(ENTRY(1,pcLine,' ')) + 1,INTEGER(ENTRY(3,pcLine,' ')) ).
	
END PROCEDURE. /* doRotateColumn */


PROCEDURE doRotateRow:
	/* rotate row y=0 by 20
	 */
	DEFINE INPUT PARAMETER pcLine AS CHARACTER NO-UNDO.
	pcLine = ENTRY(2,pcLine,'='). /* '0 by 20' */
	RUN rotateRow(INTEGER(ENTRY(1,pcLine,' ')) + 1,INTEGER(ENTRY(3,pcLine,' ')) ).
	
END PROCEDURE. /* doRotateColumn */


PROCEDURE rotateColumn:
	/* Rotate a column of the screen
	 */
	DEFINE INPUT PARAMETER piColumn AS INTEGER NO-UNDO.
	DEFINE INPUT PARAMETER piMoves  AS INTEGER NO-UNDO.
	
	DEFINE VARIABLE iY AS INTEGER NO-UNDO.
	DEFINE VARIABLE cOld AS CHARACTER NO-UNDO.
	DEFINE BUFFER bfScreen FOR ttScreen.
	
	DO iY = 1 TO piMoves:
		cOld = ''.
		/* Save values */
		FOR EACH ttScreen WHERE ttScreen.xx = piColumn BY ttScreen.yy:
			cOld = TRIM(SUBSTITUTE('&1,&2',cOld, ttScreen.cc),','). 
		END.
		
		cOld = ENTRY(NUM-ENTRIES(cOld),cOld) + ',' + cOld.
		ENTRY(NUM-ENTRIES(cOld),cOld) = ''.
		cOld = TRIM(cOld, ',').
		
		/* Set new values */
		FOR EACH ttScreen WHERE ttScreen.xx = piColumn:
			ttScreen.cc = ENTRY(ttScreen.yy,cOld). 
		END.
	END.
END PROCEDURE. /* rotateColumn */


PROCEDURE rotateRow:
	/* Rotate a column of the screen
	 */
	DEFINE INPUT PARAMETER piRow   AS INTEGER NO-UNDO.
	DEFINE INPUT PARAMETER piMoves AS INTEGER NO-UNDO.
	
	DEFINE VARIABLE iY AS INTEGER NO-UNDO.
	DEFINE VARIABLE cOld AS CHARACTER NO-UNDO.
	DEFINE BUFFER bfScreen FOR ttScreen.
	
	DO iY = 1 TO piMoves:
		cOld = ''.
		/* Save values */
		FOR EACH ttScreen WHERE ttScreen.yy = piRow BY ttScreen.xx:
			cOld = TRIM(SUBSTITUTE('&1,&2',cOld, ttScreen.cc),','). 
		END.
		
		cOld = ENTRY(NUM-ENTRIES(cOld),cOld) + ',' + cOld.
		ENTRY(NUM-ENTRIES(cOld),cOld) = ''.
		cOld = TRIM(cOld, ',').
		
		/* Set new values */
		FOR EACH ttScreen WHERE ttScreen.yy = piRow:
			ttScreen.cc = ENTRY(ttScreen.xx,cOld). 
		END.
	END.
END PROCEDURE. /* rotateColumn */


PROCEDURE createScreen:
	/* Create a screen in the ttScreen table 
	 */
	DEFINE INPUT PARAMETER piMaxX AS INTEGER NO-UNDO.
	DEFINE INPUT PARAMETER piMaxY AS INTEGER NO-UNDO.
	
	DEFINE VARIABLE iX AS INTEGER NO-UNDO.
	DEFINE VARIABLE iY AS INTEGER NO-UNDO.
	
	DO iX = 1 TO piMaxX:
		DO iY = 1 TO piMaxY:
			CREATE ttScreen.
			ASSIGN 
				ttScreen.xx = iX
				ttScreen.yy = iY
				ttScreen.cc = ' '
				.
		END. 
	END. 
END PROCEDURE. /* createScreen */


PROCEDURE createRect:
	/* Create a screen in the ttScreen table 
	 */
	DEFINE INPUT PARAMETER piMaxX AS INTEGER NO-UNDO.
	DEFINE INPUT PARAMETER piMaxY AS INTEGER NO-UNDO.
	
	DEFINE VARIABLE iX AS INTEGER NO-UNDO.
	DEFINE VARIABLE iY AS INTEGER NO-UNDO.
	
	DO iX = 1 TO piMaxX:
		DO iY = 1 TO piMaxY:
			FIND ttScreen WHERE ttScreen.xx = iX AND ttScreen.yy = iY.
			ttScreen.cc = CHR(178).
		END. 
	END. 
END PROCEDURE. /* createRect */


PROCEDURE showScreen:
	/* Show ttScreen on the screen 
	 */
	cScreen = ''.
	FOR EACH ttScreen BY ttScreen.yy BY ttScreen.xx:
		IF ttScreen.xx = 1 THEN cScreen[ttScreen.yy] = STRING(ttScreen.yy) + ' '.
		cScreen[ttScreen.yy] = cScreen[ttScreen.yy] + ttScreen.cc.
	END. 
	
	OUTPUT TO c:\temp\screen.txt.
	DISPLAY cScreen WITH FRAME fScreen.
	OUTPUT CLOSE. 
	PAUSE. 
	
END PROCEDURE. /* showScreen */
