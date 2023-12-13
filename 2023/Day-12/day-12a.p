/* AoC 2023 day 12a 
 */ 
FUNCTION getGroups RETURNS CHARACTER (pcString AS CHARACTER):
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.

  IF INDEX(pcString,"?") > 0 THEN RETURN "".
  DO i = 1 TO NUM-ENTRIES(pcString,"."):
    j = LENGTH(ENTRY(i,pcString,".")).
    IF j > 0 THEN c = SUBSTITUTE('&1,&2', c, j).
  END.

  RETURN TRIM(c,",").
END FUNCTION.

DEFINE VARIABLE cSprings AS CHARACTER NO-UNDO.
DEFINE VARIABLE cGroups  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iCount   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLine    AS INTEGER   NO-UNDO.

INPUT FROM "data.txt".
REPEAT:
  IMPORT cSprings cGroups.

  HIDE MESSAGE NO-PAUSE.
  iLine = iLine + 1.
  MESSAGE iLine ":" cSprings.
  PROCESS EVENTS.

  RUN findConditions(cSprings, cGroups, OUTPUT iCount).
  iAnswer = iAnswer + iCount.
END.
MESSAGE iAnswer VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


PROCEDURE findConditions:
  DEFINE INPUT PARAMETER pcString AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcMask   AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER piCount AS INTEGER   NO-UNDO.

  DEFINE VARIABLE iCount AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i      AS INTEGER   NO-UNDO.

  IF getGroups(pcString) = pcMask THEN 
  DO:
    piCount = 1.
    RETURN. 
  END.

  i = INDEX(pcString,"?").
  IF i > 0 THEN 
  DO:
    OVERLAY(pcString,i,1) = "#".
    RUN findConditions(pcString, pcMask, OUTPUT iCount).
    piCount = piCount + iCount.

    OVERLAY(pcString,i,1) = ".".
    RUN findConditions(pcString, pcMask, OUTPUT iCount).
    piCount = piCount + iCount.
  END.

END PROCEDURE. 
