/* AoC snippet for location handling in a TT
 */ 
 
&GLOBAL-DEFINE path c:\Data\DropBox\AdventOfCode\2021\Day-22\

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  INDEX iPrim iPosX iPosY. 


PROCEDURE readGrid:
  /* Read grid via longchar into TT
  */
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL ?.

  DEFINE BUFFER bLoc FOR ttLoc. 
  
  /* Read data and strip nasty characters */
  COPY-LOB FILE "data.txt" TO cData.
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


PROCEDURE showGrid:
  /* Show a grid when not all points are stored
  */
  DEFINE VARIABLE cGrid AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMinX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMinY AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL ?.

  DEFINE BUFFER bLoc FOR ttLoc.

  /* Find min/max dimensions 
  */
  FOR EACH bLoc:
    iMinX = (IF iMinX = ? THEN bLoc.iPosX ELSE MINIMUM(iMinX, bLoc.iPosX)).
    iMaxX = (IF iMaxX = ? THEN bLoc.iPosX ELSE MAXIMUM(iMaxX, bLoc.iPosX)).
    iMinY = (IF iMinY = ? THEN bLoc.iPosY ELSE MINIMUM(iMinY, bLoc.iPosY)).
    iMaxY = (IF iMaxY = ? THEN bLoc.iPosY ELSE MAXIMUM(iMaxY, bLoc.iPosY)).
  END.

  /* Export to var
  */
  DO iY = iMinY TO iMaxY:
    DO iX = iMinX TO iMaxX:
      FIND FIRST bLoc WHERE bLoc.iPosX = iX AND bLoc.iPosY = iY NO-ERROR.
      cGrid = cGrid + (IF AVAILABLE bLoc THEN bLoc.cValue ELSE " ").
    END.
    cGrid = cGrid + "~n".
  END.

  /* Either show or dump to file */
  MESSAGE STRING(cGrid) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  COPY-LOB cGrid TO FILE "debug.txt".

END PROCEDURE. /* showGrid */
