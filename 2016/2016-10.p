/* Advent Of Code, day 10, part 1 & 2 */

INPUT FROM "d:\Data\Dropbox\AdventOfCode\2016-10-input.txt".

DEFINE TEMP-TABLE ttBot
  FIELD iBotnr  AS INTEGER 
  FIELD iLow  AS INTEGER INITIAL ?
  FIELD iHi  AS INTEGER INITIAL ?
  FIELD botLo   AS INTEGER INITIAL ?
  FIELD botHi   AS INTEGER INITIAL ?
  FIELD outLow  AS INTEGER INITIAL ?
  FIELD outHi   AS INTEGER INITIAL ?
  FIELD lFull   AS LOGICAL 
  INDEX iPrim lFull
  INDEX iNr iBotnr
  .
  
DEFINE TEMP-TABLE ttOut
  FIELD iOutnr AS INTEGER 
  FIELD iChip  AS INTEGER INITIAL ?
  .

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.

DEFINE BUFFER bfBotHi FOR ttBot.
DEFINE BUFFER bfBotLo FOR ttBot.
DEFINE BUFFER bfOutLo FOR ttOut.
DEFINE BUFFER bfOutHi FOR ttOut.

PROCEDURE getBot:
  DEFINE INPUT PARAMETER botnr AS INTEGER NO-UNDO.
  DEFINE PARAMETER BUFFER bfBot FOR ttBot. 
  FIND bfBot WHERE bfBot.iBotnr = botnr NO-ERROR.
  IF NOT AVAILABLE bfBot THEN DO: CREATE bfBot. bfBot.iBotnr = botnr. END.
END. 
  
PROCEDURE getOut:
  DEFINE INPUT PARAMETER outnr AS INTEGER NO-UNDO.
  DEFINE PARAMETER BUFFER bfOut FOR ttOut. 
  FIND bfOut WHERE bfOut.iOutnr = outnr NO-ERROR.
  IF NOT AVAILABLE bfOut THEN DO: CREATE bfOut. bfOut.iOutnr = outnr. END.
END. 

PROCEDURE giveBot:
  DEFINE INPUT PARAMETER botnr AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER chip AS INTEGER NO-UNDO.
  
  DEFINE BUFFER bfBot FOR ttBot.
  FIND bfBot WHERE bfBot.iBotnr = botnr NO-ERROR.
  IF NOT AVAILABLE bfBot THEN DO: CREATE bfBot. bfBot.iBotnr = botnr. END.
  
  IF bfBot.iLow = ? THEN bfBot.iLow = chip. ELSE bfBot.iHi = chip.
  /* swap when needed */
  IF bfBot.iLow > bfBot.iHi THEN DO:
    chip = bfBot.iLow.
    bfBot.iLow = bfBot.iHi.
    bfBot.iHi = chip.
  END. 
    
  bfBot.lFull = (bfBot.iLow <> ? AND bfBot.iHi <> ?). 
END.

PROCEDURE giveOut:
  DEFINE INPUT PARAMETER outnr AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER chip AS INTEGER NO-UNDO.
  
  DEFINE BUFFER bfOut FOR ttOut.
  FIND bfOut WHERE bfOut.iOutnr = Outnr NO-ERROR.
  IF NOT AVAILABLE bfOut THEN CREATE bfOut. bfOut.iOutnr = Outnr.
END.

/* Create the outputs */
DEFINE VARIABLE i AS INTEGER NO-UNDO.
DO i = 1 TO 20:
  CREATE ttOut. ttOut.iOutnr = i.
END.

REPEAT :
  IMPORT UNFORMATTED cLine.
  
  IF cLine MATCHES 'value * goes to bot *' THEN DO:
    RUN getBot(INTEGER(ENTRY(6,cLine,' ')), BUFFER ttBot).
    RUN giveBot(INTEGER(ENTRY(6,cLine,' ')),INTEGER(ENTRY(2,cLine,' '))).
  END. 

  IF cLine MATCHES 'bot * gives low to bot * and high to bot *' THEN DO: 
    RUN getBot(INTEGER(ENTRY(7,cLine,' ')), BUFFER ttBot).
    RUN getBot(INTEGER(ENTRY(12,cLine,' ')), BUFFER ttBot).
    
    RUN getBot(INTEGER(ENTRY(2,cLine,' ')), BUFFER ttBot).
    ttBot.botLo = INTEGER(ENTRY(7,cLine,' ')).
    ttBot.botHi = INTEGER(ENTRY(12,cLine,' ')).
  END.

  IF cLine MATCHES 'bot * gives low to output * and high to bot *' THEN DO:  
    RUN getOut(INTEGER(ENTRY(7,cLine,' ')), BUFFER ttOut).
    RUN getBot(INTEGER(ENTRY(12,cLine,' ')), BUFFER ttBot).
    
    RUN getBot(INTEGER(ENTRY(2,cLine,' ')), BUFFER ttBot).
    ttBot.outLow = INTEGER(ENTRY(7,cLine,' ')). 
    ttBot.botHi  = INTEGER(ENTRY(12,cLine,' ')).
  END.

  IF cLine MATCHES 'bot * gives low to output * and high to output *' THEN DO: 
    RUN getOut(INTEGER(ENTRY(7,cLine,' ')), BUFFER ttOut).
    RUN getOut(INTEGER(ENTRY(12,cLine,' ')), BUFFER ttOut).
    
    RUN getBot(INTEGER(ENTRY(2,cLine,' ')), BUFFER ttBot).
    ttBot.outLow = INTEGER(ENTRY(7,cLine,' ')). 
    ttBot.outHi  = INTEGER(ENTRY(12,cLine,' ')).
  END.
END.

PAUSE 0 BEFORE-HIDE. 
DEFINE BUFFER bfBot FOR ttBot.

OUTPUT TO c:\temp\bots.txt.
FOR EACH ttBot. DISPLAY ttBot WITH STREAM-IO WIDTH 120.
END.
OUTPUT CLOSE.
 
REPEAT:

  FOR EACH ttBot WHERE ttBot.lFull = TRUE:
    
    RELEASE bfBotLo.
    RELEASE bfBotHi.
    RELEASE bfOutLo.
    RELEASE bfOutHi.
    
    IF ttBot.botLo <> ? THEN FIND bfBotLo WHERE bfBotLo.iBotnr = ttBot.botLo NO-ERROR.
    IF ttBot.botHi <> ? THEN FIND bfBotHi WHERE bfBotHi.iBotnr = ttBot.botHi NO-ERROR.
    IF ttBot.outLo <> ? THEN FIND bfOutLo WHERE bfOutLo.iOutNr = ttBot.outLo NO-ERROR.
    IF ttBot.outHi <> ? THEN FIND bfOutHi WHERE bfOutHi.iOutNr = ttBot.outHi NO-ERROR.
    
    /* low to bot a and high to bot b */
    IF    AVAILABLE bfBotLo AND NOT bfBotLo.lFull 
      AND AVAILABLE bfBotHi AND NOT bfBotHi.lFull THEN 
    DO:
      RUN giveBot(ttBot.botLo, ttBot.iLow ).
      RUN giveBot(ttBot.botHi, ttBot.iHi ).
      
      ttBot.iLow  = ?.
      ttBot.iHi   = ?.
      ttBot.lFull = NO. 
    END.
      
    /* low to output a and high to bot b */
    IF    AVAILABLE bfOutLo 
      AND AVAILABLE bfBotHi AND NOT bfBotHi.lFull THEN 
    DO:
      bfOutLo.iChip = ttBot.iLow.
      RUN giveOut(ttBot.outLo, ttBot.iLow ).
      RUN giveBot(ttBot.botHi, ttBot.iHi ).
      
      ttBot.iLow  = ?. 
      ttBot.iHi   = ?.
      ttBot.lFull = NO. 
    END.
    
    /* low to output a and high to output b */
    IF    AVAILABLE bfOutLo 
      AND AVAILABLE bfOutHi  THEN 
    DO:
      bfOutLo.iChip = ttBot.iLow.
      bfOutHi.iChip = ttBot.iHi.
      
      ttBot.iLow  = ?. 
      ttBot.iHi   = ?.
      ttBot.lFull = NO. 
    END.

    /* Part 1 */                                                        
/*     FOR EACH bfBot:                                  */
/*       IF bfBot.iLow = 17 AND bfBot.iHi = 61 THEN DO: */
/*         MESSAGE bfBot.iBotnr VIEW-AS ALERT-BOX.      */
/*         STOP.                                        */
/*       END.                                           */
/*     END.                                             */

  END.

  IF NOT CAN-FIND(FIRST ttBot WHERE ttBot.lFull = TRUE) THEN LEAVE. 
END.
         
/* Part 2 */
OUTPUT TO c:\temp\outputs.txt.
FOR EACH ttOut BY ttOut.iOut:
  EXPORT ttOut.
END.  
OUTPUT CLOSE. 
  
