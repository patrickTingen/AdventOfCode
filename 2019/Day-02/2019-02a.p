/* Advent of code 2019
** day 2a
*/
DEFINE VARIABLE cData   AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i       AS INTEGER  NO-UNDO.
DEFINE VARIABLE iOpCode AS INTEGER  NO-UNDO.
DEFINE VARIABLE iRegOne AS INTEGER  NO-UNDO.
DEFINE VARIABLE iRegTwo AS INTEGER  NO-UNDO.
DEFINE VARIABLE iTarget AS INTEGER  NO-UNDO.

DEFINE TEMP-TABLE ttData NO-UNDO
  FIELD iPos AS INTEGER
  FIELD iVal AS INTEGER
  INDEX iPrim iPos.

FUNCTION getElement RETURNS INTEGER(piElement AS INTEGER):
  DEFINE BUFFER bData FOR ttData.
  FIND bData WHERE bData.iPos = piElement NO-ERROR. 
  IF NOT AVAILABLE bData THEN 
    MESSAGE piElement VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  RETURN bData.iVal.
END FUNCTION. 

FUNCTION setElement RETURNS LOGICAL(piElement AS INTEGER, piValue AS INTEGER):
  DEFINE BUFFER bData FOR ttData.
  FIND bData WHERE bData.iPos = piElement NO-ERROR. 
  IF NOT AVAILABLE bData THEN CREATE bData.
  ASSIGN bData.iPos = piElement bData.iVal = piValue.
  RETURN TRUE.
END FUNCTION. 

FUNCTION getString RETURNS CHARACTER():
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE BUFFER bData FOR ttData.
  FOR EACH bData: c = SUBSTITUTE('&1,&2', c, bData.iVal). END.
  RETURN TRIM(c,',').
END FUNCTION. 

COPY-LOB FILE "2019-02.dat" TO cData.
DO i = 1 TO NUM-ENTRIES(cData):
  setElement(i - 1, INTEGER(ENTRY(i,cData))).
END.

setElement(1,12).
setElement(2,2).

i = 0.
REPEAT:
  iOpCode = getElement(i).
  IF iOpCode = 99 THEN DO:
    MESSAGE getElement(0) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.
  END.

  iRegOne = getElement(getElement(i + 1)).
  iRegTwo = getElement(getElement(i + 2)).
  iTarget = getElement(i + 3).

  CASE iOpCode:
    WHEN 1 THEN setElement(iTarget, iRegOne + iRegTwo).
    WHEN 2 THEN setElement(iTarget, iRegOne * iRegTwo).
  END CASE.

  i = i + 4.
END.


/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 10566835                    */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */
