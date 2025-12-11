/* AoC 2025 day 11b
 */ 
DEFINE TEMP-TABLE ttNode 
  FIELD cName  AS CHARACTER
  FIELD cExits AS CHARACTER
  INDEX idxName IS PRIMARY cName.

DEFINE TEMP-TABLE ttCache NO-UNDO
  FIELD cKey   AS CHARACTER
  FIELD iCount AS INT64
  INDEX idxKey IS PRIMARY UNIQUE cKey.

FUNCTION findPaths RETURNS INT64
  ( pcCurrent AS CHARACTER
  , pcTarget  AS CHARACTER
  , plDac     AS LOGICAL   
  , plFft     AS LOGICAL   
  ):
  
  DEFINE VARIABLE iCount AS INT64     NO-UNDO.
  DEFINE VARIABLE cKey   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i      AS INTEGER   NO-UNDO. 

  DEFINE BUFFER bNode  FOR ttNode.
  DEFINE BUFFER bCache FOR ttCache. 
  
  // Search cache
  cKey = SUBSTITUTE('&1;&2;&3', pcCurrent, plDac, plFft).
  FIND bCache WHERE bCache.cKey = cKey NO-ERROR.
  IF AVAILABLE bCache THEN RETURN bCache.iCount.
  
  // Update statusflags 
  IF pcCurrent = 'dac' THEN plDac = TRUE.
  IF pcCurrent = 'fft' THEN plFft = TRUE.

  // Found exit
  IF pcCurrent = pcTarget THEN 
  DO:
    iCount = INTEGER(plDac AND plFft).
  END.
  ELSE 
  DO:
    // Examine other paths
    FIND bNode WHERE bNode.cName = pcCurrent NO-ERROR.
    IF AVAILABLE bNode THEN 
    DO i = 1 TO NUM-ENTRIES(bNode.cExits," "):
      iCount = iCount + findPaths(ENTRY(i,bNode.cExits," "), pcTarget, plDac, plFft).
    END.
  END.
  
  // Save cache 
  CREATE bCache.
  ASSIGN bCache.cKey   = cKey
         bCache.iCount = iCount.
  
  RETURN bCache.iCount.
END FUNCTION. // findPaths

// Main
DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.

ETIME(YES).

// Load data
INPUT FROM "data.txt".  
REPEAT TRANSACTION:
  IMPORT UNFORMATTED cLine. 
  CREATE ttNode.
  ASSIGN ttNode.cName  = ENTRY(1,cLine,":")
         ttNode.cExits = ENTRY(2,cLine,":").
END.
INPUT CLOSE.

// Start path finding
MESSAGE findPaths("svr", "out", NO, NO) "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


// ---------------------------
// Information 
// ---------------------------
// 315116216513280 in 30 ms
// ---------------------------
