/* AoC 2025 day 05b-2 (fast solution)
 */ 
DEFINE TEMP-TABLE ttRange NO-UNDO
 FIELD iFrom AS INT64
 FIELD iTo   AS INT64
 INDEX iPrim IS PRIMARY iFrom iTo.

DEFINE TEMP-TABLE ttMerged LIKE ttRange.

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iFresh   AS INT64     NO-UNDO.
DEFINE VARIABLE iCurFrom AS INT64     NO-UNDO.
DEFINE VARIABLE iCurTo   AS INT64     NO-UNDO.

ETIME(YES).

// read fresh ranges
INPUT FROM "data.txt".
REPEAT:

  IMPORT UNFORMATTED cLine.
  cLine = TRIM(cLine).
  IF cLine = "" THEN LEAVE.

  CREATE ttRange.
  ASSIGN
    ttRange.iFrom = INT64(ENTRY(1,cLine,"-"))
    ttRange.iTo   = INT64(ENTRY(2,cLine,"-")).
END.
INPUT CLOSE.

// Sort & merge ranges
FOR EACH ttRange:

  IF iCurFrom = 0 AND iCurTo = 0 THEN 
  DO:
    ASSIGN
      iCurFrom = ttRange.iFrom
      iCurTo   = ttRange.iTo.
    NEXT.
  END.

  // Merge or extend
  IF ttRange.iFrom <= iCurTo + 1 THEN 
  DO:
    IF ttRange.iTo > iCurTo THEN
      iCurTo = ttRange.iTo.
  END.

  ELSE 
  DO:
    // Keep current interval
    CREATE ttMerged.
    ASSIGN
      ttMerged.iFrom = iCurFrom
      ttMerged.iTo   = iCurTo.

    // Start new interval 
    ASSIGN
      iCurFrom = ttRange.iFrom
      iCurTo   = ttRange.iTo.
  END.
END.

// Last interval
IF iCurFrom <> 0 OR iCurTo <> 0 THEN 
DO:
  CREATE ttMerged.
  ASSIGN
    ttMerged.iFrom = iCurFrom
    ttMerged.iTo   = iCurTo.
END.

FOR EACH ttMerged:
  iFresh = iFresh + (ttMerged.iTo - ttMerged.iFrom + 1).
END.

MESSAGE iFresh "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFO.
    
// ---------------------------
// Information 
// ---------------------------
// 367899984917516 in 2 ms
// ---------------------------
