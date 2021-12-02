/* AoC 2021 day 02a 
 */ 
DEFINE VARIABLE cCmd AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNr  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iHor AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDep AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAim AS INTEGER   NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  IMPORT cCmd iNr.
  CASE cCmd:
    WHEN 'down'    THEN iAim = iAim + iNr.
    WHEN 'up'      THEN iAim = iAim - iNr.
    WHEN 'forward' THEN ASSIGN iHor = iHor + iNr
                               iDep = iDep + (iAim * iNr).
  END CASE.
END.
INPUT CLOSE. 

MESSAGE iHor * iDep
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Information
---------------------------
1963088820
---------------------------
OK   
---------------------------
*/
