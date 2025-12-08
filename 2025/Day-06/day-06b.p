/* AoC 2025 day 06b 
 */ 
DEFINE VARIABLE cData   AS CHARACTER NO-UNDO. 
DEFINE VARIABLE cLine   AS CHARACTER EXTENT 4 NO-UNDO. 
DEFINE VARIABLE iRow    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cOper   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLen    AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE j       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cNr     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSub    AS INT64     NO-UNDO.
DEFINE VARIABLE cList   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTotal  AS INT64     NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".

REPEAT:
  IMPORT UNFORMATTED cData.
  IF INDEX(cData,"+") = 0 THEN 
  DO:
    iRow = iRow + 1.
    cLine[iRow] = cData.
    iLen = MAX(iLen,LENGTH(cData)). // longest line
  END.
  ELSE 
  cOper = cData.    
END.


DO i = iLen TO 1 BY -1:

  // Construct nr from top to bottom
  cNr = "".
  DO j = 1 TO iRow:
    cNr = cNr + SUBSTRING(cLine[j],i,1).
  END.

  // Build list of all nrs 
  cList = TRIM(cList + "," + cNr, " ,"). 
  
  // Are we at the start of a column?
  IF LOOKUP(SUBSTRING(cOper,i,1),"+,*") > 0 THEN
  DO:
    
    // Add or multiply all nrs in the list
    iSub  = 0.
    
    DO j = 1 TO NUM-ENTRIES(cList):
      IF j = 1 THEN iSub = INT(ENTRY(j,cList)).
      ELSE
      IF SUBSTRING(cOper,i,1) = "+" 
        THEN iSub = iSub + INT(ENTRY(j,cList)).
        ELSE iSub = iSub * INT(ENTRY(j,cList)).
    END.
    
    iTotal = iTotal + iSub.
    cList = "".
  END.
END.

MESSAGE iTotal "in" ETIME "ms" 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
  
// ---------------------------
// Information in 33 ms
// ---------------------------
// 10756006415204
// ---------------------------
