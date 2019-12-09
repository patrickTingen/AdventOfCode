/* AoC 2019 - 8
*/
DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.

DEFINE VARIABLE i        AS INTEGER     NO-UNDO.
DEFINE VARIABLE j        AS INTEGER     NO-UNDO.
DEFINE VARIABLE iWidth   AS INTEGER     NO-UNDO INITIAL 25.
DEFINE VARIABLE iHeight  AS INTEGER     NO-UNDO INITIAL 6.
DEFINE VARIABLE iLayers  AS INTEGER     NO-UNDO INITIAL 100.
DEFINE VARIABLE iLength  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iTokens  AS INTEGER     NO-UNDO.
DEFINE VARIABLE cChunk   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iMinZero AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAnswer1 AS INTEGER     NO-UNDO.
DEFINE VARIABLE iNumZero AS INTEGER     NO-UNDO.
DEFINE VARIABLE cAnswer2 AS CHARACTER   NO-UNDO.

COPY-LOB FILE "2019-08.dat" TO cData.
iLength = iHeight * iWidth.
iMinZero = iLength.

DO i = 0 TO (iLayers - 1):
  cChunk = SUBSTRING(cData, (i * iLength) + 1,iLength).

  iNumZero = iLength - LENGTH(REPLACE(cChunk,'0','')).
  IF iNumZero < iMinZero THEN
  DO:
    iMinZero = iNumZero.
    iAnswer1 = (iLength - LENGTH(REPLACE(cChunk,'1',''))) 
             * (iLength - LENGTH(REPLACE(cChunk,'2',''))).
  END.
END.

MESSAGE 'Part 1:' iAnswer1 VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


/* Part 2
* 0=black 1=white 2=trans
*/
cAnswer2 = FILL('2',iLength).
DO i = 0 TO (iLayers - 1):
  cChunk = SUBSTRING(cData, (i * iLength) + 1,iLength).
  
  DO j = 1 TO iLength:
    IF SUBSTRING(cAnswer2,j,1) = '2' AND SUBSTRING(cChunk,j,1) <> '2' THEN
      SUBSTRING(cAnswer2,j,1) = SUBSTRING(cChunk,j,1).
  END.
END.

cAnswer2 = REPLACE(cAnswer2,'0',' ').
cAnswer2 = REPLACE(cAnswer2,'1','@').
cChunk = ''.
DO i = 0 TO (iHeight - 1):
  DO j = 1 TO iWidth:
    cChunk = SUBSTITUTE('&1&2', cChunk, SUBSTRING(cAnswer2, (i * iWidth) + j, 1)).
    IF j MOD 5 = 0 THEN cChunk = cChunk + ' | '.
  END.
  cChunk = cChunk + '~n'.
END.

MESSAGE 'Part 2:' SKIP(1) cChunk VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/*
Part 2: 

@@@@  | @@@   | @  @  |  @@   | @@@   | 
@     | @  @  | @  @  | @  @  | @  @  | 
@@@   | @  @  | @  @  | @  @  | @  @  | 
@     | @@@   | @  @  | @@@@  | @@@   | 
@     | @     | @  @  | @  @  | @ @   | 
@     | @     |  @@   | @  @  | @  @  | 

*/




