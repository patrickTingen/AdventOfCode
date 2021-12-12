/* AoC 2021 day 12a 
 */ 
DEFINE TEMP-TABLE ttCave NO-UNDO
  FIELD cId     AS CHARACTER CASE-SENSITIVE
  FIELD isSmall AS LOGICAL
  FIELD cNodes  AS CHARACTER FORMAT "x(30)"
  INDEX iPrim IS PRIMARY cId.

DEFINE TEMP-TABLE ttPath NO-UNDO
  FIELD cNodes AS CHARACTER FORMAT "x(70)"
  INDEX iPrim IS PRIMARY cNodes.
  
DEFINE VARIABLE cNode   AS CHARACTER NO-UNDO EXTENT 2 CASE-SENSITIVE.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRoutes AS INTEGER   NO-UNDO.

INPUT FROM "data.txt".
REPEAT:
  IMPORT DELIMITER "-" cNode[1] cNode[2]. 
  DO i = 1 TO 2:
    FIND ttCave WHERE ttCave.cId = cNode[i] NO-ERROR.
    IF NOT AVAILABLE ttCave THEN
    DO:
      CREATE ttCave.
      ASSIGN ttCave.cId     = cNode[i]
             ttCave.isSmall = (cNode[i] = LC(cNode[i])).
    END.
    ttCave.cNodes = TRIM(ttCave.cNodes + "," + cNode[3 - i],",").
  END.  
END.
INPUT CLOSE. 


PROCEDURE findPath:
  DEFINE INPUT PARAMETER pcCave AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcPath AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE BUFFER bPath  FOR ttPath.
  DEFINE BUFFER bCave  FOR ttCave.
  DEFINE BUFFER bCave2 FOR ttCave.
  
  FIND bCave WHERE bCave.cId = pcCave.
  DO i = 1 TO NUM-ENTRIES(bCave.cNodes):
  
    FIND bCave2 WHERE bCave2.cId = ENTRY(i,bCave.cNodes).
    IF bCave2.isSmall AND LOOKUP(bCave2.cId, pcPath) > 0 THEN NEXT. 

    IF bCave2.cId = "end" THEN
    DO:
      IF NOT CAN-FIND(FIRST bPath WHERE bPath.cNodes = pcPath) THEN
      DO:
        CREATE bPath. 
        ASSIGN bPath.cNodes = pcPath.      
        iRoutes = iRoutes + 1.
      END.
      NEXT.
    END.
    
    RUN findPath(bCave2.cId, pcPath + "," + bCave2.cId).    
  END.  
END.

RUN findPath("start", "start").  

MESSAGE iRoutes VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 4186 */


