/* AoC 2021 day 05b
 */ 
DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE xx       AS INTEGER   NO-UNDO.
DEFINE VARIABLE yy       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartX  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartY  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iEndX    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iEndY    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLengthX AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLengthY AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStepX   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStepY   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal   AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttPoint NO-UNDO
  FIELD iX AS INTEGER
  FIELD iY AS INTEGER
  FIELD ii AS INTEGER
  INDEX iPrim iX iY.

INPUT FROM data.txt.
REPEAT:
  IMPORT UNFORMATTED cLine.
  cLine = REPLACE(cLine,' -> ',',').
  IF NUM-ENTRIES(cLine,",") < 3 THEN LEAVE.

  iStartX  = INTEGER(ENTRY(1,cLine)).
  iStartY  = INTEGER(ENTRY(2,cLine)).
  iEndX    = INTEGER(ENTRY(3,cLine)).
  iEndY    = INTEGER(ENTRY(4,cLine)).
  iLengthX = ABS(iEndX - iStartX).
  iLengthY = ABS(iEndY - iStartY).
  iStepX   = (IF iStartX = iEndX THEN 0 ELSE IF iStartX < iEndX THEN 1 ELSE -1).
  iStepY   = (IF iStartY = iEndY THEN 0 ELSE IF iStartY < iEndY THEN 1 ELSE -1).

  IF (iStartX <> iEndX) AND (iStartY <> iEndY) AND (iLengthX <> iLengthY) THEN NEXT.

  DO xx = 0 TO iLengthX:
    DO yy = 0 TO iLengthY:

      IF NOT (   (iStartX = iEndX) 
              OR (iStartY = iEndY)
              OR (xx = yy)) THEN NEXT.

      FIND ttPoint 
        WHERE ttPoint.iX = (iStartX + xx * iStepX) 
          AND ttPoint.iY = (iStartY + yy * iStepY) NO-ERROR.

      IF NOT AVAILABLE ttPoint THEN 
      DO:
        CREATE ttPoint.
        ASSIGN ttPoint.iX = (iStartX + xx * iStepX)
               ttPoint.iY = (iStartY + yy * iStepY).
      END.

      ASSIGN ttPoint.ii = ttPoint.ii + 1.
    END. /* do yy */
  END. /* do xx */

END. /* repeat */
INPUT CLOSE. 

FOR EACH ttPoint WHERE ttPoint.ii > 1:
  iTotal = iTotal + 1.
END.

MESSAGE iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 19939 */

