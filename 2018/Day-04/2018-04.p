/* Advent of code 2018
** day 4
*/
DEFINE TEMP-TABLE ttEvent
  FIELD cDate   AS CHARACTER 
  FIELD cTime   AS CHARACTER
  FIELD iMinute AS INTEGER
  FIELD cDesc   AS CHARACTER
  INDEX iPrim cDate cTime.

DEFINE TEMP-TABLE ttGuard
  FIELD iId    AS INTEGER
  FIELD iSleep AS INTEGER
  INDEX iPrim iId.
  
DEFINE TEMP-TABLE ttSleep
  FIELD iId     AS INTEGER
  FIELD iMinute AS INTEGER
  FIELD iTotal  AS INTEGER.

DEFINE VARIABLE cData    AS CHARACTER NO-UNDO.  
DEFINE VARIABLE iGuardId AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStart   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
/*
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
*/
INPUT FROM "2018-04-test.dat".
REPEAT:
  IMPORT UNFORMATTED cData.
  CREATE ttEvent.
  ASSIGN 
    ttEvent.cDate   = SUBSTRING(cData,2,10)
    ttEvent.cTime   = SUBSTRING(cData,13,5)
    ttEvent.iMinute = INTEGER(ENTRY(2,ttEvent.cTime,':'))
    ttEvent.cDesc   = SUBSTRING(cData,20).
END. 

FOR EACH ttEvent:
  IF ttEvent.cDesc MATCHES 'Guard #* begins shift' THEN
    iGuardId = INTEGER(ENTRY(1,ENTRY(2,ttEvent.cDesc,'#'),' ')).

  IF ttEvent.cDesc = 'falls asleep' THEN
    iStart = ttEvent.iMinute.
    
  IF ttEvent.cDesc = 'wakes up' THEN
  DO:
    FIND ttGuard WHERE ttGuard.iId = iGuardId NO-ERROR.
    IF NOT AVAILABLE ttGuard THEN CREATE ttGuard.  
    ttGuard.iId = iGuardId.
    ttGuard.iSleep = ttGuard.iSleep + (ttEvent.iMinute - iStart).
    
    DO i = iStart TO ttEvent.iMinute - 1:
      FIND ttSleep WHERE ttSleep.iId = iGuardId AND ttSleep.iMinute = i NO-ERROR.
      IF NOT AVAILABLE ttSleep THEN CREATE ttSleep.
      ASSIGN ttSleep.iId = iGuardId ttSleep.iMinute = i ttSleep.iTotal = ttSleep.iTotal + 1.
    END.
  END.
END.

#Part1:
FOR EACH ttGuard BY ttGuard.iSleep DESCENDING:
  FOR EACH ttSleep WHERE ttSleep.iId = ttGuard.iId BY ttSleep.iTotal DESCENDING:
    MESSAGE 'Part 1: Guard:' ttGuard.iId 'Minute nr:' ttSleep.iMinute SKIP 
            'Answer:' ttGuard.iId * ttSleep.iMinute VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE #Part1.
  END.
END.

#Part2:
FOR EACH ttSleep BY ttSleep.iTotal DESCENDING:
  MESSAGE 'Part 2: Guard:' ttSleep.iId 'Minute nr:' ttSleep.iMinute SKIP
          'Answer:' ttSleep.iId * ttSleep.iMinute VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  LEAVE #Part2.
END.

/* Test: 
   Part 1: Guard: 10 Minute nr: 24 Answer: 240
   Part 2: Guard: 99 Minute nr: 45 Answer: 4455
*/
