/* AoC 2024 day 06b 
 */ 
DEFINE VARIABLE gcMap   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE giWidth AS INTEGER   NO-UNDO.
DEFINE VARIABLE giSize  AS INTEGER   NO-UNDO.
DEFINE VARIABLE gcRoute AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE giPartB AS INTEGER   NO-UNDO.

PROCEDURE readMap:
  DEFINE INPUT  PARAMETER pcFile AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER pcMap  AS LONGCHAR  NO-UNDO.

  COPY-LOB FILE pcFile TO pcMap.
  pcMap   = TRIM(REPLACE(REPLACE(pcMap,'~n',''),'~r',','),', ').
  giWidth = LENGTH(ENTRY(1,pcMap)).
  pcMap   = REPLACE(pcMap,',','').
  giSize  = LENGTH(pcMap).
END PROCEDURE. 


PROCEDURE partA:
  DEFINE INPUT  PARAMETER pcMap   AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER pcRoute AS LONGCHAR  NO-UNDO.

  DEFINE VARIABLE iPos  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cDir  AS CHARACTER NO-UNDO INITIAL 'U'.
  DEFINE VARIABLE iNext AS INTEGER   NO-UNDO.

  iPos = INDEX(pcMap,"^").
  pcRoute = pcMap.

  DO WHILE iPos >= 1 AND iPos <= giSize:

    IF SUBSTRING(pcRoute,iPos,1) <> "V" THEN 
      SUBSTRING(pcRoute,iPos,1) = "V".
  
    iNext = (     IF cDir = "U" THEN iPos - giWidth 
             ELSE IF cDir = "R" THEN iPos + 1
             ELSE IF cDir = "D" THEN iPos + giWidth 
             ELSE iPos - 1).
           
    IF iNext >= 1 AND iNext <= giSize AND SUBSTRING(pcMap,iNext,1) = "#" 
      THEN cDir = ENTRY(LOOKUP(cDir,"U,R,D,L"), "R,D,L,U").
      ELSE iPos = iNext.
  END.  
END PROCEDURE. 


PROCEDURE partB:
  DEFINE INPUT  PARAMETER pcMap   AS LONGCHAR NO-UNDO.
  DEFINE INPUT  PARAMETER pcRoute AS LONGCHAR NO-UNDO.
  DEFINE OUTPUT PARAMETER piStuck AS INTEGER   NO-UNDO.

  DEFINE VARIABLE i      AS INTEGER NO-UNDO.
  DEFINE VARIABLE lStuck AS LOGICAL NO-UNDO.
  
  DO i = 1 TO giSize:
  
    /* Debug */
    IF i MOD 100 = 0 THEN DO:
      DISPLAY i LABEL 'Done' INT(i / 169) LABEL 'Prc' WITH SIDE-LABELS.
      PROCESS EVENTS.
    END.
    
    IF SUBSTRING(pcRoute,i,1) <> 'V' THEN NEXT.

    RUN testRoute(pcMap,i,OUTPUT lStuck).
    IF lStuck THEN piStuck = piStuck + 1.
  END.
END PROCEDURE. 

 
PROCEDURE testRoute:
  DEFINE INPUT  PARAMETER pcMap   AS CHARACTER NO-UNDO.
  DEFINE INPUT  PARAMETER piExtra AS INTEGER   NO-UNDO.
  DEFINE OUTPUT PARAMETER plStuck AS LOGICAL   NO-UNDO.

  DEFINE VARIABLE iPos  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cDir  AS CHARACTER NO-UNDO INITIAL 'U'.
  DEFINE VARIABLE iNext AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cBump AS LONGCHAR  NO-UNDO.

  iPos = INDEX(pcMap,"^").
  IF piExtra > 0 THEN SUBSTRING(pcMap,piExtra,1) = "#".

  DO WHILE iPos >= 1 AND iPos <= giSize:
        
    iNext = (     IF cDir = "U" THEN iPos - giWidth 
             ELSE IF cDir = "R" THEN iPos + 1
             ELSE IF cDir = "D" THEN iPos + giWidth 
             ELSE iPos - 1).

    /* Off the map? */
    IF (cDir = "R" AND iNext MOD giWidth = 1) 
    OR (cDir = "L" AND iNext MOD giWidth = 0) 
    OR (cDir = "U" AND iNext < 1) 
    OR (cDir = "D" AND iNext > giSize) THEN LEAVE.
    
    /* Bumped into obstacle */       
    IF SUBSTRING(pcMap,iNext,1) = "#" THEN 
    DO:
      /* Bounced into this obstacle from this direction before? */
      IF LOOKUP(SUBSTITUTE('&1&2',iNext,cDir), cBump) > 0 THEN 
      DO:
        plStuck = TRUE.
        RETURN.
      END.

      cBump = SUBSTITUTE('&1,&2&3',cBump,iNext,cDir).
      cDir = ENTRY(LOOKUP(cDir,"U,R,D,L"), "R,D,L,U").
    END.
    ELSE 
      iPos = iNext.
  END.
END PROCEDURE.

/* Main */
ETIME(YES).
RUN readMap("data.txt", OUTPUT gcMap).
RUN partA(gcMap, OUTPUT gcRoute).
RUN partB(gcMap, gcRoute, OUTPUT giPartB).

MESSAGE giPartB "in" ETIME "ms" /* 1562 in 76622 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

