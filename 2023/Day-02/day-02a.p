/* AoC 2023 day 02a 
 */ 
DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iBlue     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRed      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iGreen    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxRed   AS INTEGER   NO-UNDO INITIAL 12.
DEFINE VARIABLE iMaxGreen AS INTEGER   NO-UNDO INITIAL 13.
DEFINE VARIABLE iMaxBlue  AS INTEGER   NO-UNDO INITIAL 14.
DEFINE VARIABLE iGameNr   AS INTEGER   NO-UNDO.
DEFINE VARIABLE lPossible AS LOGICAL   NO-UNDO.
DEFINE VARIABLE iAnswer   AS INTEGER   NO-UNDO.
DEFINE VARIABLE cWord     AS CHARACTER NO-UNDO EXTENT 2.

INPUT FROM data.txt.

REPEAT:
  IMPORT UNFORMATTED cLine.
  
  cLine = REPLACE(cLine,':', '').
  cLine = REPLACE(cLine,',', '').
  cLine = REPLACE(cLine,';', '').  
  lPossible = YES.
  
  DO i = 1 TO NUM-ENTRIES(cLine,' ') - 1 BY 2:
    cWord[1] = ENTRY(i, cLine,' ').
    cWord[2] = ENTRY(i + 1, cLine,' ').
    
    IF cWord[1] = 'Game' THEN iGameNr = INTEGER(cWord[2]).
    IF cWord[2] = 'red'   AND INTEGER(cWord[1]) > iMaxRed   THEN lPossible = FALSE. 
    IF cWord[2] = 'green' AND INTEGER(cWord[1]) > iMaxGreen THEN lPossible = FALSE. 
    IF cWord[2] = 'blue'  AND INTEGER(cWord[1]) > iMaxBlue  THEN lPossible = FALSE.
  END.
  
  IF lPossible THEN iAnswer = iAnswer + iGameNr.  
  
END.  

INPUT CLOSE.

MESSAGE iAnswer VIEW-AS ALERT-BOX.
