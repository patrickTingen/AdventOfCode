/* AoC 2025 day 05a 
 */ 
DEFINE VARIABLE iFresh AS INT64 NO-UNDO.
DEFINE VARIABLE iId    AS INT64 NO-UNDO.

DEFINE TEMP-TABLE ttRange
  FIELD iFrom AS INT64
  FIELD iTo   AS INT64
  INDEX iPrim IS PRIMARY iFrom iTo.

ETIME(YES).

INPUT FROM "data.txt".

// read fresh ranges
REPEAT:
  CREATE ttRange.
  IMPORT DELIMITER "-" ttRange.iFrom ttRange.iTo.
  IF ttRange.iFrom = 0 AND ttRange.iTo = 0 THEN UNDO, LEAVE.
END.

// read ingredients
REPEAT:
  IMPORT iId.
  IF CAN-FIND(FIRST ttRange 
              WHERE ttRange.iFrom <= iId 
                AND ttRange.iTo   >= iId) THEN iFresh = iFresh + 1.
END.
INPUT CLOSE.

MESSAGE iFresh "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


// ---------------------------
// Information 
// ---------------------------
// 601 in 34 ms
// ---------------------------
