/* AoC 2023 day 02b
 */ 
DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxRed   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxGreen AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxBlue  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer   AS INTEGER   NO-UNDO.
DEFINE VARIABLE cWord     AS CHARACTER NO-UNDO EXTENT 2.

INPUT FROM data.txt.

REPEAT:
  IMPORT UNFORMATTED cLine.
  
  cLine = REPLACE(cLine,':', '').
  cLine = REPLACE(cLine,',', '').
  cLine = REPLACE(cLine,';', '').
  
  iMaxRed   = 0.
  iMaxGreen = 0.  
  iMaxBlue  = 0.
  
  DO i = 1 TO NUM-ENTRIES(cLine,' ') - 1 BY 2:
    cWord[1] = ENTRY(i, cLine,' ').
    cWord[2] = ENTRY(i + 1, cLine,' ').
    
    IF cWord[2] = 'red'   THEN iMaxRed   = MAXIMUM(iMaxRed  , INTEGER(cWord[1])). 
    IF cWord[2] = 'green' THEN iMaxGreen = MAXIMUM(iMaxGreen, INTEGER(cWord[1])). 
    IF cWord[2] = 'blue'  THEN iMaxBlue  = MAXIMUM(iMaxBlue , INTEGER(cWord[1])).
  END.
  
  iAnswer = iAnswer + (iMaxRed * iMaxGreen * iMaxBlue).  
  
END.  

INPUT CLOSE.

MESSAGE iAnswer VIEW-AS ALERT-BOX.
