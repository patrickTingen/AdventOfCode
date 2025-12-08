/* AoC 2025 day 07a 
 */ 
DEFINE TEMP-TABLE ttSplit
  FIELD iRow  AS INTEGER
  FIELD iCol  AS INTEGER
  FIELD lDone AS LOGICAL 
  INDEX iPrim iCol iRow.

DEFINE TEMP-TABLE ttTodo LIKE ttSplit.
DEFINE BUFFER ttTodo2 FOR ttTodo. 

DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iRowNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER   NO-UNDO.
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
      IF cChar = "S" THEN
      DO:
        CREATE ttTodo. 
        BUFFER-COPY ttSplit TO ttTodo.
        iTotal = 1.
      END.

    END.
  END.
END.
INPUT CLOSE. 


REPEAT:

  // Anything to do?
  FIND FIRST ttTodo WHERE ttTodo.lDone = FALSE NO-ERROR.
  IF NOT AVAILABLE ttTodo THEN LEAVE.

  // Search left and right
  DO i = -1 TO 1 BY 2:

    FIND FIRST ttSplit 
      WHERE ttSplit.iCol = ttTodo.iCol + i
        AND ttSplit.iRow > ttTodo.iRow NO-ERROR.

    IF AVAILABLE ttSplit 
      AND NOT CAN-FIND(ttTodo 
                 WHERE ttTodo.iCol = ttSplit.iCol
                   AND ttTodo.iRow = ttSplit.iRow) THEN 
    DO:
      CREATE ttTodo2. 
      BUFFER-COPY ttSplit TO ttTodo2.
      iTotal = iTotal + 1.
    END.
  END.

  ttTodo.lDone = TRUE.
END.

MESSAGE iTotal "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

// ---------------------------
// Information 
// ---------------------------
// 1594 in 391 ms
// ---------------------------

