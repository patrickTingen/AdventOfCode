/* Advent of code 2018
** day 15a - Beverage Bandits
*/
DEFINE TEMP-TABLE ttMap
  FIELD iPosX  AS INTEGER
  FIELD iPosY  AS INTEGER
  FIELD cType  AS CHARACTER
  FIELD lAlive AS LOGICAL 
  INDEX iPrim iPosX iPosY
  INDEX iAlive lAlive iPosX iPosY
  INDEX iType cType lAlive.

DEFINE TEMP-TABLE ttUnit LIKE ttMap.  


FUNCTION inRangeOfEnemy RETURNS LOGICAL(pcPlayerType AS CHARACTER, piX AS INTEGER, piY AS INTEGER):
  DEFINE VARIABLE cEnemy AS CHARACTER NO-UNDO.
  cEnemy = (IF pcPlayerType = 'E' THEN 'G' ELSE 'E').

  RETURN CAN-FIND(FIRST ttUnit WHERE ttUnit.cType = cEnemy AND ttUnit.iPosX = piX + 1 AND ttUnit.iPosY = piY)
      OR CAN-FIND(FIRST ttUnit WHERE ttUnit.cType = cEnemy AND ttUnit.iPosX = piX - 1 AND ttUnit.iPosY = piY)
      OR CAN-FIND(FIRST ttUnit WHERE ttUnit.cType = cEnemy AND ttUnit.iPosX = piX AND ttUnit.iPosY = piY + 1)
      OR CAN-FIND(FIRST ttUnit WHERE ttUnit.cType = cEnemy AND ttUnit.iPosX = piX AND ttUnit.iPosY = piY - 1)
      .  
END FUNCTION. /* inRangeOfEnemy */


FUNCTION anyFreeEnemy RETURNS LOGICAL(pcPlayerType AS CHARACTER):
  /* return whether there is ANY enemy with a free space in range */
  DEFINE BUFFER bMap FOR ttMap. 

  DEFINE VARIABLE cEnemy AS CHARACTER NO-UNDO.
  cEnemy = (IF pcPlayerType = 'E' THEN 'G' ELSE 'E').

  FOR EACH bMap WHERE bMap.cType = cEnemy AND bMap.lAlive = TRUE:
    IF   CAN-FIND(FIRST ttMap WHERE ttMap.cType = '.' AND ttMap.iPosX = bMap.iPosX + 1 AND ttMap.iPosY = bMap.iPosY)
      OR CAN-FIND(FIRST ttMap WHERE ttMap.cType = '.' AND ttMap.iPosX = bMap.iPosX - 1 AND ttMap.iPosY = bMap.iPosY)
      OR CAN-FIND(FIRST ttMap WHERE ttMap.cType = '.' AND ttMap.iPosX = bMap.iPosX AND ttMap.iPosY = bMap.iPosY + 1)
      OR CAN-FIND(FIRST ttMap WHERE ttMap.cType = '.' AND ttMap.iPosX = bMap.iPosX AND ttMap.iPosY = bMap.iPosY - 1) THEN RETURN TRUE.
  END.
  RETURN FALSE.  
END FUNCTION. /* anyFreeEnemy */

  
RUN readData('2018-15-test.dat').  
RUN showData.  
RUN play.


PROCEDURE play:
  DEFINE BUFFER bMap FOR ttMap. 
  
  #Game:
  REPEAT:
    
    #Turn:
    FOR EACH bMap WHERE bMap.lAlive = TRUE BY bMap.iPosY BY bMap.iPosX:
    
      RUN findTargets(bMap.cType, OUTPUT TABLE ttUnit).
      IF NOT TEMP-TABLE ttUnit:HAS-RECORDS THEN LEAVE #Game.
      
      IF inRangeOfEnemy(bMap.cType,bMap.iPosY,bMap.iPosX) THEN
        RUN attackEnemy.
      ELSE 
      DO:
        IF NOT anyFreeEnemy(bMap.cType) THEN NEXT #Turn.
        RUN moveUnit.       
      END.
    END. 
  END.   
END PROCEDURE. /* play */ 


PROCEDURE attackEnemy:
  MESSAGE 'attackEnemy' VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END PROCEDURE. /* attackEnemy */


PROCEDURE moveUnit:
  /* To move, the unit first considers the squares that are in range 
  ** and determines which of those squares it could reach in the fewest 
  ** steps. A step is a single movement to any adjacent (immediately up, 
  ** down, left, or right) open (.) square. Units cannot move into walls 
  ** or other units. The unit does this while considering the current 
  ** positions of units and does not do any prediction about where units 
  ** will be later. If the unit cannot reach (find an open path to) any 
  ** of the squares that are in range, it ends its turn. If multiple 
  ** squares are in range and tied for being reachable in the fewest 
  ** steps, the square which is first in reading order is chosen.  
  */
  MESSAGE 'moveUnit' VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END PROCEDURE. /* moveUnit */


PROCEDURE findTargets:
  DEFINE INPUT PARAMETER pcPlayerType AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER TABLE FOR ttUnit. 
  DEFINE VARIABLE cEnemy AS CHARACTER   NO-UNDO.
  DEFINE BUFFER bUnit FOR ttUnit.
  DEFINE BUFFER bMap FOR ttMap.  
  EMPTY TEMP-TABLE bUnit.
  cEnemy = (IF pcPlayerType = 'E' THEN 'G' ELSE 'E').
  FOR EACH bMap WHERE bMap.cType = cEnemy AND bMap.lAlive = TRUE:
    CREATE bUnit.
    BUFFER-COPY bMap TO bUnit.
  END.
END PROCEDURE. 

  
PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.

  INPUT FROM VALUE(pcFile).
  REPEAT: 
    IMPORT UNFORMATTED c.
    j = j + 1.
    DO i = 1 TO LENGTH(c):
      CREATE ttMap.
      ASSIGN 
        ttMap.iPosX  = i - 1
        ttMap.iPosY  = j - 1
        ttMap.cType  = SUBSTRING(c,i,1)
        ttMap.lAlive = CAN-DO('E,G',ttMap.cType).
    END.
  END. 
  INPUT CLOSE. 
END PROCEDURE. /* readData */


PROCEDURE showData:
  OUTPUT TO '2018-15-debug.txt'.
  FOR EACH ttMap BREAK BY ttMap.iPosY BY ttMap.iPosX:
    PUT UNFORMATTED ttMap.cType.
    IF LAST-OF(ttMap.iPosY) THEN PUT UNFORMATTED '~n'.
  END.
  OUTPUT CLOSE. 
END PROCEDURE. /* showData */


