/* Advent of code 2018
** day 3
*/
DEFINE TEMP-TABLE ttClaim NO-UNDO
  FIELD xx AS INTEGER
  FIELD yy AS INTEGER
  FIELD ii AS INTEGER
  INDEX iPrim xx yy. 

DEFINE VARIABLE cData AS CHARACTER EXTENT 4 NO-UNDO.
DEFINE VARIABLE cFile AS CHARACTER   NO-UNDO INITIAL "2018-03.dat".
DEFINE VARIABLE iX    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iY    AS INTEGER     NO-UNDO.
DEFINE VARIABLE xx    AS INTEGER     NO-UNDO.
DEFINE VARIABLE yy    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iW    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iH    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iNum  AS INTEGER     NO-UNDO.

/* Data looks like:
#1 @ 555,891: 18x12
#2 @ 941,233: 16x14
#3 @ 652,488: 16x25
#4 @ 116,740: 13x14
*/
INPUT FROM VALUE(cFile).
REPEAT:
  IMPORT cData.
  cData[3] = TRIM(cData[3],':').

  iX = INTEGER(ENTRY(1,cData[3])).
  iY = INTEGER(ENTRY(2,cData[3])).
  iW = INTEGER(ENTRY(1,cData[4],'x')).
  iH = INTEGER(ENTRY(2,cData[4],'x')).

  DO yy = 0 TO iH - 1:
    DO xx = 0 TO iW - 1:
      FIND ttClaim WHERE ttClaim.xx = iX + xx AND ttClaim.yy = iY + yy NO-ERROR.
      IF NOT AVAILABLE ttClaim THEN CREATE ttClaim.
      ASSIGN ttClaim.xx = iX + xx ttClaim.yy = iY + yy ttClaim.ii = ttClaim.ii + 1.
    END.
  END.
END.
INPUT CLOSE. 

/* read it again */
INPUT FROM VALUE(cFile).
#Claim:
REPEAT:
  IMPORT cData.
  cData[3] = TRIM(cData[3],':').

  iX = INTEGER(ENTRY(1,cData[3])).
  iY = INTEGER(ENTRY(2,cData[3])).
  iW = INTEGER(ENTRY(1,cData[4],'x')).
  iH = INTEGER(ENTRY(2,cData[4],'x')).

  DO yy = 0 TO iH - 1:
    DO xx = 0 TO iW - 1:
      FIND ttClaim WHERE ttClaim.xx = iX + xx AND ttClaim.yy = iY + yy.
      IF ttClaim.ii > 1 THEN NEXT #Claim.
    END.
  END.
  MESSAGE cData[1] VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  LEAVE #Claim.
END.
INPUT CLOSE. 


