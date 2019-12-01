/* Advent of code 2018
** day 6
*/
DEFINE TEMP-TABLE ttGrid
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  FIELD cc AS CHARACTER
  INDEX iPrim xx yy.
  
DEFINE TEMP-TABLE ttCo
  FIELD id AS CHARACTER
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  FIELD ii AS INTEGER
  FIELD jj AS INTEGER
  INDEX iPrim xx yy
  INDEX iSec ii.

DEFINE VARIABLE iMinX AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iMinY AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iMaxX AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iMaxY AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE j AS INTEGER     NO-UNDO.
DEFINE VARIABLE c AS CHARACTER   NO-UNDO.

PAUSE 0 BEFORE-HIDE. 

INPUT FROM "2018-06.dat".
REPEAT TRANSACTION:
  CREATE ttCo.
  IMPORT UNFORMATTED c.
  ttCo.xx = INTEGER(ENTRY(1,c)).
  ttCo.yy = INTEGER(ENTRY(2,c)).
  iMinX = (IF iMinX = ? THEN ttCo.xx ELSE MINIMUM(iMinX,ttCo.xx)).
  iMinY = (IF iMinY = ? THEN ttCo.yy ELSE MINIMUM(iMinY,ttCo.yy)).
  iMaxX = (IF iMaxX = ? THEN ttCo.xx ELSE MAXIMUM(iMaxX,ttCo.xx)).
  iMaxY = (IF iMaxY = ? THEN ttCo.yy ELSE MAXIMUM(iMaxY,ttCo.yy)).
  i = i + 1.
  ttCo.id = STRING(chr(64 + i)).
END.
INPUT CLOSE. 

/*
Min  51, 71 
Max 182,296
*/

iMinX = iMinX - 10.
iMinY = iMinY - 10.
iMaxX = iMaxX + 10.
iMaxY = iMaxY + 10.

DO i = iMinX TO iMaxX:
  DO j = iMinY TO iMaxY:
    CREATE ttGrid.
    ASSIGN ttGrid.xx = i ttGrid.yy = j.
  END. 
END.

FOR EACH ttGrid BY ttGrid.xx BY ttGrid.yy:

  IF ETIME > 1000 THEN
  DO:
    MESSAGE ttGrid.xx.
    ETIME(YES).
  END.                

  FOR EACH ttCo:
    ttCo.ii = ABS(ttGrid.xx - ttCo.xx) + ABS(ttGrid.yy - ttCo.yy).    
  END.
  
  FOR EACH ttCo BREAK BY ttCo.ii:
  
    IF FIRST-OF(ttCo.ii) THEN ttGrid.cc = ''.
    IF LOOKUP(ttCo.id,ttGrid.cc) = 0 THEN ttGrid.cc = TRIM(ttGrid.cc + ',' + ttCo.id,',').
    IF LAST-OF(ttCo.ii) THEN IF NUM-ENTRIES(ttGrid.cc) > 1 THEN ttGrid.cc = '.'.
    
    IF LAST-OF(ttCo.ii) THEN LEAVE. 
  END.  
  
  ttGrid.cc = LC(ttGrid.cc).
  FOR EACH ttCo WHERE ttCo.xx = ttGrid.xx AND ttCo.yy = ttGrid.yy:
    ttGrid.cc = CAPS(ttCo.id).
  END.
END.

/* Strip infinity */
FOR EACH ttGrid 
  WHERE ttGrid.xx = iMinX OR ttGrid.xx = iMaxX
     OR ttGrid.yy = iMinY OR ttGrid.yy = iMaxY:
  FIND ttCo WHERE ttCo.id = ttGrid.cc NO-ERROR.
  IF AVAILABLE ttCo THEN DELETE ttCo.
END.

FOR EACH ttGrid:
  FIND ttCo WHERE ttCo.id = ttGrid.cc NO-ERROR.
  IF NOT AVAILABLE ttCo THEN ttGrid.cc = ' '.
END.

/* Find largest */
FOR EACH ttGrid, EACH ttCo WHERE ttCo.id = ttGrid.cc:
  ttCo.jj = ttCo.jj + 1.
END.   

FOR EACH ttCo BY ttCo.jj DESCENDING:
  MESSAGE ttCo.jj VIEW-AS ALERT-BOX.
  LEAVE.
END. 

OUTPUT TO "2018-06-visual.txt".
FOR EACH ttGrid BREAK BY ttGrid.yy BY ttGrid.xx:
  IF FIRST-OF(ttGrid.yy) THEN c = ''.
  c = c + ttGrid.cc.
  IF LAST-OF(ttGrid.yy) THEN PUT UNFORMATTED c SKIP.
END. 
OUTPUT CLOSE. 

