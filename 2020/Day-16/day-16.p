/* AoC 2020 day 16
 */ 
DEFINE TEMP-TABLE ttRange NO-UNDO
  FIELD cName   AS CHARACTER 
  FIELD iFrom   AS INTEGER EXTENT 2
  FIELD iTo     AS INTEGER EXTENT 2
  FIELD cFields AS CHARACTER 
  FIELD lDone   AS LOGICAL
  .
DEFINE TEMP-TABLE ttTicket NO-UNDO
  FIELD cValues AS CHARACTER .

DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE j         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPart-1   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPart-2   AS INT64     NO-UNDO.
DEFINE VARIABLE cMyTicket AS CHARACTER NO-UNDO.
DEFINE VARIABLE cNr       AS CHARACTER NO-UNDO.

ETIME(YES).

INPUT FROM "input.txt".
REPEAT:
  IMPORT UNFORMATTED cLine. 
  IF cLine = '' THEN NEXT. 
  IF cLine = 'Your ticket:' THEN LEAVE. 
  CREATE ttRange.
  ASSIGN 
    ttRange.cName    = ENTRY(1,cLine,':')
    ttRange.iFrom[1] = INTEGER(ENTRY(1,ENTRY(LOOKUP('or', cLine,' ') - 1, cLine,' '),'-'))
    ttRange.iTo  [1] = INTEGER(ENTRY(2,ENTRY(LOOKUP('or', cLine,' ') - 1, cLine,' '),'-'))
    ttRange.iFrom[2] = INTEGER(ENTRY(1,ENTRY(LOOKUP('or', cLine,' ') + 1, cLine,' '),'-')) 
    ttRange.iTo  [2] = INTEGER(ENTRY(2,ENTRY(LOOKUP('or', cLine,' ') + 1, cLine,' '),'-')).
END.

IMPORT cMyTicket.
IMPORT ^.
IMPORT ^.

#Ticket:
REPEAT:
  IMPORT cLine.
  DO i = 1 TO NUM-ENTRIES(cLine):
    j = INTEGER(ENTRY(i,cLine)).
    IF NOT CAN-FIND(FIRST ttRange 
                    WHERE (   ttRange.iFrom[1] <= j AND ttRange.iTo[1] >= j
                           OR ttRange.iFrom[2] <= j AND ttRange.iTo[2] >= j )) THEN 
    DO:
      iPart-1 = iPart-1 + INTEGER(ENTRY(i,cLine)).
      NEXT #Ticket.
    END.
  END.

  CREATE ttTicket.
  ASSIGN ttTicket.cValues = cLine.
END.
INPUT CLOSE. 

CREATE ttTicket.
ttTicket.cValues = cMyTicket.

FOR EACH ttRange:
  
  #Range:
  DO i = 1 TO NUM-ENTRIES(cMyTicket):

    FOR EACH ttTicket:
      j = INTEGER(ENTRY(i,ttTicket.cValues)).
      IF NOT (   ttRange.iFrom[1] <= j AND ttRange.iTo[1] >= j
              OR ttRange.iFrom[2] <= j AND ttRange.iTo[2] >= j ) THEN NEXT #Range.
    END.

    ttRange.cFields = TRIM(SUBSTITUTE('&1,&2', ttRange.cFields, i),',').
  END.
END.

REPEAT:
  FIND FIRST ttRange WHERE NUM-ENTRIES(ttRange.cFields) = 1 AND ttRange.lDone = NO NO-ERROR.
  IF NOT AVAILABLE ttRange THEN LEAVE. 
  cNr = ttRange.cFields.
  ttRange.lDone = YES.
  
  FOR EACH ttRange WHERE NUM-ENTRIES(ttRange.cFields) > 1:
    IF LOOKUP(cNr, ttRange.cFields) = 0 THEN NEXT. 
    ENTRY(LOOKUP(cNr, ttRange.cFields), ttRange.cFields) = ''.
    ttRange.cFields = TRIM(REPLACE(ttRange.cFields,',,',','),',').
  END.
END.

iPart-2 = 1.
FOR EACH ttRange WHERE ttRange.cName BEGINS 'departure':
  iPart-2 = iPart-2 * INTEGER(ENTRY(INTEGER(ttRange.cFields), cMyTicket)).
END.

MESSAGE 'Part 1:' iPart-1 SKIP 
        'part 2:' iPart-2 SKIP 
        'Time  :' ETIME 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 26009               */
/* part 2: 589685618167        */
/* Time  : 179                 */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

