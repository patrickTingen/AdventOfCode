/* Advent Of Code 2016, day 5, part 2 */

DEFINE VARIABLE cPassword AS CHARACTER   NO-UNDO EXTENT 8.
DEFINE VARIABLE iIndex    AS INTEGER     NO-UNDO INITIAL -1.
DEFINE VARIABLE cHex      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE tStart    AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPos      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iFilled   AS INTEGER     NO-UNDO.

PAUSE 0 BEFORE-HIDE. 
tStart = TIME.

PROCEDURE show:
  DISPLAY iIndex cPassword WITH FRAME f 1 COLUMN.
  PROCESS EVENTS.
  ETIME(YES).
END. 

DO WHILE TRUE:

  iIndex = iIndex + 1.
  cHex = STRING(HEX-ENCODE(MD5-DIGEST('ugkcyxxp' + STRING(iIndex)))).
  
  IF cHex BEGINS '00000' THEN 
  DO:
    iPos = INTEGER(SUBSTRING(cHex,6,1)) + 1 NO-ERROR.
    IF ERROR-STATUS:ERROR THEN NEXT. 
    IF iPos > 8 THEN NEXT. 
    IF cPassword[iPos] <> '' THEN NEXT.

    cPassword[iPos] = SUBSTRING(cHex,7,1).
    iFilled = iFilled + 1.
    IF iFilled = 8 THEN LEAVE.
  END.

  IF ETIME > 1000 THEN RUN show.
END.

RUN show.
MESSAGE cPassword[1] + cPassword[2] + cPassword[3] + cPassword[4] + 
        cPassword[5] + cPassword[6] + cPassword[7] + cPassword[8] 
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

