/* Advent of code 2018
** day 6
*/
DEFINE TEMP-TABLE ttGrid
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  FIELD ii AS INTEGER
  INDEX iPrim xx yy
  INDEX iSec ii.
  
DEFINE TEMP-TABLE ttCo
  FIELD id AS CHARACTER
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  INDEX iPrim xx yy.

DEFINE VARIABLE iDist AS INTEGER NO-UNDO INITIAL 10000.
DEFINE VARIABLE iMinX AS INTEGER NO-UNDO.
DEFINE VARIABLE iMinY AS INTEGER NO-UNDO.
DEFINE VARIABLE iMaxX AS INTEGER NO-UNDO.
DEFINE VARIABLE iMaxY AS INTEGER NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.

PAUSE 0 BEFORE-HIDE. 

RUN readCoordinates("2018-06.dat").
RUN getMinMax(OUTPUT iMinX, OUTPUT iMinY, OUTPUT iMaxX, OUTPUT iMaxY). /* 51, 71, 182,296 */
RUN createGrid(INPUT iMinX, INPUT iMinY, INPUT iMaxX, INPUT iMaxY).

REPEAT:
  IF ETIME > 500 THEN DO:
    MESSAGE SUBSTITUTE('&1,&2 - &3,&4', iMinX, iMinY, iMaxX, iMaxY).
    ETIME(YES).
  END.

  /* Extend left */
  IF CAN-FIND(FIRST ttGrid WHERE ttGrid.xx = iMinX AND ttGrid.ii < iDist) THEN 
  DO: 
    iMinX = iMinX - 1.
    RUN createGrid(iMinX, iMinY, iMinX, iMaxY).
  END. 
  ELSE 

  /* Extend right */
  IF CAN-FIND(FIRST ttGrid WHERE ttGrid.xx = iMaxX AND ttGrid.ii < iDist) THEN 
  DO: 
    iMaxX = iMaxX + 1.
    RUN createGrid(iMaxX, iMinY, iMaxX, iMaxY).
  END. 
  ELSE 

  /* Extend up */
  IF CAN-FIND(FIRST ttGrid WHERE ttGrid.yy = iMinY AND ttGrid.ii < iDist) THEN 
  DO: 
    iMinY = iMinY - 1.
    RUN createGrid(iMinX, iMinY, iMaxX, iMinY).
  END. 
  ELSE 

  /* Extend down */
  IF CAN-FIND(FIRST ttGrid WHERE ttGrid.yy = iMaxY AND ttGrid.ii < iDist) THEN 
  DO: 
    iMaxY = iMaxY + 1.
    RUN createGrid(iMinX, iMaxY, iMaxX, iMaxY).
  END. 

  ELSE 
  DO:
    i = 0.
    FOR EACH ttGrid WHERE ttGrid.ii < iDist : i = i + 1. END.
    MESSAGE i VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE. 
  END.
END.

RUN genVisuals.


PROCEDURE getMinMax:
  DEFINE OUTPUT PARAMETER piMinX AS INTEGER NO-UNDO INITIAL ?.
  DEFINE OUTPUT PARAMETER piMinY AS INTEGER NO-UNDO INITIAL ?.
  DEFINE OUTPUT PARAMETER piMaxX AS INTEGER NO-UNDO INITIAL ?.
  DEFINE OUTPUT PARAMETER piMaxY AS INTEGER NO-UNDO INITIAL ?.

  DEFINE BUFFER bCo FOR ttCo.
  FOR EACH bCo:
    piMinX = (IF piMinX = ? THEN bCo.xx ELSE MINIMUM(piMinX,bCo.xx)).
    piMinY = (IF piMinY = ? THEN bCo.yy ELSE MINIMUM(piMinY,bCo.yy)).
    piMaxX = (IF piMaxX = ? THEN bCo.xx ELSE MAXIMUM(piMaxX,bCo.xx)).
    piMaxY = (IF piMaxY = ? THEN bCo.yy ELSE MAXIMUM(piMaxY,bCo.yy)).
  END.
END PROCEDURE. 


PROCEDURE readCoordinates:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.

  DEFINE BUFFER bCo FOR ttCo.

  INPUT FROM VALUE(pcFile).
  REPEAT TRANSACTION:
    CREATE bCo.
    IMPORT UNFORMATTED c.
    ASSIGN 
      i      = i + 1
      bCo.xx = INTEGER(ENTRY(1,c))
      bCo.yy = INTEGER(ENTRY(2,c))
      bCo.id = STRING(CHR(64 + i)).
      .
  END.
  INPUT CLOSE. 
END PROCEDURE. 


PROCEDURE createGrid:
  DEFINE INPUT PARAMETER piMinX AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER piMinY AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER piMaxX AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER piMaxY AS INTEGER NO-UNDO.

  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE VARIABLE j AS INTEGER NO-UNDO.

  DEFINE BUFFER bGrid FOR ttGrid.
  DEFINE BUFFER bCo FOR ttCo.

  DO i = piMinX TO piMaxX:
    DO j = piMinY TO piMaxY:
      CREATE bGrid.
      ASSIGN bGrid.xx = i bGrid.yy = j.

      FOR EACH bCo:
        bGrid.ii = bGrid.ii + (ABS(bGrid.xx - bCo.xx) + ABS(bGrid.yy - bCo.yy)).
      END. 
    END. 
  END.
END PROCEDURE. 


PROCEDURE genVisuals:
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.

  OUTPUT TO "2018-06-visual2.txt".
  DEFINE BUFFER bGrid FOR ttGrid.

  FOR EACH bGrid BREAK BY bGrid.yy BY bGrid.xx:
    IF FIRST-OF(bGrid.yy) THEN c = ''.
    c = c + STRING(bGrid.ii < iDist,'X/.').
    IF LAST-OF(bGrid.yy) THEN PUT UNFORMATTED c SKIP.
  END. 
  OUTPUT CLOSE. 

END PROCEDURE. 
