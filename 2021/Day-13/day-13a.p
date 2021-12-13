/* AoC 2021 day 13a 
 */ 
DEFINE TEMP-TABLE ttDot
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  INDEX iPrim IS PRIMARY xx yy.

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLine    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNumDots AS INTEGER   NO-UNDO.

INPUT FROM "data.txt".
REPEAT TRANSACTION:
  CREATE ttDot.
  IMPORT DELIMITER "," ttDot.xx ttDot.yy.
  IF ttDot.xx = 0 AND ttDot.yy = 0 THEN UNDO, LEAVE.
END.

/* Fold instruction */
IMPORT DELIMITER "=" cLine iLine. /* fold along y=7 */
INPUT CLOSE. 

IF cLine MATCHES "*y" THEN 
FOR EACH ttDot WHERE ttDot.yy > iLine:
  ttDot.yy = iLine - (ttDot.yy - iLine).
END.

IF cLine MATCHES "*x" THEN 
FOR EACH ttDot WHERE ttDot.xx > iLine:
  ttDot.xx = iLine - (ttDot.xx - iLine).
END.

/* Count nr of dots */
FOR EACH ttDot BREAK BY ttDot.xx BY ttDot.yy:
  IF FIRST-OF(ttDot.yy) THEN iNumDots = iNumDots + 1.
END.

MESSAGE iNumDots VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

