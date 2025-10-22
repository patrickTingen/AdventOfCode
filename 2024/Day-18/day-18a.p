/* AoC 2024 day 18a
 */ 
DEFINE VARIABLE giPartA AS INTEGER  NO-UNDO.
DEFINE VARIABLE giSize  AS INTEGER  NO-UNDO.
DEFINE VARIABLE gcPath  AS LONGCHAR NO-UNDO.

DEFINE TEMP-TABLE ttMap NO-UNDO
  FIELD cPos AS CHARACTER
  FIELD iCol AS INTEGER
  FIELD iRow AS INTEGER
  FIELD cVal AS CHARACTER 
  INDEX iPrim iCol iRow cVal
  INDEX iId cPos.

PROCEDURE readMap:
  DEFINE INPUT PARAMETER pcFile  AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piSize  AS INTEGER   NO-UNDO.
  DEFINE INPUT PARAMETER piBytes AS INTEGER   NO-UNDO.

  DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iColNr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iRowNr AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iPosNr AS INTEGER   NO-UNDO.
  
  DEFINE BUFFER btMap FOR ttMap.

  giSize = piSize.
  giPartA = (giSize * giSize).
  
  DO iRowNr = 0 TO giSize:
    DO iColNr = 0 TO giSize:
    
      iPosNr = iPosNr + 1.
      CREATE btMap.
      ASSIGN 
        btMap.cPos = STRING(iPosNr)
        btMap.iCol = iColNr
        btMap.iRow = iRowNr
        btMap.cVal = ".".
    END. 
  END.

  iPosNr = 0.
  INPUT FROM VALUE(pcFile).
  REPEAT:
    IMPORT DELIMITER "," iColNr iRowNr.

    iPosNr = iPosNr + 1.
    IF iPosNr > piBytes THEN LEAVE.
    
    FIND btMap WHERE btMap.iCol = iColNr AND btMap.iRow = iRowNr.
    ASSIGN btMap.cVal = "#".
  END.
  INPUT CLOSE. 
  
END PROCEDURE. 


PROCEDURE findPath:
  DEFINE INPUT PARAMETER pcPath AS LONGCHAR NO-UNDO.
  DEFINE INPUT PARAMETER piCol  AS INTEGER  NO-UNDO.
  DEFINE INPUT PARAMETER piRow  AS INTEGER  NO-UNDO.

  DEFINE VARIABLE iPath AS INTEGER NO-UNDO.
  DEFINE BUFFER btMap FOR ttMap.
               
  IF ETIME > 5000 THEN RETURN.
  
  IF NUM-ENTRIES(pcPath) > giPartA THEN RETURN.
  
  IF piCol = giSize AND piRow = giSize THEN 
  DO:
    giPartA = MIN(giPartA,NUM-ENTRIES(pcPath) - 1).
    gcPath = pcPath.
    MESSAGE giPartA. PROCESS EVENTS. 
    RETURN.
  END.

  FOR EACH btMap 
    WHERE (btMap.iCol = piCol     AND btMap.iRow = piRow - 1 AND btMap.cVal = ".")  /* N */
       OR (btMap.iCol = piCol + 1 AND btMap.iRow = piRow     AND btMap.cVal = ".")  /* E */
       OR (btMap.iCol = piCol     AND btMap.iRow = piRow + 1 AND btMap.cVal = ".")  /* S */
       OR (btMap.iCol = piCol - 1 AND btMap.iRow = piRow     AND btMap.cVal = "."): /* W */

    IF LOOKUP(btMap.cPos,pcPath) = 0 THEN 
      RUN findPath(pcPath + ',' + btMap.cPos, btMap.iCol, btMap.iRow).
  END.

END PROCEDURE. 

FUNCTION pos RETURNS CHARACTER
  ( piCol AS INTEGER
  , piRow AS INTEGER
  ):    
  DEFINE BUFFER btMap FOR ttMap.
  FIND btMap WHERE btMap.iCol = piCol AND btMap.iRow = piRow NO-ERROR.
  RETURN (IF NOT AVAILABLE btMap THEN "" ELSE btMap.cVal). 
END FUNCTION. /* pos */


FUNCTION getMap RETURNS LONGCHAR
  ( ): 
  DEFINE VARIABLE iCol  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iRow  AS INTEGER  NO-UNDO.
  DEFINE VARIABLE cGrid AS LONGCHAR NO-UNDO.

  DO iRow = 0 TO giSize:
    DO iCol = 0 TO giSize:
      cGrid = cGrid + pos(iCol,iRow).
    END.
    cGrid = cGrid + "~n".
  END.

  RETURN cGrid.
END FUNCTION. /* getMap */

/* Main
*/
ETIME(YES).

//RUN readMap('test.txt',6,12).
RUN readMap('data.txt',70,1024).
RUN findPath("1",0,0).   

DEFINE BUFFER btMap FOR ttMap.
DEFINE VARIABLE i AS INTEGER   NO-UNDO.
DEFINE VARIABLE c AS CHARACTER NO-UNDO.
DEFINE VARIABLE m AS LONGCHAR  NO-UNDO.

DO i = 1 TO NUM-ENTRIES(gcPath):
  c = ENTRY(i,gcPath).
  FIND btMap WHERE btMap.cPos = c.
  //ASSIGN btMap.cVal = "O".
END.

m = getMap().
COPY-LOB m TO FILE "map.txt".

MESSAGE giPartA "in" ETIME "ms" /* 1794 in 136 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


