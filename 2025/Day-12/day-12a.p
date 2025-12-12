/* AoC 2025 day 12a 
 */ 
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iRegion AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSize   AS INTEGER   NO-UNDO EXTENT 6.
DEFINE VARIABLE iCount  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cRegion AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNeeded AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.

ETIME(YES).
INPUT FROM "data.txt".

REPEAT :
  IMPORT UNFORMATTED cLine.

  // Nr of shape
  IF cLine MATCHES "*:" THEN i = INT(ENTRY(1,cLine,":")) + 1.

  // Shape itself, count "#"
  IF cLine MATCHES "*#*" THEN iSize[i] = iSize[i] + (LENGTH(cLine) - LENGTH(REPLACE(cLine,"#",""))).

  // Available space and nr of presents to fit
  IF cLine MATCHES "*x*" THEN 
  DO:
    cRegion = ENTRY(1,cLine,":").
    iRegion = INT(ENTRY(1,cRegion,'x')) * INT(ENTRY(2,cRegion,'x')).

    iNeeded = 0.
    DO i = 1 TO 6:
      iNeeded = iNeeded + (INT(ENTRY(i + 1, cLine," ")) * iSize[i]).
    END.

    // Assume that all presents can be packed underneath 
    // the tree without leaving any open spots
    IF iNeeded <= iRegion THEN iCount = iCount + 1.
  END.
END.
INPUT CLOSE. 

MESSAGE iCount "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

// ---------------------------
// Information 
// ---------------------------
// 521 in 10 ms
// ---------------------------
