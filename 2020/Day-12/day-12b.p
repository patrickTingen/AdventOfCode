/* AoC 2020 day 12 part 2
 */ 
DEFINE VARIABLE cLine  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iStep  AS INTEGER     NO-UNDO.
DEFINE VARIABLE cMove  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iShipY AS INTEGER     NO-UNDO.
DEFINE VARIABLE iShipX AS INTEGER     NO-UNDO.
DEFINE VARIABLE iWayX  AS INTEGER     NO-UNDO INITIAL 10.
DEFINE VARIABLE iWayY  AS INTEGER     NO-UNDO INITIAL 1.
DEFINE VARIABLE iTemp  AS INTEGER     NO-UNDO.

ETIME(YES).
INPUT FROM "input.txt".

REPEAT:
  IMPORT cLine.
   cMove = SUBSTRING(cLine,1,1).        
   iStep = INTEGER(SUBSTRING(cLine,2)).

   CASE cMove:
     WHEN 'F' THEN DO:
       iShipY = iShipY + (iWayY * iStep).
       iShipX = iShipX + (iWayX * iStep).
     END.

     WHEN 'N' THEN iWayY = iWayY + iStep.
     WHEN 'S' THEN iWayY = iWayY - iStep.
     WHEN 'E' THEN iWayX = iWayX + iStep.
     WHEN 'W' THEN iWayX = iWayX - iStep.

     WHEN 'R' THEN DO:
       DO i = 90 TO iStep BY 90:
         iTemp = iWayX.
         iWayX = iWayY.
         iWayY = iTemp * -1.
       END.
     END.

     WHEN 'L' THEN DO:
       DO i = 90 TO iStep BY 90:
         iTemp = iWayX.
         iWayX = iWayY * -1.
         iWayY = iTemp.
       END.
     END.
   END CASE.
END.
INPUT CLOSE. 

MESSAGE ABS(iShipX) + ABS(iShipY) SKIP ETIME
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 47806                       */
/* 5                           */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */
/*                             */
