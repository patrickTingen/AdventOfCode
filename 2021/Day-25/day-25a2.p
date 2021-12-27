
&GLOBAL-DEFINE path c:\Data\DropBox\AdventOfCode\2021\Day-25\

DEFINE VARIABLE gcData    AS LONGCHAR  NO-UNDO EXTENT 2.
DEFINE VARIABLE giMaxX    AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE giMaxY    AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE giStep    AS INTEGER   NO-UNDO.
DEFINE VARIABLE glMoved   AS LOGICAL   NO-UNDO.
DEFINE VARIABLE glChanged AS LOGICAL   NO-UNDO.
/* Main 
*/
RUN readGrid("{&path}test-3.txt").

REPEAT:
  giStep = giStep + 1.

  IF ETIME > 1000 THEN DO:
    HIDE MESSAGE NO-PAUSE.
    MESSAGE giStep.
    PROCESS EVENTS.
    ETIME(YES).
  END.

  glChanged = FALSE.
  /* First, east-facing moves */
  RUN moveCucumbers(">", OUTPUT glMoved).
  IF glMoved THEN glChanged = TRUE.

  /* Then south-facing */
  RUN moveCucumbers("v", OUTPUT glMoved).
  IF glMoved THEN glChanged = TRUE.

  IF NOT glChanged THEN DO:
    MESSAGE giStep VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.
END.


PROCEDURE readGrid:
  /* Read grid via longchar into TT
  */
  DEFINE INPUT PARAMETER pcFile  AS CHARACTER NO-UNDO.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO gcData[1].
  gcData[1] = TRIM(REPLACE(gcData[1],'~r',''),'~n').

  /* Max dimensions of playing field */
  giMaxX = LENGTH(ENTRY(1,gcData[1],'~n')).
  giMaxY = NUM-ENTRIES(gcData[1],'~n').

  gcData[1] = REPLACE(gcData[1],'~n','').
  gcData[2] = gcData[1].

END PROCEDURE. /* readGrid */


PROCEDURE moveCucumbers:
  DEFINE INPUT  PARAMETER pcHerd  AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER plMoved AS LOGICAL   NO-UNDO.

  DEFINE VARIABLE iX AS INTEGER NO-UNDO.
  DEFINE VARIABLE iY AS INTEGER NO-UNDO.
  DEFINE VARIABLE i  AS INTEGER NO-UNDO.
  DEFINE VARIABLE i2 AS INTEGER NO-UNDO.      

  DO iY = 1 TO giMaxY:
    DO iX = 1 TO giMaxX:
  
      i = (iY - 1) * giMaxX + iX.
      IF SUBSTRING(gcData[1], i, 1) = "." THEN NEXT.
  
      CASE pcHerd:
        WHEN ">" THEN i2 = (IF iX < giMaxX THEN i + 1 ELSE (iY - 1) * giMaxX + 1).
        WHEN "v" THEN i2 = (IF iY < giMaxY THEN i + giMaxX ELSE iX).
      END.
  
      IF SUBSTRING(gcData[1], i2, 1) = "." THEN 
      DO:
        SUBSTRING(gcData[2],i2,1) = pcHerd.
        SUBSTRING(gcData[2],i,1)  = ".".
        plMoved = TRUE.
      END.

    END. /* X */
  END. /* Y */
  
  gcData[1] = gcData[2].

END PROCEDURE. /* moveCucumbers */


PROCEDURE showGrid:
  /* Show a grid when not all points are stored
  */
  DEFINE VARIABLE cGrid AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.

  /* Export to var
  */
  DO iY = 1 TO giMaxY:
    DO iX = 1 TO giMaxX:
      i = (iY - 1) * giMaxX + iX.
      cGrid = cGrid + SUBSTRING(gcData[1],i,1).
    END.
    cGrid = cGrid + "~n".
  END.

  /* Either show or dump to file */
  MESSAGE STRING(cGrid) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

END PROCEDURE. /* showGrid */
