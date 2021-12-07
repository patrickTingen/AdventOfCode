/* AoC 2021 day 06a
 */ 
DEFINE TEMP-TABLE ttFish NO-UNDO
  FIELD iTimer   AS INT64
  FIELD iNumFish AS INT64
  INDEX iPrim iTimer.

DEFINE VARIABLE cData   AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i       AS INT64    NO-UNDO.
DEFINE VARIABLE j       AS INT64    NO-UNDO.
DEFINE VARIABLE iCount  AS INT64    NO-UNDO.

DEFINE BUFFER bFish FOR ttFish. 

DO i = -1 TO 8:
  CREATE ttFish.
  ASSIGN ttFish.iTimer = i.
END.

COPY-LOB FILE "c:\Data\DropBox\AdventOfCode\2021\Day-06\data.txt" TO cData.
DO i = 1 TO NUM-ENTRIES(cData):
  j = INT64(ENTRY(i,cData)).
  FIND ttFish WHERE ttFish.iTimer = j.
  ttFish.iNumFish = ttFish.iNumFish + 1.
END.

DO i = 1 TO 256:
  
  FOR EACH ttFish WHERE ttFish.iTimer >= 0:
    FIND bFish WHERE bFish.iTimer = ttFish.iTimer - 1 NO-ERROR.
    IF NOT AVAILABLE bFish THEN FIND bFish WHERE bFish.iTimer = 8.
    
    bFish.iNumFish = bFish.iNumFish + ttFish.iNumFish.
    ttFish.iNumFish = 0.
  END.

  /* New fish */
  FOR EACH ttFish WHERE ttFish.iTimer = -1:
    FIND bFish WHERE bFish.iTimer = 8.
    bFish.iNumFish = bFish.iNumFish + ttFish.iNumFish.

    FIND bFish WHERE bFish.iTimer = 6.
    bFish.iNumFish = bFish.iNumFish + ttFish.iNumFish.

    ttFish.iNumFish = 0.
  END.
END.

FOR EACH ttFish:
  iCount = iCount + ttFish.iNumFish.
END.

MESSAGE iCount VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
/* 1595779846729 */    

