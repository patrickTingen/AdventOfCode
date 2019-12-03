/* Advent of code 2019
** day 2a
*/

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

FUNCTION readData RETURNS LOGICAL(pcFile AS CHARACTER):
  DEFINE VARIABLE cData AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER  NO-UNDO.

  COPY-LOB FILE pcFile TO cData.
  EMPTY TEMP-TABLE ttData. 
  DO i = 1 TO NUM-ENTRIES(cData):
    setElement(i - 1, INTEGER(ENTRY(i,cData))).
  END.
END FUNCTION. 

FUNCTION getString RETURNS CHARACTER():
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE BUFFER bData FOR ttData.
  FOR EACH bData: c = SUBSTITUTE('&1,&2', c, bData.iVal). END.
  RETURN TRIM(c,',').
END FUNCTION. 

FUNCTION getOutput RETURNS INTEGER(piNoun AS INTEGER, piVerb AS INTEGER):

  DEFINE VARIABLE iPointer AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iOpCode  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRegOne  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRegTwo  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iTarget  AS INTEGER  NO-UNDO.

  HIDE MESSAGE NO-PAUSE.
  MESSAGE piNoun piVerb.
  PROCESS EVENTS. 

  setElement(1, piNoun).
  setElement(2, piVerb).

  REPEAT:
    iOpCode = getElement(iPointer).
    IF iOpCode = 99 THEN RETURN getElement(0).

    iRegOne = getElement(getElement(iPointer + 1)).
    iRegTwo = getElement(getElement(iPointer + 2)).
    iTarget = getElement(iPointer + 3).
  
    CASE iOpCode:
      WHEN 1 THEN setElement(iTarget, iRegOne + iRegTwo).
      WHEN 2 THEN setElement(iTarget, iRegOne * iRegTwo).
    END CASE.
  
    iPointer = iPointer + 4.
  END.
END FUNCTION. 

DEFINE VARIABLE iNoun AS INTEGER NO-UNDO.
DEFINE VARIABLE iVerb AS INTEGER NO-UNDO.

DO iNoun = 0 TO 99:
  DO iVerb = 0 TO 99:
    readData("c:\Data\DropBox\AdventOfCode\2019\Day-02\2019-02.dat").
    IF getOutput(iNoun, iVerb) = 19690720 THEN 
    DO:
      MESSAGE iNoun * 100 + iVerb VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      STOP.
    END.
  END.
END.


/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 2347                        */
/* --------------------------- */
/* OK   Help                   */
/* --------------------------- */
