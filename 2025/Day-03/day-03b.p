/* AoC 2025 day 03a + b
** 
** Version with string manipulation
*/ 
FUNCTION getMaxJoltage RETURNS CHARACTER
  ( pcBank  AS CHARACTER
  , piCells AS INTEGER):

  DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iBank   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cResult AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cCell   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iResult AS INTEGER   NO-UNDO.

  iBank = LENGTH(pcBank).

  // Build the stack
  DO i = 1 TO iBank:

    cCell = SUBSTRING(pcBank, i, 1).

    // Decrease the stack for lower values
    DO WHILE iResult > 0
         AND SUBSTRING(cResult,iResult,1) < cCell
         AND (iResult + iBank - i) >= piCells:

      iResult = iResult - 1.
      cResult = SUBSTRING(cResult,1,iResult). // pop last char
    END.

    // Add to combination
    IF LENGTH(cResult) < piCells THEN 
      ASSIGN 
        cResult = cResult + cCell
        iResult = iResult + 1.
  END.

  RETURN SUBSTRING(cResult,1,12).
END FUNCTION. // getMaxJoltage


// Main
DEFINE VARIABLE iTotal AS INT64     NO-UNDO EXTENT 2.
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".
REPEAT:
  IMPORT cLine.

  // Part 1: 2 cells 
  iTotal[1] = iTotal[1] + DECIMAL(getMaxJoltage(cLine, 2)).

  // Part 2: 12 cells
  iTotal[2] = iTotal[2] + DECIMAL(getMaxJoltage(cLine, 12)).

END.

MESSAGE 
  "Part 1:" iTotal[1] SKIP
  "Part 2:" iTotal[2] SKIP(1) 
  "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Information 
---------------------------
Part 1: 17311 
Part 2: 171419245422055 

in 110 ms
---------------------------
*/

