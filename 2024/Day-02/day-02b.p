/* AoC 2024 day 02b
 */ 
FUNCTION stripReport RETURNS INTEGER EXTENT 10 
  ( piElement AS INTEGER
  , piReport  AS INTEGER EXTENT 10
  ):
  /* Remove element nr piElement from the extent
  */
  DEFINE VARIABLE iReport AS INTEGER NO-UNDO EXTENT 10.
  DEFINE VARIABLE i       AS INTEGER NO-UNDO.
  DEFINE VARIABLE j       AS INTEGER NO-UNDO.

  DO i = 1 TO 10:
    IF i = piElement THEN NEXT. 
    j = j + 1.
    iReport[j] = piReport[i].
    IF iReport[j] = ? THEN LEAVE.
  END.

  RETURN iReport.
END FUNCTION. 


FUNCTION reportSafe RETURNS LOGICAL 
  ( piReport AS INTEGER EXTENT 10 
  ):
  /* Check the report 
  */
  DEFINE VARIABLE i     AS INTEGER NO-UNDO.
  DEFINE VARIABLE lIncr AS LOGICAL NO-UNDO.
  DEFINE VARIABLE iDiff AS INTEGER   NO-UNDO.

  lIncr = (piReport[2] > piReport[1]).

  #Level:
  DO i = 1 TO 9:
    IF piReport[i + 1] = ? THEN LEAVE #Level.

    CASE lIncr:
      WHEN YES THEN IF piReport[i + 1] <= piReport[i] THEN RETURN NO.
      WHEN NO  THEN IF piReport[i + 1] >= piReport[i] THEN RETURN NO.
    END CASE.

    iDiff = ABS(piReport[i + 1] - piReport[i]).
    IF iDiff < 1 OR iDiff > 3 THEN RETURN NO. 
  END.

  RETURN YES.
END FUNCTION. 

/* Main 
*/
DEFINE VARIABLE iReport  AS INTEGER NO-UNDO EXTENT 10.
DEFINE VARIABLE iNumSafe AS INTEGER NO-UNDO.
DEFINE VARIABLE i        AS INTEGER NO-UNDO.

ETIME(YES).
INPUT FROM "c:\Data\DropBox\AdventOfCode\2024\Day-02\data.txt".

#Report:
REPEAT:
  iReport = ?.
  IMPORT iReport.

  DO i = 0 TO 10:
    IF reportSafe( stripReport(i, iReport)) THEN 
    DO:
      iNumSafe = iNumSafe + 1.
      NEXT #Report.
    END.
  END.

END.
INPUT CLOSE. 

MESSAGE iNumSafe ETIME "ms" /* 296 175 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
