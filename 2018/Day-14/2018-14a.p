/* Advent of code 2018
** day 14a
*/
DEFINE TEMP-TABLE ttRecipe
  FIELD iNr    AS INTEGER
  FIELD iScore AS INTEGER
  INDEX iPrim iNr.

FUNCTION addRecipe RETURNS INTEGER (pScore AS INTEGER):
  DEFINE BUFFER bRecipe FOR ttRecipe.
  DEFINE BUFFER bLast   FOR ttRecipe.
  FIND LAST bLast NO-ERROR.
  CREATE bRecipe.
  ASSIGN bRecipe.iNr = (IF AVAILABLE bLast THEN bLast.iNr + 1 ELSE 1)
         bRecipe.iScore = pScore.
  RETURN bRecipe.iNr.       
END FUNCTION.

FUNCTION recipeList RETURNS CHARACTER(pElve-1 AS INTEGER, pElve-2 AS INTEGER):
  DEFINE BUFFER bRec FOR ttRecipe.
  DEFINE VARIABLE cList AS CHARACTER NO-UNDO.
  FOR EACH bRec:
    CASE bRec.iNr:
      WHEN pElve-1 THEN cList = SUBSTITUTE('&1(&2)', cList,bRec.iScore). 
      WHEN pElve-2 THEN cList = SUBSTITUTE('&1[&2]', cList,bRec.iScore). 
      OTHERWISE cList = SUBSTITUTE('&1 &2 ', cList,bRec.iScore). 
    END CASE.
  END.
  RETURN cList.
END FUNCTION.

DEFINE VARIABLE c AS CHARACTER NO-UNDO.
DEFINE VARIABLE i AS INTEGER   NO-UNDO.
DEFINE VARIABLE n AS INTEGER   NO-UNDO.
DEFINE VARIABLE m AS INTEGER   NO-UNDO INITIAL 2018.

DEFINE BUFFER bOne FOR ttRecipe.
DEFINE BUFFER bTwo FOR ttRecipe.

addRecipe(3).
addRecipe(7).

FIND bOne WHERE bOne.iNr = 1.
FIND bTwo WHERE bTwo.iNr = 2.
OUTPUT TO "2018-14-debug.txt".

REPEAT:
  IF ETIME > 1000 THEN
  DO:
    ETIME(YES).
    HIDE MESSAGE NO-PAUSE.
    MESSAGE n. 
    PROCESS EVENTS. 
  END.
  
  /* add new recipes */
  c = STRING(bOne.iScore + bTwo.iScore).
  DO i = 1 TO LENGTH(c):
    n = addRecipe(INTEGER(SUBSTRING(c,i,1))).
  END.
  
  /* move around */
  i = (bOne.iNr + bOne.iScore + 1) MOD n.
  IF i = 0 THEN i = n.
  FIND bOne WHERE bOne.iNr = i.

  i = (bTwo.iNr + bTwo.iScore + 1) MOD n.
  IF i = 0 THEN i = n.
  FIND bTwo WHERE bTwo.iNr = i.

  IF n >= (m + 10) THEN LEAVE.
/*   MESSAGE j + 1 SKIP(1) recipeList(bOne.iNr, bTwo.iNr) */
/*       VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.        */
END.

c = ''.
FOR EACH ttRecipe WHERE ttRecipe.iNr > m AND ttRecipe.iNr <= m + 10:
  c = c + STRING(ttRecipe.iScore). 
END.
MESSAGE c VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


