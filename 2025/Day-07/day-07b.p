/* AoC 2025 day 07b
 */ 
DEFINE TEMP-TABLE ttSplit
  FIELD iRow   AS INTEGER
  FIELD iCol   AS INTEGER
  FIELD iValue AS INT64
  INDEX iPrim iCol iRow.

DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iRowNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStart AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChar  AS CHARACTER NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".
REPEAT:

  IMPORT cLine.
  iRowNr = iRowNr + 1.

  DO i = 1 TO LENGTH(cLine):

    cChar = SUBSTRING(cLine,i,1).
    IF LOOKUP(cChar,"S,^") > 0 THEN 
    DO:
      // Add splitter
      CREATE ttSplit.
      ASSIGN 
        ttSplit.iRow = iRowNr
        ttSplit.iCol = i.

      // Starting beam
      IF cChar = "S" THEN iStart = i.

    END.
  END.
END.
INPUT CLOSE. 


FUNCTION getTimelines RETURNS INT64 
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):

  DEFINE BUFFER btSplit FOR ttSplit.
   
  // Find splitter below us
  FIND FIRST btSplit WHERE btSplit.iCol = piCol AND btSplit.iRow > piRow NO-ERROR.
  IF NOT AVAILABLE btSplit THEN RETURN 1. // off the grid
  
  // Not yet calculated?
  IF btSplit.iValue = 0 THEN 
    btSplit.iValue = getTimelines(btSplit.iCol - 1, btSplit.iRow) 
                   + getTimelines(btSplit.iCol + 1, btSplit.iRow).
      
  RETURN btSplit.iValue.
            
END FUNCTION. // getTimelines


MESSAGE getTimelines(iStart,1) "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

// ---------------------------
// Information 
// ---------------------------
// 15650261281478 in 27 ms
// ---------------------------
