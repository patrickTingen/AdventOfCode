/* AoC 2025 day 05b-1 
** 
** Note: takes way too much time :)
*/ 
DEFINE VARIABLE iFresh AS INT64   NO-UNDO.
DEFINE VARIABLE iId    AS INT64   NO-UNDO.
DEFINE VARIABLE iLo    AS INT64   NO-UNDO INITIAL ?.
DEFINE VARIABLE iHi    AS INT64   NO-UNDO INITIAL ?.
DEFINE VARIABLE iTodo  AS INT64   NO-UNDO.
DEFINE VARIABLE iDone  AS INT64   NO-UNDO.
DEFINE VARIABLE iStart AS INTEGER NO-UNDO.
DEFINE VARIABLE dDone  AS DECIMAL NO-UNDO.
DEFINE VARIABLE iLeft  AS INT64   NO-UNDO.

DEFINE TEMP-TABLE ttRange
  FIELD iFrom AS INT64
  FIELD iTo   AS INT64
  INDEX iPrim AS PRIMARY iFrom iTo.

INPUT FROM "data.txt".

REPEAT:
  CREATE ttRange.
  IMPORT DELIMITER "-" ttRange.iFrom ttRange.iTo.
  IF ttRange.iFrom = 0 AND ttRange.iTo = 0 THEN UNDO, LEAVE.
  IF iLo = ? OR ttRange.iFrom < iLo THEN iLo = ttRange.iFrom.
  IF iHi = ? OR ttRange.iTo   > iHi THEN iHi = ttRange.iTo.
END.
INPUT CLOSE.

iStart = TIME.

DO iId = iLo TO iHi:
  IF CAN-FIND(FIRST ttRange 
              WHERE ttRange.iFrom <= iId 
                AND ttRange.iTo >= iId) THEN iFresh = iFresh + 1.

  IF ETIME > 1000 THEN
  DO:
    HIDE MESSAGE NO-PAUSE.
    iTodo = (iHi - iLo).
    iDone = (iId - iLo).
    dDone = (iDone / iTodo).
    iLeft = INT64((TIME - iStart) / dDone).

    MESSAGE "From:" iLo "To:" iHi "Done:" (iId - iLo) " = " (dDone * 100) "%".
    MESSAGE "ETA:" STRING(ADD-INTERVAL(NOW,iLeft,"SECONDS"),"99-99-9999 HH:MM").

    ETIME(YES).
    PROCESS EVENTS.
  END.
END.

MESSAGE iFresh
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
