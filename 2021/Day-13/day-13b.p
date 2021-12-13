/* AoC 2021 day 13b 
 */ 
DEFINE TEMP-TABLE ttDot
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  INDEX iPrim IS PRIMARY xx yy.

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLine    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxX    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxY    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNumDots AS INTEGER   NO-UNDO.

INPUT FROM "data.txt".
REPEAT TRANSACTION:
  CREATE ttDot.
  IMPORT DELIMITER "," ttDot.xx ttDot.yy.
  IF ttDot.xx = 0 AND ttDot.yy = 0 THEN UNDO, LEAVE.
  iMaxX = MAX(iMaxX, ttDot.xx).
  iMaxY = MAX(iMaxY, ttDot.yy).
END.

/* Fold instructions */
REPEAT:
  IMPORT DELIMITER "=" cLine iLine. /* fold along y=7 */
  
  IF cLine MATCHES "*y" THEN 
  DO:
    FOR EACH ttDot WHERE ttDot.yy > iLine:
      ttDot.yy = iLine - (ttDot.yy - iLine).
    END.
    iMaxY = iLine.
  END.
  
  IF cLine MATCHES "*x" THEN 
  DO:
    FOR EACH ttDot WHERE ttDot.xx > iLine:
      ttDot.xx = iLine - (ttDot.xx - iLine).
    END.
    iMaxX = iLine.
  END.
END.

RUN showPaper.

PROCEDURE showPaper:
  DEFINE VARIABLE cMsg AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iX   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY   AS INTEGER   NO-UNDO.
  DEFINE BUFFER bDot FOR ttDot.

  DO iY = 0 TO iMaxY:
    DO iX = 0 TO iMaxX:
      FIND FIRST bDot WHERE bDot.xx = iX AND bDot.yy = iY NO-ERROR.
      cMsg = cMsg + STRING(AVAILABLE bDot, "#/ ").
    END.
    cMsg = cMsg + "~n".
  END.

  MESSAGE cMsg VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END PROCEDURE. /* showPaper */


/* FGKCKBZG */
/* ----------------------------------------- */
/* ####..##..#..#..##..#..#.###..####..##... */
/* #....#..#.#.#..#..#.#.#..#..#....#.#..#.. */
/* ###..#....##...#....##...###....#..#..... */
/* #....#.##.#.#..#....#.#..#..#..#...#.##.. */
/* #....#..#.#.#..#..#.#.#..#..#.#....#..#.. */
/* #.....###.#..#..##..#..#.###..####..###.. */
/* ......................................... */
/* ----------------------------------------- */
