/* AoC 2020 day 8 
 * intCode computer
 */
{ttIntCode.i}

DEFINE INPUT PARAMETER TABLE FOR ttCode.
DEFINE OUTPUT PARAMETER piAccum  AS INTEGER NO-UNDO.
DEFINE OUTPUT PARAMETER plFinish AS LOGICAL NO-UNDO.

DEFINE VARIABLE iLine  AS INTEGER NO-UNDO.
DEFINE VARIABLE iPtr   AS INTEGER NO-UNDO INITIAL 1.

REPEAT:
  FIND ttCode WHERE ttCode.iLn = iPtr NO-ERROR.
  IF NOT AVAILABLE ttCode THEN LEAVE. 

  /* Infinite loop */
  IF CAN-FIND(ttHist WHERE ttHist.iVal = iPtr) THEN RETURN.
  
  CREATE ttHist.
  ASSIGN ttHist.iVal = iPtr.

  CASE ttCode.cOpr:
    WHEN 'nop' THEN DO:
      iPtr = iPtr + 1.
    END.

    WHEN 'acc' THEN 
    DO:
      piAccum = piAccum + INTEGER(ttCode.cPar).
      iPtr = iPtr + 1.
    END.

    WHEN 'jmp' THEN
    DO:
      iPtr = iPtr + INTEGER(ttCode.cPar).
    END.

  END CASE.
END.

plFinish = TRUE.
