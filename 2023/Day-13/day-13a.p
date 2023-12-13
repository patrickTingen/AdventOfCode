/* AoC 2023 day 13a
 */ 
DEFINE TEMP-TABLE ttPattern NO-UNDO
  FIELD iNr   AS INTEGER   FORMAT ">>>9"
  FIELD iLine AS INTEGER   FORMAT ">>>9"
  FIELD cData AS CHARACTER FORMAT "X(20)"
  INDEX iPrim iNr iLine.

DEFINE TEMP-TABLE ttPos NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  INDEX idxPrim iPosX iPosY.
  
FUNCTION pos RETURNS CHARACTER
  ( piX AS INTEGER
  , piY AS INTEGER
  ):    
  DEFINE BUFFER bPos FOR ttPos.

  FIND bPos WHERE bPos.iPosX = piX AND bPos.iPosY = piY NO-ERROR.
  RETURN (IF NOT AVAILABLE bPos THEN "" ELSE bPos.cValue). 
END FUNCTION. 

FUNCTION isHorMirror RETURNS LOGICAL (piRow AS INTEGER):
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE VARIABLE j AS INTEGER NO-UNDO.
  DEFINE VARIABLE a AS CHARACTER NO-UNDO.
  DEFINE VARIABLE b AS CHARACTER NO-UNDO.

  DO j = 1 TO 100:
    REPEAT i = 1 TO piRow:
      a = pos(j,piRow - i + 1).
      b = pos(j,piRow + i).
  
      IF a = "" OR b = "" THEN LEAVE.
      IF a <> b THEN RETURN FALSE.
    END.
  END.

  RETURN YES.
END FUNCTION. 

FUNCTION isVerMirror RETURNS LOGICAL (piCol AS INTEGER):
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE VARIABLE j AS INTEGER NO-UNDO.
  DEFINE VARIABLE a AS CHARACTER NO-UNDO.
  DEFINE VARIABLE b AS CHARACTER NO-UNDO.

  DO j = 1 TO 100:
    REPEAT i = 1 TO piCol:
      a = pos(piCol - i + 1, j).
      b = pos(piCol + i    , j).
  
      IF a = "" OR b = "" THEN LEAVE.
      IF a <> b THEN RETURN FALSE.
    END.
  END.

  RETURN YES.
END FUNCTION. 

DEFINE VARIABLE cData    AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iLine    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRow     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCol     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNumCols AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNumRows AS INTEGER   NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPattern AS INTEGER   NO-UNDO INITIAL 1.

INPUT FROM "data.txt".
REPEAT:
  cLine = "".
  IMPORT cLine.

  IF cLine = "" THEN 
  DO:
    iPattern = iPattern + 1.
    iLine = 0.
    NEXT.
  END.

  iLine = iLine + 1.
  CREATE ttPattern.
  ASSIGN 
    ttPattern.iNr   = iPattern
    ttPattern.iLine = iLine
    ttPattern.cData = cLine.
END.
INPUT CLOSE. 

FOR EACH ttPattern BREAK BY ttPattern.iNr: 

  IF FIRST-OF(ttPattern.iNr) THEN
  DO:
    EMPTY TEMP-TABLE ttPos. 
    iRow = 0.
    iNumCols = 0.
    iNumRows = 0.
  END.

  iRow = iRow + 1.
  DO iCol = 1 TO LENGTH(ttPattern.cData):
    CREATE ttPos.
    ASSIGN ttPos.iPosY  = iRow
           ttPos.iPosX  = iCol
           ttPos.cValue = SUBSTRING(ttPattern.cData,iCol,1).

    iNumCols = MAX(iNumCols,iCol).
    iNumRows = MAX(iNumRows,iRow).
  END.

  IF LAST-OF(ttPattern.iNr) THEN
  DO:
    /* Check mirrors */
    DO i = 1 TO iNumRows - 1:
      IF isHorMirror(i) THEN DO:
        iAnswer = iAnswer + (i * 100).
        LEAVE.
      END.
    END.

    DO i = 1 TO iNumCols - 1:
      IF isVerMirror(i) THEN DO:
        iAnswer = iAnswer + i.
        LEAVE.
      END.
    END.

    /* reset */
    NEXT.
  END.
END.

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


