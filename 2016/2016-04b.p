/* Advent Of Code 2016, day 4, part 2 */

DEFINE TEMP-TABLE ttChar NO-UNDO
  FIELD cChar  AS CHARACTER
  FIELD iCount AS INTEGER
  .

DEFINE TEMP-TABLE ttRoom
  FIELD cName AS CHARACTER
  FIELD cReal AS CHARACTER
  .

FUNCTION rotate RETURNS CHARACTER
  ( cString AS CHARACTER
  , iRotate AS INTEGER
  ):
  DEFINE VARIABLE ii    AS INTEGER     NO-UNDO.
  DEFINE VARIABLE cChar AS CHARACTER   NO-UNDO.
  DEFINE VARIABLE iChar AS INTEGER     NO-UNDO.
  DEFINE VARIABLE cReal AS CHARACTER   NO-UNDO.

  DO ii = 1 TO LENGTH(cString):
    cChar = SUBSTRING(cString,ii,1).
    IF cChar = '-' THEN cReal = cReal + ' '.
    ELSE DO:
      iChar = ASC(cChar).
      iChar = iChar - 96. /* rebase to 'a' = 1 */ 
      iChar = iChar + iRotate.
      iChar = (iChar MOD 26) + 96.
      cReal = cReal + CHR(iChar).
    END.
  END.
  RETURN cReal.
END FUNCTION. /* rotate */

DEFINE VARIABLE cRawName   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cName      AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSector    AS INTEGER     NO-UNDO.
DEFINE VARIABLE cCheckSum  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE ii         AS INTEGER     NO-UNDO.
DEFINE VARIABLE cCalcSum   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSectorSum AS INTEGER     NO-UNDO.

INPUT FROM d:\Data\DropBox\AdventOfCode\2016-04-INPUT.txt.
OUTPUT TO d:\Data\DropBox\AdventOfCode\2016-04-OUTPUT.txt.

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
  DO:
    cName = rotate(SUBSTRING(cRawName,1,R-INDEX(cRawName,'-')),iSector).
    IF cName MATCHES '*north*' AND cName MATCHES '*pole*' THEN 
      MESSAGE cName iSector
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.

END.


/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 137896                      */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

