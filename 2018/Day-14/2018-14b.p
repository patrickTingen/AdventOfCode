/* Advent of code 2018
** day 14b
*/
DEFINE TEMP-TABLE ttRecipe NO-UNDO
  FIELD iNr    AS INTEGER
  FIELD iScore AS INTEGER
  INDEX iPrim iNr.

DEFINE VARIABLE iRecipe     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNumRecipes AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSum        AS INTEGER   NO-UNDO.
DEFINE VARIABLE cList       AS CHARACTER NO-UNDO. 

DEFINE BUFFER bOne FOR ttRecipe.
DEFINE BUFFER bTwo FOR ttRecipe.
 
&GLOBAL-DEFINE NUM-RECIPES   702831
&GLOBAL-DEFINE RECIPE-LENGTH 6

CREATE ttRecipe.
ASSIGN 
  iNumRecipes     = iNumRecipes + 1
  ttRecipe.iNr    = iNumRecipes
  ttRecipe.iScore = 3
  cList = cList + '3'.

CREATE ttRecipe.
ASSIGN 
  iNumRecipes     = iNumRecipes + 1
  ttRecipe.iNr    = iNumRecipes
  ttRecipe.iScore = 7
  cList = cList + '7'.
  
FIND bOne WHERE bOne.iNr = 1.
FIND bTwo WHERE bTwo.iNr = 2.

REPEAT:
  IF ETIME > 1000 THEN
  DO:
    ETIME(YES).
    HIDE MESSAGE NO-PAUSE.
    MESSAGE iNumRecipes.
    PROCESS EVENTS. 
  END.
  
  /* add new recipes */
  iSum = bOne.iScore + bTwo.iScore.
  cList = cList + STRING(iSum).
  
  IF iSum > 9 THEN 
  DO:  
    CREATE ttRecipe.
    ASSIGN 
      iNumRecipes     = iNumRecipes + 1
      ttRecipe.iNr    = iNumRecipes
      ttRecipe.iScore = 1.
  END.
  
  CREATE ttRecipe.
  ASSIGN 
    iNumRecipes     = iNumRecipes + 1
    ttRecipe.iNr    = iNumRecipes
    ttRecipe.iScore = iSum MOD 10.
  
  /* move around */
  iRecipe = (bOne.iNr + bOne.iScore + 1) MOD iNumRecipes.
  IF iRecipe = 0 THEN iRecipe = iNumRecipes.
  FIND bOne WHERE bOne.iNr = iRecipe.

  iRecipe = (bTwo.iNr + bTwo.iScore + 1) MOD iNumRecipes.
  IF iRecipe = 0 THEN iRecipe = iNumRecipes.
  FIND bTwo WHERE bTwo.iNr = iRecipe.

  IF iNumRecipes > {&RECIPE-LENGTH} THEN cList = SUBSTRING(cList, LENGTH(cList) - {&RECIPE-LENGTH}).
  IF cList MATCHES '*{&NUM-RECIPES}*' THEN
  DO:
    MESSAGE iNumRecipes - {&RECIPE-LENGTH} - 1 VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.      
  END.
END.
