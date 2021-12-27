/* AoC 2021 day 25a 
 */ 
&GLOBAL-DEFINE path c:\Data\DropBox\AdventOfCode\2021\Day-25\

DEFINE VARIABLE giStep    AS INTEGER  NO-UNDO.
DEFINE VARIABLE glChanged AS LOGICAL  NO-UNDO.
DEFINE VARIABLE glMoved   AS LOGICAL  NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER EXTENT 2
  INDEX iPrim iPosX iPosY. 

/* Main 
*/
RUN readGrid("{&path}data.txt").

REPEAT:
  giStep = giStep + 1.

  IF ETIME > 1000 THEN DO:
    HIDE MESSAGE NO-PAUSE.
    MESSAGE giStep.
    PROCESS EVENTS.
    ETIME(YES).
  END.

  glChanged = FALSE.

  /* East-facing herd moves first */
  RUN moveCucumbers(">", OUTPUT glMoved).
  IF glMoved THEN glChanged = TRUE.
  RUN copyGrid.

  /* Then south-facing */
  RUN moveCucumbers("v", OUTPUT glMoved).
  IF glMoved THEN glChanged = TRUE.
  RUN copyGrid.

  IF NOT glChanged THEN DO:
    MESSAGE giStep VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.
END.


PROCEDURE moveCucumbers:
  DEFINE INPUT  PARAMETER pcHerd  AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER plMoved AS LOGICAL   NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc.
  DEFINE BUFFER bNew FOR ttLoc.

  #Loc:
  FOR EACH bLoc WHERE bLoc.cValue[1] = pcHerd:

    CASE bLoc.cValue[1]:

      WHEN "." THEN NEXT #Loc.

      WHEN ">" THEN 
      DO:
        FIND bNew WHERE bNew.iPosX = bLoc.iPosX + 1 AND bNew.iPosY = bLoc.iPosY NO-ERROR.
        IF NOT AVAILABLE bNew THEN FIND bNew WHERE bNew.iPosX = 1 AND bNew.iPosY = bLoc.iPosY NO-ERROR.
      END.

      WHEN "v" THEN 
      DO:
        FIND bNew WHERE bNew.iPosX = bLoc.iPosX AND bNew.iPosY = bLoc.iPosY + 1 NO-ERROR.
        IF NOT AVAILABLE bNew THEN FIND bNew WHERE bNew.iPosX = bLoc.iPosX AND bNew.iPosY = 1 NO-ERROR.
      END.
    END CASE.

    IF bNew.cValue[1] = "." THEN 
    DO:
      bNew.cValue[2] = pcHerd.
      bLoc.cValue[2] = '.'.
      plMoved = TRUE.
    END.
  END.

END PROCEDURE. /* moveCucumbers */


PROCEDURE copyGrid:
  DEFINE BUFFER bLoc FOR ttLoc.

  FOR EACH bLoc:
    bLoc.cValue[1] = bLoc.cValue[2].
  END.
END PROCEDURE. /* copyGrid */


PROCEDURE readGrid:
  /* Read grid via longchar into TT
  */
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL ?.

  DEFINE BUFFER bLoc FOR ttLoc. 
  
  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').
  
  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:
      CREATE bLoc.
      ASSIGN 
        bLoc.iPosX  = iX
        bLoc.iPosY  = iY
        bLoc.cValue = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).
    END.
  END.

END PROCEDURE. /* readGrid */
