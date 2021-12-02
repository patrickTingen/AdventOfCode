/* AoC 2021 day 02a 
 */ 
DEFINE VARIABLE cCmd AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNr  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iHor AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDep AS INTEGER   NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  IMPORT cCmd iNr.
  CASE cCmd:
    WHEN 'forward' THEN iHor = iHor + iNr.
    WHEN 'down'    THEN iDep = iDep + iNr.
    WHEN 'up'      THEN iDep = iDep - iNr.
  END CASE.
END.
INPUT CLOSE. 

MESSAGE iHor * iDep
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Information
---------------------------
1714680
---------------------------
OK   
---------------------------
*/
