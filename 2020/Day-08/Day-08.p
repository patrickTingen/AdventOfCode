/* AoC 2020 day 8 (alternative solution)
*/
DEFINE VARIABLE cCmd AS CHARACTER NO-UNDO EXTENT 1000.
DEFINE VARIABLE iArg AS INTEGER   NO-UNDO EXTENT 1000.
DEFINE VARIABLE lUse AS LOGICAL   NO-UNDO EXTENT 1000.
DEFINE VARIABLE iVal AS INTEGER   NO-UNDO.
DEFINE VARIABLE i    AS INTEGER   NO-UNDO.
DEFINE VARIABLE lOk  AS LOGICAL   NO-UNDO.

INPUT FROM VALUE("c:\Temp\input.txt").
REPEAT:
  i = i + 1.
  IMPORT cCmd[i] iArg[i].
END.
INPUT CLOSE.

RUN intCode(cCmd, iArg, lUse, OUTPUT iVal, OUTPUT lOk).
MESSAGE 'Part 1:' iVal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

DO i = 1 TO EXTENT(cCmd):
  IF cCmd[i] = 'nop' OR cCmd[i] = 'jmp' THEN 
  DO:
    cCmd[i] = (IF cCmd[i] = 'nop' THEN 'jmp' ELSE 'nop').
    RUN intCode(cCmd, iArg, lUse, OUTPUT iVal, OUTPUT lOk).
    IF lOk THEN DO:
      MESSAGE 'part 2:' iVal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      STOP.
    END.
    cCmd[i] = (IF cCmd[i] = 'nop' THEN 'jmp' ELSE 'nop').
  END.
END.

PROCEDURE intCode:
  DEFINE INPUT  PARAMETER pcCmd AS CHARACTER NO-UNDO EXTENT.
  DEFINE INPUT  PARAMETER piArg AS INTEGER   NO-UNDO EXTENT.
  DEFINE INPUT  PARAMETER plUse AS LOGICAL   NO-UNDO EXTENT.
  DEFINE OUTPUT PARAMETER piVal AS INTEGER   NO-UNDO.
  DEFINE OUTPUT PARAMETER plOk  AS LOGICAL   NO-UNDO.

  DEFINE VARIABLE i AS INTEGER NO-UNDO INITIAL 1.

  REPEAT:
    IF i > EXTENT(pcCmd) OR pcCmd[i] = '' THEN LEAVE.
    IF plUse[i] THEN RETURN.
    plUse[i] = TRUE.
    CASE pcCmd[i]:
      WHEN "acc" THEN ASSIGN piVal = piVal + piArg[i] i = i + 1.
      WHEN "nop" THEN ASSIGN i = i + 1.
      WHEN "jmp" THEN ASSIGN i = i + piArg[i].
    END CASE.
  END.

  plOk = TRUE.
END PROCEDURE.
