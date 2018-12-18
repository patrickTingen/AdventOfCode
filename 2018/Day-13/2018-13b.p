/* Advent of code 2018
** day 13b
*/
DEFINE TEMP-TABLE ttTrack
  FIELD iPosX AS INTEGER
  FIELD iPosY AS INTEGER
  FIELD cType AS CHARACTER
  INDEX iPrim iPosX iPosY.

DEFINE TEMP-TABLE ttCart NO-UNDO
  FIELD iPosX AS INTEGER
  FIELD iPosY AS INTEGER
  FIELD cType AS CHARACTER
  FIELD iDir  AS INTEGER /* 0=left 1=straight 2=right */
  INDEX iPrim iPosX iPosY.

DEFINE TEMP-TABLE ttMove NO-UNDO
  FIELD cTrack AS CHARACTER
  FIELD cCart  AS CHARACTER 
  FIELD cNew   AS CHARACTER 
  FIELD iMoveX AS INTEGER
  FIELD iMoveY AS INTEGER
  INDEX iPrim cTrack cCart.

CREATE ttMove. ASSIGN ttMove.cTrack = '/' ttMove.cCart = '^' ttMove.iMoveX =  1 ttMove.iMoveY =  0 ttMove.cNew = '>'.
CREATE ttMove. ASSIGN ttMove.cTrack = '/' ttMove.cCart = '<' ttMove.iMoveX =  0 ttMove.iMoveY =  1 ttMove.cNew = 'v'.
CREATE ttMove. ASSIGN ttMove.cTrack = '/' ttMove.cCart = 'v' ttMove.iMoveX = -1 ttMove.iMoveY =  0 ttMove.cNew = '<'.
CREATE ttMove. ASSIGN ttMove.cTrack = '/' ttMove.cCart = '>' ttMove.iMoveX =  0 ttMove.iMoveY = -1 ttMove.cNew = '^'.

CREATE ttMove. ASSIGN ttMove.cTrack = '-' ttMove.cCart = '>' ttMove.iMoveX =  1 ttMove.iMoveY =  0 ttMove.cNew = '>'.
CREATE ttMove. ASSIGN ttMove.cTrack = '-' ttMove.cCart = '<' ttMove.iMoveX = -1 ttMove.iMoveY =  0 ttMove.cNew = '<'.
CREATE ttMove. ASSIGN ttMove.cTrack = '|' ttMove.cCart = '^' ttMove.iMoveX =  0 ttMove.iMoveY = -1 ttMove.cNew = '^'.
CREATE ttMove. ASSIGN ttMove.cTrack = '|' ttMove.cCart = 'v' ttMove.iMoveX =  0 ttMove.iMoveY =  1 ttMove.cNew = 'v'.

CREATE ttMove. ASSIGN ttMove.cTrack = '\' ttMove.cCart = '^' ttMove.iMoveX = -1 ttMove.iMoveY =  0 ttMove.cNew = '<'.
CREATE ttMove. ASSIGN ttMove.cTrack = '\' ttMove.cCart = '<' ttMove.iMoveX =  0 ttMove.iMoveY = -1 ttMove.cNew = '^'.
CREATE ttMove. ASSIGN ttMove.cTrack = '\' ttMove.cCart = 'v' ttMove.iMoveX =  1 ttMove.iMoveY =  0 ttMove.cNew = '>'.
CREATE ttMove. ASSIGN ttMove.cTrack = '\' ttMove.cCart = '>' ttMove.iMoveX =  0 ttMove.iMoveY =  1 ttMove.cNew = 'v'.

CREATE ttMove. ASSIGN ttMove.cTrack = '+' ttMove.cCart = '^' ttMove.iMoveX =  0 ttMove.iMoveY = -1 ttMove.cNew = '^'.
CREATE ttMove. ASSIGN ttMove.cTrack = '+' ttMove.cCart = '<' ttMove.iMoveX = -1 ttMove.iMoveY =  0 ttMove.cNew = '<'.
CREATE ttMove. ASSIGN ttMove.cTrack = '+' ttMove.cCart = 'v' ttMove.iMoveX =  0 ttMove.iMoveY =  1 ttMove.cNew = 'v'.
CREATE ttMove. ASSIGN ttMove.cTrack = '+' ttMove.cCart = '>' ttMove.iMoveX =  1 ttMove.iMoveY =  0 ttMove.cNew = '>'.

RUN readData('2018-13.dat').
RUN getTrains.
RUN showData.

#Main:
REPEAT:
  RUN moveTrains.
  /* RUN showData.*/
  
  /* check nr of remaining trains */
  FIND ttCart NO-ERROR.
  IF AVAILABLE ttCart THEN
  DO:
    MESSAGE ttCart.iPosX ',' ttCart.iPosY VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.
  END.
END.

PROCEDURE moveTrains:
  DEFINE BUFFER bCart FOR ttCart. 
  
  #TrainMove:
  FOR EACH ttCart BY ttCart.iPosY BY ttCart.iPosX:
    FIND ttTrack WHERE ttTrack.iPosX = ttCart.iPosX AND ttTrack.iPosY = ttCart.iPosY.
    
    IF ttTrack.cType = '+' THEN 
    DO:
      ttCart.iDir = (ttCart.iDir MOD 3) + 1.
      CASE ttCart.cType:
        WHEN '^' THEN ttCart.cType = ENTRY(ttCart.iDir, '<,^,>').
        WHEN '>' THEN ttCart.cType = ENTRY(ttCart.iDir, '^,>,v').
        WHEN 'v' THEN ttCart.cType = ENTRY(ttCart.iDir, '>,v,<').
        WHEN '<' THEN ttCart.cType = ENTRY(ttCart.iDir, 'v,<,^').
      END CASE.
    END.
    
    FIND ttMove WHERE ttMove.cTrack = ttTrack.cType AND ttMove.cCart = ttCart.cType NO-ERROR.
    IF AVAILABLE ttMove THEN
    DO:
      /* crash detection */
      FIND FIRST bCart 
        WHERE bCart.iPosX = ttCart.iPosX + ttMove.iMoveX 
          AND bCart.iPosY = ttCart.iPosY + ttMove.iMoveY NO-ERROR.
          
      IF AVAILABLE bCart THEN
      DO:
        /* remove both trains */
        DELETE bCart.
        DELETE ttCart.
        NEXT #TrainMove. 
      END. 
      
      ASSIGN 
        ttCart.iPosX = ttCart.iPosX + ttMove.iMoveX
        ttCart.iPosY = ttCart.iPosY + ttMove.iMoveY
        ttCart.cType = ttMove.cNew.
    END.        
  END.
END PROCEDURE. 

PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.

  INPUT FROM VALUE(pcFile).
  REPEAT: 
    j = j + 1.
    IMPORT UNFORMATTED c.
    DO i = 1 TO LENGTH(c):
      CREATE ttTrack.
      ASSIGN 
        ttTrack.iPosX = i - 1
        ttTrack.iPosY = j - 1
        ttTrack.cType = SUBSTRING(c,i,1).
    END.
  END. 
  INPUT CLOSE. 
END PROCEDURE. 

PROCEDURE getTrains:
  FOR EACH ttTrack WHERE LOOKUP(ttTrack.cType,'^,>,v,<') > 0:
    CREATE ttCart.
    BUFFER-COPY ttTrack TO ttCart.
    ASSIGN ttTrack.cType = ENTRY(LOOKUP(ttTrack.cType,'^,>,v,<'),'|,-,|,-').
  END.
END PROCEDURE. 

PROCEDURE showData:
  OUTPUT TO '2018-13-debug.txt' APPEND.
  FOR EACH ttTrack BREAK BY ttTrack.iPosY BY ttTrack.iPosX:
    FIND ttCart WHERE ttCart.iPosX = ttTrack.iPosX AND ttCart.iPosY = ttTrack.iPosY NO-ERROR.
    PUT UNFORMATTED (IF AVAILABLE ttCart THEN ttCart.cType ELSE ttTrack.cType).
    IF LAST-OF(ttTrack.iPosY) THEN PUT UNFORMATTED '~n'.
  END.
  OUTPUT CLOSE. 
END PROCEDURE. 








