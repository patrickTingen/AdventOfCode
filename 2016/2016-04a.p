/* Advent Of Code 2016, day 4, part 1 */

DEFINE TEMP-TABLE ttChar NO-UNDO
  FIELD cChar  AS CHARACTER
  FIELD iCount AS INTEGER
  .

DEFINE VARIABLE cRawName   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cName      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSector    AS INTEGER     NO-UNDO.
DEFINE VARIABLE cCheckSum  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE ii         AS INTEGER     NO-UNDO.
DEFINE VARIABLE cCalcSum   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSectorSum AS INTEGER     NO-UNDO.

INPUT FROM d:\Data\DropBox\AdventOfCode\2016-04-INPUT.txt.

REPEAT:

  /* laffe-igtje-gtgreyoy-124[uscwl] */
  IMPORT cRawName.

  cName     = cRawName.
  cCheckSum = ENTRY(NUM-ENTRIES(cName,'-'),cName,'-'). /* 124[uscwl] */
  cName     = SUBSTRING(cName,1,R-INDEX(cName,'-')).   /* laffe-igtje-gtgreyoy */
  cName     = REPLACE(cName,'-','').                   /* laffeigtjegtgreyoy */
  iSector   = INTEGER(ENTRY(1,cCheckSum,'[')).         /* 124 */
  cCheckSum = TRIM(ENTRY(2,cCheckSum,'['),']').        /* uscwl */

  EMPTY TEMP-TABLE ttChar.
  DO ii = 1 TO LENGTH(cName):
    FIND ttChar WHERE ttChar.cChar = SUBSTRING(cName,ii,1) NO-ERROR.
    IF NOT AVAILABLE ttChar THEN CREATE ttChar.
    ASSIGN 
      ttChar.cChar  = SUBSTRING(cName,ii,1)
      ttChar.iCount = ttChar.iCount + 1.
  END.

  cCalcSum = ''.
  FOR EACH ttChar BY ttChar.iCount DESC BY ttChar.cChar:
    cCalcSum = cCalcSum + ttChar.cChar.
    IF LENGTH(cCalcSum) = 5 THEN LEAVE.
  END.

  IF cCalcSum = cCheckSum THEN 
    iSectorSum = iSectorSum + iSector.

END.

MESSAGE iSectorSum
  VIEW-AS ALERT-BOX INFO BUTTONS OK.


/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 137896                      */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
