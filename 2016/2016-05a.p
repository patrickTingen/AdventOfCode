/* Advent Of Code 2016, day 5, part 1 */

DEFINE VARIABLE cPassword AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iIndex    AS INTEGER     NO-UNDO.
DEFINE VARIABLE cHex      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE tStart    AS INTEGER     NO-UNDO.

PAUSE 0 BEFORE-HIDE. 
tStart = TIME.

PROCEDURE show:
  DISPLAY iIndex cPassword WITH FRAME f.
  PROCESS EVENTS.
  ETIME(YES).
END. 

DO WHILE TRUE:
  cHex = STRING(HEX-ENCODE(MD5-DIGEST('ugkcyxxp' + STRING(iIndex)))).
  IF cHex BEGINS '00000' THEN 
  DO:
    cPassword = cPassword + SUBSTRING(cHex,6,1).
    IF LENGTH(cPassword) = 8 THEN LEAVE.
  END.
  iIndex = iIndex + 1.

  IF ETIME > 1000 THEN RUN show.
END.

RUN show.
MESSAGE cPassword VIEW-AS ALERT-BOX INFO BUTTONS OK.
