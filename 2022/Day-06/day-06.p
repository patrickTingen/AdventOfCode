/* AoC 2022 day 06 (a + b)
 */ 
FUNCTION getStartOfMessage RETURNS INTEGER
  (pcData AS LONGCHAR, piLength AS INTEGER):

  DEFINE VARIABLE cMarker AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j       AS INTEGER   NO-UNDO.

  #Marker:
  DO i = 2 TO LENGTH(pcData):
  
    cMarker = SUBSTRING(pcData, MAXIMUM(1, i - piLength + 1), piLength).
    IF i < piLength THEN NEXT #Marker.
  
    DO j = 1 TO LENGTH(cMarker):
      IF LENGTH(REPLACE(cMarker,SUBSTRING(cMarker,j,1),'')) < (piLength - 1) THEN NEXT #Marker.
    END.
  
    RETURN i.
  END.
END FUNCTION. /* getStartOfMessage */


DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.

COPY-LOB FILE "c:\Data\DropBox\AdventOfCode\2022\Day-06\data.txt" TO cData.

MESSAGE 'Part A: ' getStartOfMessage(cData,4) 
   SKIP 'Part B: ' getStartOfMessage(cData,14) 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

