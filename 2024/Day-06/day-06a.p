/* AoC 2024 - 6a
*/
DEFINE TEMP-TABLE ttVisited NO-UNDO
  FIELD iRow AS INTEGER
  FIELD iCol AS INTEGER
  INDEX iPrim iRow iCol.
  
DEFINE VARIABLE cVisited AS LONGCHAR  NO-UNDO.

FUNCTION isVisited RETURNS LOGICAL(pCol AS INTEGER, pRow AS INTEGER):
  RETURN CAN-FIND(ttVisited WHERE ttVisited.iRow = pRow AND ttVisited.iCol = pCol). 
END FUNCTION. 

FUNCTION setVisited RETURNS LOGICAL(pCol AS INTEGER, pRow AS INTEGER):
  DEFINE BUFFER btVisited FOR ttVisited.

  FIND btVisited WHERE btVisited.iRow = pRow AND btVisited.iCol = pCol NO-ERROR.
  IF NOT AVAILABLE btVisited THEN CREATE btVisited.
  btVisited.iRow = pRow.
  btVisited.iCol = pCol.
  RETURN YES.
END FUNCTION.

DEFINE VARIABLE cMap          AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iRows         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCols         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iGuardRow     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iGuardCol     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDirection    AS CHARACTER NO-UNDO INITIAL "U".
DEFINE VARIABLE iVisitedCount AS INTEGER   NO-UNDO.

PROCEDURE initMap:
  DEFINE VARIABLE i AS INTEGER   NO-UNDO. 
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.

  COPY-LOB FILE "data.txt" TO cMap.
  cMap = REPLACE(cMap,'~n','').
  cMap = REPLACE(cMap,'~r',',').
  cMap = TRIM(cMap,',').

  iRows = NUM-ENTRIES(cMap).
  iCols = LENGTH(ENTRY(1,cMap)).
    
  DO i = 1 TO iRows:
    DO j = 1 TO iCols:
      IF SUBSTRING(ENTRY(i, cMap), j, 1) = "^" THEN 
      DO:
        iGuardRow = i.
        iGuardCol = j.
        LEAVE.
      END.
    END.
    IF iGuardRow > 0 THEN LEAVE.
  END.
END PROCEDURE.

FUNCTION isObstacle RETURNS LOGICAL (iRow AS INTEGER, iCol AS INTEGER):

  RETURN iRow >= 1 
     AND iRow <= iRows
     AND iCol >= 1 
     AND iCol <= iCols 
     AND SUBSTRING(ENTRY(iRow, cMap), iCol, 1) = "#".

END FUNCTION.

PROCEDURE moveGuard:
  DEFINE VARIABLE iNextRow AS INTEGER NO-UNDO.
  DEFINE VARIABLE iNextCol AS INTEGER NO-UNDO.
  
  iNextCol = iGuardCol.
  iNextRow = iGuardRow.

  CASE cDirection:
    WHEN "U" THEN iNextRow = iGuardRow - 1.
    WHEN "R" THEN iNextCol = iGuardCol + 1.
    WHEN "D" THEN iNextRow = iGuardRow + 1.
    WHEN "L" THEN iNextCol = iGuardCol - 1.
  END CASE.
  
  IF isObstacle(iNextRow, iNextCol) THEN 
  DO:
    CASE cDirection:
      WHEN "U" THEN cDirection = "R".
      WHEN "R" THEN cDirection = "D".
      WHEN "D" THEN cDirection = "L".
      WHEN "L" THEN cDirection = "U".
    END CASE.
  END.
  ELSE 
  DO:
    iGuardRow = iNextRow.
    iGuardCol = iNextCol.
  END.
  
  IF NOT isVisited(iGuardCol,iGuardRow) THEN 
  DO:
    setVisited(iGuardCol,iGuardRow).
    iVisitedCount = iVisitedCount + 1.
  END.
END PROCEDURE.

ETIME(YES).
RUN initMap.

DO WHILE iGuardRow >= 1
     AND iGuardRow <= iRows
     AND iGuardCol >= 1
     AND iGuardCol <= iCols:

  RUN moveGuard.
END.

MESSAGE iVisitedCount - 1 "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

