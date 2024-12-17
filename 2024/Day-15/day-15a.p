/* AoC 2024 day 15a 
 */ 
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iCol AS INTEGER 
  FIELD iRow AS INTEGER 
  FIELD cVal AS CHARACTER
  INDEX idxHor iRow iCol
  INDEX idxVer iCol iRow.
  
DEFINE VARIABLE giNumCols  AS INTEGER  NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows  AS INTEGER  NO-UNDO INITIAL ?.
DEFINE VARIABLE gcMoves    AS LONGCHAR NO-UNDO.
DEFINE VARIABLE giCol      AS INTEGER  NO-UNDO.
DEFINE VARIABLE giRow      AS INTEGER  NO-UNDO.
DEFINE VARIABLE gcGrid     AS LONGCHAR NO-UNDO.
DEFINE VARIABLE giAnswerA  AS INTEGER  NO-UNDO.

FUNCTION setPos RETURNS LOGICAL
  ( piCol AS INTEGER
  , piRow AS INTEGER
  , pcVal AS CHARACTER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iCol = piCol AND bGrid.iRow = piRow NO-ERROR.
  IF NOT AVAILABLE bGrid THEN 
  DO:
    CREATE bGrid.
    ASSIGN bGrid.iCol = piCol
           bGrid.iRow = piRow
           bGrid.cVal = pcVal.
           
    /* Might need to adjust dimensions */
    IF giNumCols = ? OR piCol > giNumCols THEN giNumCols = piCol.
    IF giNumRows = ? OR piRow > giNumRows THEN giNumRows = piRow.             
  END.

  bGrid.cVal = pcVal.
  RETURN TRUE.
END FUNCTION. /* setPos */


FUNCTION pos RETURNS CHARACTER
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iCol = piCol AND bGrid.iRow = piRow NO-ERROR.
  RETURN (IF NOT AVAILABLE bGrid THEN "?" ELSE bGrid.cVal). 
END FUNCTION. /* pos */


PROCEDURE loadGrid:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iCol   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRow   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cVal   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iStart AS INTEGER   NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  INPUT FROM VALUE(pcFile).

  REPEAT:
    IMPORT UNFORMATTED cLine.
    IF cLine = "" THEN LEAVE. 
    iRow = iRow + 1.

    DO iCol = 1 TO LENGTH(cLine):
      cVal = SUBSTRING(cLine,iCol,1).
      setPos(iCol, iRow, cVal).
      IF cVal = "@" THEN 
      DO:
        ASSIGN giCol = iCol
               giRow = iRow.
        setPos(iCol, iRow, ".").
      END.
    END.
  END.

  /* Moves */
  REPEAT:
    IMPORT UNFORMATTED cLine.
    gcMoves = gcMoves + cLine.
  END.
  INPUT CLOSE. 

END PROCEDURE. /* loadGrid */  


PROCEDURE moveRobot:
  DEFINE INPUT PARAMETER pcMoves AS LONGCHAR  NO-UNDO.

  DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNewRow AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNewCol AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cDir    AS CHARACTER NO-UNDO.

  DEFINE BUFFER btGrid FOR ttGrid.
  DEFINE BUFFER btWall FOR ttGrid. 

  #RobotMove:
  DO WHILE pcMoves <> "":

    cDir = SUBSTRING(pcMoves,1,1).
    iNewCol = giCol.
    iNewRow = giRow.

    CASE cDir:
      WHEN "^" THEN iNewRow = giRow - 1.
      WHEN ">" THEN iNewCol = giCol + 1.
      WHEN "v" THEN iNewRow = giRow + 1.
      WHEN "<" THEN iNewCol = giCol - 1.
    END CASE.                                                                     
                                                                                  
    IF pos(iNewCol,iNewRow) = "." THEN                                            
      ASSIGN giCol = iNewCol                                                      
             giRow = iNewRow.                                                     

    ELSE 
    IF pos(iNewCol,iNewRow) = "O" THEN 
    DO: 
      CASE cDir:
        WHEN "^" THEN FIND LAST  btGrid USE-INDEX idxVer WHERE btGrid.iCol = iNewCol AND btGrid.iRow < iNewRow AND btGrid.cVal = '.' NO-ERROR.
        WHEN ">" THEN FIND FIRST btGrid USE-INDEX idxHor WHERE btGrid.iRow = iNewRow AND btGrid.iCol > iNewCol AND btGrid.cVal = '.' NO-ERROR.
        WHEN "v" THEN FIND FIRST btGrid USE-INDEX idxVer WHERE btGrid.iCol = iNewCol AND btGrid.iRow > iNewRow AND btGrid.cVal = '.' NO-ERROR.
        WHEN "<" THEN FIND LAST  btGrid USE-INDEX idxHor WHERE btGrid.iRow = iNewRow AND btGrid.iCol < iNewCol AND btGrid.cVal = '.' NO-ERROR.
      END CASE.

      CASE cDir:      
        WHEN "^" THEN FIND FIRST btWall WHERE btWall.iCol = btGrid.iCol AND btWall.iRow > btGrid.iRow AND btWall.iRow < giRow AND btWall.cVal = "#" NO-ERROR.
        WHEN ">" THEN FIND FIRST btWall WHERE btWall.iRow = btGrid.iRow AND btWall.iCol < btGrid.iCol AND btWall.iCol > giCol AND btWall.cVal = "#" NO-ERROR.
        WHEN "v" THEN FIND FIRST btWall WHERE btWall.iCol = btGrid.iCol AND btWall.iRow < btGrid.iRow AND btWall.iRow > giRow AND btWall.cVal = "#" NO-ERROR.
        WHEN "<" THEN FIND FIRST btWall WHERE btWall.iRow = btGrid.iRow AND btWall.iCol > btGrid.iCol AND btWall.iCol < giCol AND btWall.cVal = "#" NO-ERROR.
      END CASE.       

      IF AVAILABLE btGrid AND NOT AVAILABLE btWall THEN 
      DO:
        setPos(btGrid.iCol,btGrid.iRow,"O").
        setPos(iNewCol,iNewRow,".").
        giCol = iNewCol.
        giRow = iNewRow.
      END. /* avail btGrid */
    END. /* pos = O */
     
    pcMoves = SUBSTRING(pcMoves,2).
  END. /* do i */

END PROCEDURE. /* moveRobot */


ETIME(YES).
RUN loadGrid("data.txt").
RUN moveRobot(gcMoves).

FOR EACH ttGrid WHERE ttGrid.cVal = "O":
  giAnswerA = giAnswerA + (ttGrid.iRow - 1) * 100 + (ttGrid.iCol - 1).
END.

MESSAGE giAnswerA "in" ETIME "ms" /* 1552879 in 602 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

