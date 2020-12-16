/* AoC 2020 day 16 a
 */ 
DEFINE TEMP-TABLE ttRange NO-UNDO
  FIELD cName AS CHARACTER 
  FIELD iFrom AS INTEGER
  FIELD iTo   AS INTEGER
  .

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRate AS INTEGER   NO-UNDO.

INPUT FROM "input.txt".
REPEAT:
  IMPORT UNFORMATTED cLine. 
  IF cLine = 'Your ticket:' THEN LEAVE. 

  DO i = 1 TO NUM-ENTRIES(cLine,' '):
    IF ENTRY(i,cLine,' ') MATCHES '*-*' THEN 
    DO:
      CREATE ttRange.
      ASSIGN 
        ttRange.cName = ENTRY(1,cLine,':')
        ttRange.iFrom = INTEGER(ENTRY(1,ENTRY(i,cLine,' '),'-'))
        ttRange.iTo   = INTEGER(ENTRY(2,ENTRY(i,cLine,' '),'-')).
    END.
  END.
END.

IMPORT ^.
IMPORT ^.
IMPORT ^.

REPEAT:
  IMPORT cLine.
  DO i = 1 TO NUM-ENTRIES(cLine):
    IF NOT CAN-FIND(FIRST ttRange 
                    WHERE ttRange.iFrom <= INTEGER(ENTRY(i,cLine))
                      AND ttRange.iTo   >= INTEGER(ENTRY(i,cLine))) THEN iRate = iRate + INTEGER(ENTRY(i,cLine)).
  END.
END.
INPUT CLOSE. 

MESSAGE iRate VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 26009                       */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
/*                             */

