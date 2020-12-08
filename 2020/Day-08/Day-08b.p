/* AoC 2020 day 8
*/
{ttIntCode.i}

DEFINE VARIABLE iAccum AS INTEGER  NO-UNDO.
DEFINE VARIABLE iLine  AS INTEGER  NO-UNDO.
DEFINE VARIABLE lOk    AS LOGICAL  NO-UNDO.
DEFINE VARIABLE cData  AS LONGCHAR NO-UNDO.

DEFINE TEMP-TABLE ttRepl LIKE ttCode.

INPUT FROM day-08.dat.
REPEAT:
  iLine = iLine + 1.
  CREATE ttCode.
  ttCode.iLn = iLine.
  IMPORT ttCode.cOpr ttCode.cPar.

  IF ttCode.cOpr = 'nop' OR ttCode.cOpr = 'jmp' THEN
  DO:
    CREATE ttRepl.
    BUFFER-COPY ttCode TO ttRepl.
  END.
END.
INPUT CLOSE.

FOR EACH ttCode WHERE ttCode.cOpr = '': 
  DELETE ttCode.
END.

FOR EACH ttRepl:
  FIND ttCode WHERE ttCode.iLn = ttRepl.iLn.
  ttCode.cOpr = (IF ttCode.cOpr = 'nop' THEN 'jmp' ELSE 'nop').

  RUN intCode.p(TABLE ttCode, OUTPUT iAccum, OUTPUT lOk).
  IF lOk THEN MESSAGE iAccum VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

  ttCode.cOpr = (IF ttCode.cOpr = 'nop' THEN 'jmp' ELSE 'nop').
END.


