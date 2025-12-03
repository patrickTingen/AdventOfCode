/* AoC 2025 day 03a + b
** 
** Version with extent as stack
*/ 
FUNCTION getMaxJoltage RETURNS CHARACTER
  ( pcBank  AS CHARACTER
  , piCells AS INTEGER):

  DEFINE VARIABLE cStack  AS CHARACTER EXTENT NO-UNDO.
  DEFINE VARIABLE iSize   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iBank   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cResult AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cCell   AS CHARACTER NO-UNDO.

  iBank = LENGTH(pcBank).
  EXTENT(cStack) = iBank.

  // Build the stack
  DO i = 1 TO iBank:

    cCell = SUBSTRING(pcBank, i, 1).

    // Decrease the stack for lower values
    DO WHILE iSize > 0 
         AND cStack[iSize] < cCell 
         AND (iSize + iBank - i) >= piCells:

      cStack[iSize] = "".
      iSize = iSize - 1.
    END.

    // Push onto stack
    IF iSize < piCells THEN
      ASSIGN 
        iSize         = iSize + 1
        cStack[iSize] = cCell.
  END.

  // Build result
  DO i = 1 TO piCells:
    cResult = cResult + cStack[i].
  END.

  RETURN cResult.
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

in 124 ms
---------------------------
*/
