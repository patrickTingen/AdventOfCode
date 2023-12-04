/* AoC 2023 day 03a 
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

RUN readGrid.

DEFINE VARIABLE iPartNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INTEGER   NO-UNDO.
DEFINE VARIABLE lNumber AS LOGICAL   NO-UNDO.
DEFINE BUFFER btLoc FOR ttLoc.

FOR EACH ttLoc by ttLoc.iPosY BY ttLoc.iPosX:
  
  IF ttLoc.iValue = ? THEN 
  DO:
    IF lNumber THEN 
      iAnswer = iAnswer + iPartNr.

    ASSIGN
      iPartNr = 0
      lNumber = FALSE.         
  END.
  ELSE 
  DO:
    iPartNr = (iPartNr * 10) + ttLoc.iValue.

    FIND FIRST btLoc 
      WHERE btLoc.iPosY >= ttLoc.iPosY - 1
        AND btLoc.iPosY <= ttLoc.iPosY + 1
        AND btLoc.iPosX >= ttLoc.iPosX - 1
        AND btLoc.iPosX <= ttLoc.iPosX + 1
        AND btLoc.lPart  = TRUE NO-ERROR.

    IF AVAILABLE btLoc THEN lNumber = TRUE.
  END.
END. 

MESSAGE iAnswer 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

