/* AoC 2023 day 03b 
 */ 
DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER 
  FIELD iValue AS INTEGER
  FIELD lDigit AS LOGICAL
  FIELD lPart  AS LOGICAL
  INDEX iPrim iPosX iPosY. 

PROCEDURE readGrid:
  /* Read grid via longchar into TT
  */
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL ?.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Read data and strip nasty characters */
  COPY-LOB FILE "data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').

  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:
      CREATE bLoc.
      ASSIGN 
        bLoc.iPosX  = iX
        bLoc.iPosY  = iY
        bLoc.cValue = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1)
        bLoc.lDigit = LOOKUP(bLoc.cValue, '0,1,2,3,4,5,6,7,8,9') > 0.

      bLoc.iValue = (IF bLoc.lDigit THEN INTEGER(bLoc.cValue) ELSE ?).
      IF NOT bLoc.lDigit AND bLoc.cValue <> '.' THEN bLoc.lPart = TRUE.
    END.
  END.

END PROCEDURE. /* readGrid */

FUNCTION getPartNr RETURNS INTEGER (piPosX AS INTEGER, piPosY AS INTEGER):
  DEFINE VARIABLE iPartNr AS INTEGER NO-UNDO.
  DEFINE VARIABLE iStart  AS INTEGER NO-UNDO.
  DEFINE BUFFER bLoc FOR ttLoc. 

  FIND bLoc WHERE bLoc.iPosX = piPosX AND bLoc.iPosY = piPosY NO-ERROR.
  IF AVAILABLE bLoc AND bLoc.lDigit = FALSE THEN RETURN 0.

  FIND LAST bLoc WHERE bLoc.iPosX < piPosX AND bLoc.iPosY = piPosY AND bLoc.lDigit = FALSE NO-ERROR.
  iStart = (IF AVAILABLE bLoc THEN bLoc.iPosX + 1 ELSE 1).

  FOR EACH bLoc WHERE bLoc.iPosY = piPosY AND bLoc.iPosX >= iStart:
    IF bLoc.lDigit = FALSE THEN LEAVE.
    iPartNr = iPartNr * 10 + bLoc.iValue.
  END.

  RETURN iPartNr.
END FUNCTION.

FUNCTION isDigit RETURNS LOGICAL (piPosX AS INTEGER, piPosY AS INTEGER):
  DEFINE BUFFER bLoc FOR ttLoc. 
  FIND bLoc WHERE bLoc.iPosX = piPosX AND bLoc.iPosY = piPosY NO-ERROR.
  RETURN (IF AVAILABLE bLoc THEN bLoc.lDigit ELSE ?).
END FUNCTION. 

RUN readGrid.

DEFINE VARIABLE iProd       AS INT64     NO-UNDO.
DEFINE VARIABLE iAnswer     AS INT64     NO-UNDO.
DEFINE VARIABLE iParts      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPartLeft   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPartRight  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPartUp     AS INTEGER   NO-UNDO EXTENT 3.
DEFINE VARIABLE iPartDown   AS INTEGER   NO-UNDO EXTENT 3.
DEFINE VARIABLE lDigitUp    AS LOGICAL   NO-UNDO EXTENT 3.
DEFINE VARIABLE lDigitDown  AS LOGICAL   NO-UNDO EXTENT 3.
DEFINE VARIABLE iNumParts   AS INTEGER   NO-UNDO.

DEFINE BUFFER btLoc FOR ttLoc.

FOR EACH ttLoc WHERE ttLoc.cValue = '*':

  iPartUp[1]   = getPartNr(ttLoc.iPosX - 1, ttLoc.iPosY - 1).
  iPartUp[2]   = getPartNr(ttLoc.iPosX + 0, ttLoc.iPosY - 1).
  iPartUp[3]   = getPartNr(ttLoc.iPosX + 1, ttLoc.iPosY - 1).
  iPartLeft    = getPartNr(ttLoc.iPosX - 1, ttLoc.iPosY).
  iPartRight   = getPartNr(ttLoc.iPosX + 1, ttLoc.iPosY).
  iPartDown[1] = getPartNr(ttLoc.iPosX - 1, ttLoc.iPosY + 1).
  iPartDown[2] = getPartNr(ttLoc.iPosX + 0, ttLoc.iPosY + 1).
  iPartDown[3] = getPartNr(ttLoc.iPosX + 1, ttLoc.iPosY + 1).
                                           
  lDigitUp[1]   = isDigit(ttLoc.iPosX - 1, ttLoc.iPosY - 1).
  lDigitUp[2]   = isDigit(ttLoc.iPosX + 0, ttLoc.iPosY - 1).
  lDigitUp[3]   = isDigit(ttLoc.iPosX + 1, ttLoc.iPosY - 1).
  lDigitDown[1] = isDigit(ttLoc.iPosX - 1, ttLoc.iPosY + 1).
  lDigitDown[2] = isDigit(ttLoc.iPosX + 0, ttLoc.iPosY + 1).
  lDigitDown[3] = isDigit(ttLoc.iPosX + 1, ttLoc.iPosY + 1).

  IF lDigitUp[1] AND lDigitUp[2] AND lDigitUp[3] THEN ASSIGN iPartUp[2] = 0 iPartUp[3] = 0.
  ELSE IF NOT lDigitUp[1] AND lDigitUp[2] AND lDigitUp[3] THEN ASSIGN iPartUp[3] = 0.
  ELSE IF lDigitUp[1] AND lDigitUp[2] AND NOT lDigitUp[3] THEN ASSIGN iPartUp[2] = 0.

  IF lDigitDown[1] AND lDigitDown[2] AND lDigitDown[3] THEN ASSIGN iPartDown[2] = 0 iPartDown[3] = 0.
  ELSE IF NOT lDigitDown[1] AND lDigitDown[2] AND lDigitDown[3] THEN ASSIGN iPartDown[3] = 0.
  ELSE IF lDigitDown[1] AND lDigitDown[2] AND NOT lDigitDown[3] THEN ASSIGN iPartDown[2] = 0.

  iParts = 0.
  iProd = 1.
  IF iPartLeft    <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartLeft  .
  IF iPartRight   <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartRight .
  IF iPartUp[1]   <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartUp[1] .
  IF iPartUp[2]   <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartUp[2] .
  IF iPartUp[3]   <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartUp[3] .
  IF iPartDown[1] <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartDown[1].
  IF iPartDown[2] <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartDown[2].
  IF iPartDown[3] <> 0 THEN ASSIGN iParts = iParts + 1 iProd = iProd * iPartDown[3].

  IF iParts = 2 THEN iAnswer = iAnswer + iProd.
END.

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

