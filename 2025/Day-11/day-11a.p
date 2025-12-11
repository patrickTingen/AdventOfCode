/* AoC 2025 day 11a 
 */ 
DEFINE TEMP-TABLE ttNode 
  FIELD cName  AS CHARACTER
  FIELD cExits AS CHARACTER
  INDEX idxName IS PRIMARY cName.

FUNCTION findPaths RETURNS INTEGER
  ( pcCurrent AS CHARACTER
  , pcTarget  AS CHARACTER ):
  
  DEFINE VARIABLE iCount AS INTEGER.
  DEFINE VARIABLE i      AS INTEGER.
  DEFINE BUFFER bNode FOR ttNode. 
  
  IF pcCurrent = pcTarget THEN RETURN 1. // Found exit
  
  // Check all exits
  FIND bNode WHERE bNode.cName = pcCurrent NO-ERROR.
  IF AVAILABLE bNode THEN 
  DO i = 1 TO NUM-ENTRIES(bNode.cExits," "):
    iCount = iCount + findPaths(ENTRY(i,bNode.cExits," "), pcTarget).
  END.
  
  RETURN iCount.
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
MESSAGE findPaths("you", "out") "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


// ---------------------------
// Information 
// ---------------------------
// 508 in 10 ms
// ---------------------------
