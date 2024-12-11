/* AoC 2024 - 6a Shorter code
*/
DEFINE VARIABLE cMap   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iWidth AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPos   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDir   AS INTEGER   NO-UNDO INITIAL 1.
DEFINE VARIABLE iStep  AS INTEGER   NO-UNDO EXTENT 4 INITIAL [0,1,0,-1].
DEFINE VARIABLE iSize  AS INTEGER   NO-UNDO.

ETIME(YES).

COPY-LOB FILE "data.txt" TO cMap.
cMap     = TRIM(REPLACE(REPLACE(cMap,'~n',''),'~r',','),', ').
iWidth   = LENGTH(ENTRY(1,cMap)).
cMap     = REPLACE(cMap,',','').
iPos     = INDEX(cMap,"^").
iSize    = LENGTH(cMap).
iStep[1] = iWidth * -1.
iStep[3] = iWidth.

DO WHILE iPos > 0 AND iPos < iSize:

  IF iPos > 0 AND iPos < iSize AND SUBSTRING(cMap,(iPos + iStep[iDir]),1) = "#" 
    THEN iDir = (iDir MOD 4) + 1.
    ELSE iPos = iPos + iStep[iDir].
  
  IF iPos > 0 AND iPos < iSize THEN 
    IF SUBSTRING(cMap,iPos,1) <> "V" THEN SUBSTRING(cMap,iPos,1) = "V".
END.

MESSAGE iSize - LENGTH(REPLACE(cMap,"V","")) + 1 "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 4711 in 69 ms */

