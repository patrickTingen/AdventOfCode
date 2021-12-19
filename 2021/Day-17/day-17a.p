/* AoC 2021 day 17a
 */ 

FUNCTION getMaxHeight RETURNS INTEGER
  ( piStartX AS INTEGER
  , piStartY AS INTEGER) FORWARD.  

DEFINE VARIABLE giTargetX AS INTEGER NO-UNDO EXTENT 2.
DEFINE VARIABLE giTargetY AS INTEGER NO-UNDO EXTENT 2.
DEFINE VARIABLE xx        AS INTEGER NO-UNDO.
DEFINE VARIABLE yy        AS INTEGER NO-UNDO.
DEFINE VARIABLE hh        AS INTEGER NO-UNDO INITIAL -10000.

/* Main 
*/
RUN readData.

DO xx = 1 to giTargetX[2]:
  DO yy = MIN(giTargetY[1], giTargetY[2]) TO MAX(ABS(giTargetY[1]), ABS(giTargetY[2])):
  
    hh = MAXIMUM(hh, getMaxHeight(xx, yy)).
    
  END.
END.

MESSAGE hh VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 17766 */


PROCEDURE readData:
  DEFINE VARIABLE cData AS LONGCHAR NO-UNDO.
  
  /* Read data and strip nasty characters */
  COPY-LOB FROM FILE "data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* target area: x=48..70, y=-189..-148 */
  cData = ENTRY(2,cData,":").
  cData = REPLACE(cData, "..",",").
  cData = REPLACE(cData, "=",",").
  
  giTargetX[1] = INTEGER(ENTRY(2, cData)).
  giTargetX[2] = INTEGER(ENTRY(3, cData)).
  giTargetY[1] = INTEGER(ENTRY(5, cData)).
  giTargetY[2] = INTEGER(ENTRY(6, cData)).

END PROCEDURE. /* readData */


FUNCTION getMaxHeight RETURNS INTEGER
  ( piStartX AS INTEGER
  , piStartY AS INTEGER):
  
  DEFINE VARIABLE iPosX  AS INTEGER NO-UNDO.
  DEFINE VARIABLE iPosY  AS INTEGER NO-UNDO.
  DEFINE VARIABLE iVelX  AS INTEGER NO-UNDO.
  DEFINE VARIABLE iVelY  AS INTEGER NO-UNDO.
  DEFINE VARIABLE lStart AS LOGICAL NO-UNDO.
  DEFINE VARIABLE iMaxY  AS INTEGER NO-UNDO.

  iVelX  = piStartX.
  iVelY  = piStartY.
  lStart = TRUE.

  REPEAT:
    IF NOT lStart THEN
    DO:
      IF iVelX < 0 THEN iVelX = iVelX + 1.
      IF iVelX > 0 THEN iVelX = iVelX - 1.       
      iVelY = iVelY - 1.
    END.
    ELSE
      lStart = NO.
        
    ASSIGN
      iPosX = iPosX + iVelX
      iPosY = iPosY + iVelY
      iMaxY = MAXIMUM(iMaxY, iPosY).  
 
    /* Reached target box? */  
    IF    iPosX >= giTargetX[1] 
      AND iPosX <= giTargetX[2]
      AND iPosY >= giTargetY[1] 
      AND iPosY <= giTargetY[2] THEN RETURN iMaxY.
 
    /* Overshooting the box? */  
    IF iPosX > giTargetX[2] /* right */     
      OR (iPosY < 0 AND giTargetY[1] < 0 AND iPosY < giTargetY[1]) /* above */ 
      OR (iPosY > 0 AND giTargetY[2] > 0 AND iPosY > giTargetY[2]) /* below */ THEN RETURN 0.
  END.
 
END FUNCTION. /* getMaxHeight */

