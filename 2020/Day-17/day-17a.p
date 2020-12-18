/* AoC 2020 day 17a
 */ 
DEFINE TEMP-TABLE ttCube NO-UNDO
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  FIELD zz AS INTEGER
  FIELD ii AS INTEGER
  FIELD nn AS INTEGER
  FIELD i2 AS INTEGER
  INDEX iPrim AS PRIMARY xx yy zz.

DEFINE BUFFER bCube FOR ttCube. 

DEFINE VARIABLE iX     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iY     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iZ     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iMinX  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxX  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMinY  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxY  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMinZ  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxZ  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCycle AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCubes AS INTEGER   NO-UNDO.

ETIME(YES).
INPUT FROM "input.txt".
REPEAT:
  IMPORT cLine.
  iY = iY + 1.
  DO iX = 1 TO LENGTH(cLine):
    CREATE bCube.
    ASSIGN 
      bCube.xx = iX - 1
      bCube.yy = iY - 1
      bCube.zz = 0
      bCube.ii = INT(SUBSTRING(cLine,iX,1) = '#')
      bCube.nn = 0.

    iMinX = MINIMUM(iMinX, bCube.xx).
    iMaxX = MAXIMUM(iMaxX, bCube.xx).

    iMinY = MINIMUM(iMinY, bCube.yy).
    iMaxY = MAXIMUM(iMaxY, bCube.yy).

    iMinZ = MINIMUM(iMinZ, bCube.zz).
    iMaxZ = MAXIMUM(iMaxZ, bCube.zz).
  END.
END.
INPUT CLOSE. 

RUN expandGrid.
DO iCycle = 1 TO 6:
  HIDE MESSAGE NO-PAUSE.
  MESSAGE iCycle.
  PROCESS EVENTS.

  RUN expandGrid.
  RUN countNeighbours.
  RUN doCycle.
  /* RUN logCubes. */
END.

FOR EACH bCube:
  iCubes = iCubes + bCube.ii.
END.
MESSAGE 'Part 1:' iCubes SKIP 'Time: ' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 298                 */
/* Time:  3871                 */
/* --------------------------- */
/* OK                          */
/* --------------------------- */


PROCEDURE countNeighbours:
  DEFINE VARIABLE iX AS INTEGER NO-UNDO.
  DEFINE VARIABLE iY AS INTEGER NO-UNDO.
  DEFINE VARIABLE iZ AS INTEGER NO-UNDO.
  DEFINE BUFFER bCube  FOR ttCube. 

  FOR EACH bCube:
    bCube.nn = 0.
    DO iX = -1 TO 1:
      DO iY = -1 TO 1:
        DO iZ = -1 TO 1:
          IF iX = 0 AND iY = 0 AND iZ = 0 THEN NEXT. 
          IF CAN-FIND(ttCube WHERE ttCube.xx = bCube.xx + iX AND ttCube.yy = bCube.yy + iY AND ttCube.zz = bCube.zz + iZ AND ttCube.ii = 1) THEN 
            bCube.nn = bCube.nn + 1.
        END.
      END.
    END.
  END.
END PROCEDURE. /* countNeighbours */


PROCEDURE expandGrid:
  DEFINE VARIABLE iX AS INTEGER NO-UNDO.
  DEFINE VARIABLE iY AS INTEGER NO-UNDO.
  DEFINE VARIABLE iZ AS INTEGER NO-UNDO.
  DEFINE BUFFER bCube FOR ttCube. 

  DO iX = iMinX - 1 TO iMaxX + 1:
    DO iY = iMinY - 1 TO iMaxY + 1:
      DO iZ = iMinZ - 1 TO iMaxZ + 1:

        IF NOT CAN-FIND(bCube WHERE bCube.xx = iX AND bCube.yy = iY AND bCube.zz = iZ) THEN
        DO:
          CREATE bCube.
          ASSIGN bCube.xx = iX
                 bCube.yy = iY
                 bCube.zz = iZ.
        END.
      END.
    END.
  END.

  FOR EACH bCube:
    iMinX = MINIMUM(iMinX, bCube.xx).
    iMaxX = MAXIMUM(iMaxX, bCube.xx).

    iMinY = MINIMUM(iMinY, bCube.yy).
    iMaxY = MAXIMUM(iMaxY, bCube.yy).

    iMinZ = MINIMUM(iMinZ, bCube.zz).
    iMaxZ = MAXIMUM(iMaxZ, bCube.zz).
  END.
END PROCEDURE. /* expandGrid */


PROCEDURE doCycle:
  DEFINE BUFFER bCube FOR ttCube.

  FOR EACH bCube:
    IF bCube.ii = 1 THEN 
      bCube.i2 = (IF bCube.nn = 2 OR bCube.nn = 3 THEN 1 ELSE 0).
    ELSE 
      bCube.i2 = (IF bCube.nn = 3 THEN 1 ELSE 0).
  END.

  FOR EACH bCube:
    bCube.ii = bCube.i2.
    bCube.i2 = 0.
  END.
END PROCEDURE. /* doCycle */


PROCEDURE logCubes:
  /* For fun & debugging, to see the cubes
  */
  DEFINE BUFFER bCube FOR ttCube. 

  DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER     NO-UNDO.

  OUTPUT TO c:\temp\ttCube.txt APPEND.
  PUT UNFORMATTED SKIP "After " iCycle " cycles  X:" iMinX "-" iMaxX " Y:"iMinY "-" iMaxY " Z:" iMinZ "-" iMaxZ SKIP(1).
  FOR EACH bCube NO-LOCK BREAK BY bCube.zz BY bCube.yy BY bCube.xx:
    IF FIRST-OF(bCube.zz) THEN PUT UNFORMATTED SKIP 'z=' + STRING(bCube.zz) SKIP.
    IF FIRST-OF(bCube.yy) THEN cLine = ''.
    cLine = cLine + ENTRY(bCube.ii + 1,'.,#').
    IF LAST-OF(bCube.yy) THEN PUT UNFORMATTED cLine SKIP.
    IF LAST-OF(bCube.zz) THEN PUT UNFORMATTED SKIP(1).
  END.
  OUTPUT CLOSE. 
END PROCEDURE. 

