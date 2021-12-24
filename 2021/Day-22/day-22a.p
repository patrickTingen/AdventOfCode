/* AoC 2021 day 22a
 */ 
&GLOBAL-DEFINE path c:\Data\DropBox\AdventOfCode\2021\Day-22\

DEFINE TEMP-TABLE ttPoint NO-UNDO
  FIELD x AS INTEGER
  FIELD y AS INTEGER
  FIELD z AS INTEGER
  INDEX iLoc X Y Z.

DEFINE VARIABLE xx    AS INTEGER   NO-UNDO.
DEFINE VARIABLE yy    AS INTEGER   NO-UNDO.
DEFINE VARIABLE zz    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLine AS INTEGER   NO-UNDO.

/* on x=10..12,y=10..12,z=10..12 */
INPUT FROM "{&path}data.txt".
REPEAT:
  IMPORT UNFORMATTED cLine. 
  IF cLine = "" THEN NEXT. 

  cLine = REPLACE(cLine,'..',','). /* on x=10,12,y=10,12,z=10,12 */ 
  cLine = REPLACE(cLine,'=',',').  /* on x,10,12,y,10,12,z,10,12 */ 

  /* Skip large values */
  IF   INTEGER(ENTRY(2,cLine)) < -50 OR INTEGER(ENTRY(3,cLine)) > 50
    OR INTEGER(ENTRY(5,cLine)) < -50 OR INTEGER(ENTRY(6,cLine)) > 50
    OR INTEGER(ENTRY(8,cLine)) < -50 OR INTEGER(ENTRY(9,cLine)) > 50 THEN NEXT.

  DO xx = INTEGER(ENTRY(2,cLine)) TO INTEGER(ENTRY(3,cLine)):
    DO yy = INTEGER(ENTRY(5,cLine)) TO INTEGER(ENTRY(6,cLine)):
      DO zz = INTEGER(ENTRY(8,cLine)) TO INTEGER(ENTRY(9,cLine)):

        FIND ttPoint WHERE ttPoint.X = xx AND ttPoint.Y = yy AND ttPoint.z = zz NO-ERROR.

        IF cLine BEGINS 'off' THEN 
        DO:
          IF AVAILABLE ttPoint THEN DELETE ttPoint. 
          NEXT. 
        END.
        
        IF NOT AVAILABLE ttPoint THEN 
        DO:
          CREATE ttPoint. 
          ASSIGN ttPoint.X = xx 
                 ttPoint.Y = yy 
                 ttPoint.z = zz.
        END.
      END.
    END.
  END.
END.
INPUT CLOSE. 

FOR EACH ttPoint:
  ACCUMULATE ttPoint.X (COUNT).
END.

MESSAGE ACCUM COUNT ttPoint.X /* 570915 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

