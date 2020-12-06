/* AoC 2020 - DAY 6
*/
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER   NO-UNDO.
DEFINE VARIABLE iGrpNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE lSame  AS LOGICAL   NO-UNDO.

DEFINE TEMP-TABLE ttGroup NO-UNDO 
  FIELD iGroup AS INTEGER
  FIELD iScore AS INTEGER.

DEFINE TEMP-TABLE ttData NO-UNDO
  FIELD iGroup AS INTEGER
  FIELD cData  AS CHARACTER FORMAT 'x(20)'.

INPUT FROM day-06.dat.
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' OR NOT AVAILABLE ttGroup THEN DO:
    iGrpNr = iGrpNr + 1.
    CREATE ttGroup.
    ASSIGN ttGroup.iGroup = iGrpNr.
  END.
  IF cLine = '' THEN NEXT.
  CREATE ttData.
  ASSIGN ttData.iGroup = iGrpNr
         ttData.cData  = LOWER(REPLACE(cLine,' ','')).
END.
INPUT CLOSE. 

FOR EACH ttGroup:
  DO i = 97 TO 122:
    lSame = TRUE. 
    FOR EACH ttData WHERE ttData.iGroup = ttGroup.iGroup:
      IF INDEX(ttData.cData, CHR(i)) = 0 THEN lSame = FALSE.
    END.
    IF lSame THEN ttGroup.iScore = ttGroup.iScore + 1.
  END.
  iTotal = iTotal + ttGroup.iScore.
END.

MESSAGE iTotal /* 3158 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

