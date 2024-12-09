/* AoC 2024 - 6a Shorter code
*/
DEFINE VARIABLE cMap   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iWidth AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPos   AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDir   AS CHARACTER NO-UNDO INITIAL "U".
DEFINE VARIABLE iNext  AS INTEGER   NO-UNDO.

ETIME(YES).

COPY-LOB FILE "data.txt" TO cMap.
cMap   = TRIM(REPLACE(REPLACE(cMap,'~n',''),'~r',','),', ').
iWidth = LENGTH(ENTRY(1,cMap)).
cMap   = REPLACE(cMap,',','').
iPos   = INDEX(cMap,"^").
     
DO WHILE iPos > 0 AND iPos < LENGTH(cMap):

  iNext = (     IF cDir = "U" THEN iPos - iWidth 
           ELSE IF cDir = "R" THEN iPos + 1
           ELSE IF cDir = "D" THEN iPos + iWidth 
           ELSE iPos - 1). 
  
  IF iPos > 0 AND iPos < LENGTH(cMap) AND SUBSTRING(cMap,iNext,1) = "#" 
    THEN cDir = ENTRY(LOOKUP(cDir,"U,R,D,L"), "R,D,L,U").
    ELSE iPos = iNext.
  
  IF iPos > 0 AND iPos < LENGTH(cMap) THEN SUBSTRING(cMap,iPos,1) = "V".
END.

MESSAGE LENGTH(cMap) - LENGTH(REPLACE(cMap,"V","")) + 1 "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 4711 in 76 ms */

