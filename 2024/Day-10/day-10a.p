/* AoC 2024 day 10a 
 */ 
DEFINE TEMP-TABLE ttMap NO-UNDO
  FIELD iCol    AS INTEGER
  FIELD iRow    AS INTEGER
  FIELD iHeight AS INTEGER
  FIELD lDone   AS LOGICAL
  INDEX iPrim iCol iRow iHeight.

PROCEDURE readMap:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iColNr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRowNr AS INTEGER   NO-UNDO.

  DEFINE BUFFER btMap FOR ttMap.
  INPUT FROM VALUE(pcFile).
  REPEAT:
    IMPORT cLine.
    iRowNr = iRowNr + 1.

    DO iColNr = 1 TO LENGTH(cLine):
      CREATE btMap.
      ASSIGN btMap.iCol    = iColNr
             btMap.iRow    = iRowNr
             btMap.iHeight = INTEGER(SUBSTRING(cLine,iColNr,1)).
    END.
  END.
  INPUT CLOSE. 
END PROCEDURE. 

PROCEDURE findPath:
  DEFINE INPUT PARAMETER piCol    AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER piRow    AS INTEGER NO-UNDO.
  DEFINE INPUT PARAMETER piHeight AS INTEGER NO-UNDO.

  DEFINE VARIABLE iPath AS INTEGER NO-UNDO.
  DEFINE BUFFER btMap FOR ttMap.

  IF piHeight = 9 THEN 
  DO:
    FIND btMap WHERE btMap.iCol = piCol AND btMap.iRow = piRow.
    ASSIGN btMap.lDone = TRUE.
    RETURN.
  END.

  FOR EACH btMap 
    WHERE (btMap.iCol = piCol     AND btMap.iRow = piRow - 1 AND btMap.iHeight = piHeight + 1)  /* N */
       OR (btMap.iCol = piCol + 1 AND btMap.iRow = piRow     AND btMap.iHeight = piHeight + 1)  /* E */
       OR (btMap.iCol = piCol     AND btMap.iRow = piRow + 1 AND btMap.iHeight = piHeight + 1)  /* S */
       OR (btMap.iCol = piCol - 1 AND btMap.iRow = piRow     AND btMap.iHeight = piHeight + 1): /* W */

    RUN findPath(btMap.iCol, btMap.iRow, btMap.iHeight).
  END.

END PROCEDURE. 

/* Main
*/
DEFINE VARIABLE giPartA AS INTEGER NO-UNDO.
DEFINE BUFFER ttMap2 FOR ttMap.

ETIME(YES).
RUN readMap('data.txt').

FOR EACH ttMap WHERE ttMap.iHeight = 0:
  
  RUN findPath(ttMap.iCol, ttMap.iRow, 0).

  FOR EACH ttMap2 WHERE ttMap2.lDone = TRUE:
    giPartA = giPartA + 1.
    ttMap2.lDone = FALSE. 
  END.
END.

MESSAGE giPartA "in" ETIME "ms" /* 811 in 895 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


