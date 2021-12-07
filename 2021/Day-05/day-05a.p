/* AoC 2021 day 05a 
 */ 
DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE xx       AS INTEGER   NO-UNDO.
DEFINE VARIABLE yy       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartX  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStartY  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iEndX    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iEndY    AS INTEGER   NO-UNDO.
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

  iStartX  = MINIMUM(INTEGER(ENTRY(1,cLine)),INTEGER(ENTRY(3,cLine))).
  iStartY  = MINIMUM(INTEGER(ENTRY(2,cLine)),INTEGER(ENTRY(4,cLine))).
  iEndX    = MAXIMUM(INTEGER(ENTRY(1,cLine)),INTEGER(ENTRY(3,cLine))).
  iEndY    = MAXIMUM(INTEGER(ENTRY(2,cLine)),INTEGER(ENTRY(4,cLine))).

  /* Only true HOR or VER lines */
  IF (iStartX <> iEndX) AND (iStartY <> iEndY) THEN NEXT.

  DO xx = iStartX TO iEndX:
    DO yy = iStartY TO iEndY:

      FIND ttPoint WHERE ttPoint.iX = xx AND ttPoint.iY = yy NO-ERROR.
      IF NOT AVAILABLE ttPoint THEN 
      DO:
        CREATE ttPoint.
        ASSIGN ttPoint.iX = xx
               ttPoint.iY = yy.
      END.
      ASSIGN ttPoint.ii = ttPoint.ii + 1.
    END. /* do yy */
  END. /* do xx */

END. /* repeat */
INPUT CLOSE. 

FOR EACH ttPoint WHERE ttPoint.ii > 1:
  iTotal = iTotal + 1.
END.

MESSAGE iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 7318 */
