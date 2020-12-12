/* AoC 2020 day 12 
 */ 
DEFINE VARIABLE cDir   AS CHARACTER   NO-UNDO INITIAL 'E'.
DEFINE VARIABLE iStep  AS INTEGER     NO-UNDO.
DEFINE VARIABLE cLine  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iNorth AS INTEGER     NO-UNDO.
DEFINE VARIABLE iEast  AS INTEGER     NO-UNDO.
DEFINE VARIABLE cMove  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER     NO-UNDO.

INPUT FROM "input.txt".

REPEAT:
  IMPORT cLine.
   cMove = SUBSTRING(cLine,1,1).        
   iStep = INTEGER(SUBSTRING(cLine,2)).

   CASE cMove:
     WHEN 'F' THEN DO:
       IF cDir = 'N' THEN iNorth = iNorth + iStep.
       IF cDir = 'E' THEN iEast  = iEast + iStep.
       IF cDir = 'S' THEN iNorth = iNorth - iStep.
       IF cDir = 'W' THEN iEast  = iEast - iStep.
     END.

     WHEN 'N' THEN iNorth = iNorth + iStep.
     WHEN 'S' THEN iNorth = iNorth - iStep.
     WHEN 'E' THEN iEast = iEast + iStep.
     WHEN 'W' THEN iEast = iEast - iStep.

     WHEN 'R' THEN DO:
       DO i = 90 TO iStep BY 90:
         CASE cDir:
           WHEN 'N' THEN cDir = 'E'.
           WHEN 'E' THEN cDir = 'S'.
           WHEN 'S' THEN cDir = 'W'.
           WHEN 'W' THEN cDir = 'N'.
         END CASE.
       END.
     END.

     WHEN 'L' THEN DO:
       DO i = 90 TO iStep BY 90:
         CASE cDir:
           WHEN 'N' THEN cDir = 'W'.
           WHEN 'E' THEN cDir = 'N'.
           WHEN 'S' THEN cDir = 'E'.
           WHEN 'W' THEN cDir = 'S'.
         END CASE.
       END.
     END.
   END CASE.
END.

MESSAGE ABS(iEast) + ABS(iNorth)
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
