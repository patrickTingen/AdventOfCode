/* AoC 2022 day 04b 
 */ 
DEFINE VARIABLE cElf AS CHARACTER NO-UNDO EXTENT 2.
DEFINE VARIABLE iFr  AS INTEGER   NO-UNDO EXTENT 2.
DEFINE VARIABLE iTo  AS INTEGER   NO-UNDO EXTENT 2.
DEFINE VARIABLE i    AS INTEGER   NO-UNDO.

INPUT FROM data.txt.
REPEAT:
  IMPORT DELIMITER "," cElf.

  iFr[1] = INTEGER(ENTRY(1,cElf[1],'-')).
  iTo[1] = INTEGER(ENTRY(2,cElf[1],'-')).
  iFr[2] = INTEGER(ENTRY(1,cElf[2],'-')).
  iTo[2] = INTEGER(ENTRY(2,cElf[2],'-')).

  IF ((iFr[1] >= iFr[2]) AND (iFr[1] <= iTo[2])) 
  OR ((iTo[1] >= iFr[2]) AND (iTo[1] <= iTo[2])) 
  OR ((iFr[1] <= iFr[2]) AND (iTo[1] >= iTo[2])) 
  OR ((iFr[2] <= iFr[1]) AND (iTo[2] >= iTo[1])) THEN i = i + 1.

END.
INPUT CLOSE. 

MESSAGE i
  VIEW-AS ALERT-BOX INFO BUTTONS OK.