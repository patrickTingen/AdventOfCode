/* AoC 2024 day 10b
 */ 
DEFINE TEMP-TABLE ttMap NO-UNDO
  FIELD cPos    AS CHARACTER
  FIELD iCol    AS INTEGER
  FIELD iRow    AS INTEGER
  FIELD iHeight AS INTEGER
  INDEX iPrim iCol iRow iHeight
  INDEX iId cPos.

DEFINE TEMP-TABLE ttPath NO-UNDO
  FIELD cPath AS CHARACTER
  INDEX iPrim cPath.
  
PROCEDURE readMap:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iColNr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRowNr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iPosNr AS INTEGER   NO-UNDO.

  DEFINE BUFFER btMap FOR ttMap.
  INPUT FROM VALUE(pcFile).
  REPEAT:
    IMPORT cLine.
    iRowNr = iRowNr + 1.

    DO iColNr = 1 TO LENGTH(cLine):
    
      iPosNr = iPosNr + 1.
    
      CREATE btMap.
      ASSIGN 
        btMap.cPos    = STRING(iPosNr)
        btMap.iCol    = iColNr
        btMap.iRow    = iRowNr
        btMap.iHeight = (IF SUBSTRING(cLine,iColNr,1) = "." THEN -1 ELSE INTEGER(SUBSTRING(cLine,iColNr,1))).
    END.
  END.
  INPUT CLOSE. 
END PROCEDURE. 

PROCEDURE findPath:
  DEFINE INPUT PARAMETER pcPath   AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piCol    AS INTEGER   NO-UNDO.
  DEFINE INPUT PARAMETER piRow    AS INTEGER   NO-UNDO.
  DEFINE INPUT PARAMETER piHeight AS INTEGER   NO-UNDO.

  DEFINE VARIABLE iPath AS INTEGER NO-UNDO.
  DEFINE BUFFER btMap FOR ttMap.
  DEFINE BUFFER btPath FOR ttPath.

  IF piHeight = 9 THEN 
  DO:
    FIND btPath WHERE btPath.cPath = pcPath NO-ERROR.
    IF NOT AVAILABLE btPath THEN
    DO:
      CREATE btPath.
      ASSIGN btPath.cPath = pcPath.
    END.
    RETURN.
  END.

  FOR EACH btMap 
    WHERE (btMap.iCol = piCol     AND btMap.iRow = piRow - 1 AND btMap.iHeight = piHeight + 1)  /* N */
       OR (btMap.iCol = piCol + 1 AND btMap.iRow = piRow     AND btMap.iHeight = piHeight + 1)  /* E */
       OR (btMap.iCol = piCol     AND btMap.iRow = piRow + 1 AND btMap.iHeight = piHeight + 1)  /* S */
       OR (btMap.iCol = piCol - 1 AND btMap.iRow = piRow     AND btMap.iHeight = piHeight + 1): /* W */

    RUN findPath(pcPath + ',' + btMap.cPos, btMap.iCol, btMap.iRow, btMap.iHeight).
  END.

END PROCEDURE. 

/* Main
*/
DEFINE VARIABLE giPartB AS INTEGER NO-UNDO.
DEFINE BUFFER ttMap2 FOR ttMap.

ETIME(YES).
RUN readMap('data.txt').

FOR EACH ttMap WHERE ttMap.iHeight = 0:
  RUN findPath(ttMap.cPos, ttMap.iCol, ttMap.iRow, 0).
END.

FOR EACH ttPath:
  giPartB = giPartB + 1.
END.

MESSAGE giPartB "in" ETIME "ms" /* 1794 in 136 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


