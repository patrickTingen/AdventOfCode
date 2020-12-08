/* AoC 2020 day 8
*/
DEFINE TEMP-TABLE ttCode NO-UNDO
  FIELD iLn  AS INTEGER
  FIELD cOpr AS CHARACTER 
  FIELD cPar AS CHARACTER 
  INDEX iPrim iLn.

DEFINE TEMP-TABLE ttHist NO-UNDO
  FIELD iVal AS INTEGER
  INDEX iPrim iVal.

DEFINE VARIABLE iLine  AS INTEGER NO-UNDO.
DEFINE VARIABLE iAccum AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPtr   AS INTEGER NO-UNDO INITIAL 1.

INPUT FROM day-08t.dat.
REPEAT:
  iLine = iLine + 1.
  CREATE ttCode. 
  ttCode.iLn = iLine.
  IMPORT ttCode.cOpr ttCode.cPar.
END.
INPUT CLOSE. 

REPEAT:
  FIND ttCode WHERE ttCode.iLn = iPtr NO-ERROR.
  IF NOT AVAILABLE ttCode THEN LEAVE. 

  IF CAN-FIND(ttHist WHERE ttHist.iVal = iPtr) THEN 
  DO:
    MESSAGE iAccum VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.
  END.
  
  CREATE ttHist.
  ASSIGN ttHist.iVal = iPtr.

  CASE ttCode.cOpr:
    WHEN 'nop' THEN DO:
      iPtr = iPtr + 1.
    END.

    WHEN 'acc' THEN 
    DO:
      iAccum = iAccum + INTEGER(ttCode.cPar).
      iPtr = iPtr + 1.
    END.

    WHEN 'jmp' THEN
    DO:
      iPtr = iPtr + INTEGER(ttCode.cPar).
    END.

  END CASE.
END.
