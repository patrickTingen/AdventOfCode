/* AoC 2024 day 13a 
 */ 
DEFINE TEMP-TABLE ttPush NO-UNDO
  FIELD iPushA AS INTEGER
  FIELD iPushB AS INTEGER
  FIELD iLocX  AS INTEGER
  FIELD iLocY  AS INTEGER
  FIELD iCost  AS INTEGER
  INDEX iPrim iPushA iPushB
  INDEX iPrize iLocX iLocY iCost.

DEFINE VARIABLE cLabel     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLine      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iButtonA   AS INTEGER   NO-UNDO EXTENT 2.
DEFINE VARIABLE iButtonB   AS INTEGER   NO-UNDO EXTENT 2.
DEFINE VARIABLE iPrizeX    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPrizeY    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotalCost AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTurns     AS INTEGER   NO-UNDO.

PAUSE 0 BEFORE-HIDE. 

ETIME(YES).
INPUT FROM "data.txt".
REPEAT:
  cLabel = ''.
  IMPORT DELIMITER ':' cLabel cLine.
  IF cLabel = '' THEN NEXT. 

  CASE cLabel:
    WHEN 'Button A' THEN 
      ASSIGN iButtonA[1] = INTEGER( ENTRY(2,ENTRY(1,cLine),"+") )
             iButtonA[2] = INTEGER( ENTRY(2,ENTRY(2,cLine),"+") ).

    WHEN 'Button B' THEN 
      ASSIGN iButtonB[1] = INTEGER( ENTRY(2,ENTRY(1,cLine),"+") )
             iButtonB[2] = INTEGER( ENTRY(2,ENTRY(2,cLine),"+") ).

    WHEN 'Prize' THEN 
    DO:
      iTurns = iTurns + 1.

      ASSIGN iPrizeX = INTEGER( ENTRY(2,ENTRY(1,cLine),"=") )
             iPrizeY = INTEGER( ENTRY(2,ENTRY(2,cLine),"=") ).
  
      RUN fillPushMatrix(iButtonA, iButtonB).

      #FindPrize:
      FOR EACH ttPush 
        WHERE ttPush.iLocX = iPrizeX 
          AND ttPush.iLocY = iPrizeY BY ttPush.iCost:
    
        iTotalCost = iTotalCost + ttPush.iCost.
        LEAVE #FindPrize.
      END.

      IF iTurns MOD 10 = 0 THEN DO:
        DISPLAY iTurns iTotalCost WITH 1 DOWN 1 COL ROW 10 CENTERED. 
        PROCESS EVENTS.
      END.
    END. /* prize */
  END CASE. 
END.

MESSAGE iTotalCost 'in' ETIME 'ms' /* 28138 in 31720 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


PROCEDURE fillPushMatrix:
  DEFINE INPUT PARAMETER piButtonA AS INTEGER NO-UNDO EXTENT 2.
  DEFINE INPUT PARAMETER piButtonB AS INTEGER NO-UNDO EXTENT 2.

  DEFINE VARIABLE a AS INTEGER NO-UNDO.
  DEFINE VARIABLE b AS INTEGER NO-UNDO.
  DEFINE BUFFER btPush FOR ttPush.

  DO a = 1 TO 100:
    DO b = 1 TO 100:
      FIND btPush WHERE btPush.iPushA = a AND btPush.iPushB = b NO-ERROR.

      IF NOT AVAILABLE btPush THEN 
      DO:
        CREATE btPush.
        ASSIGN btPush.iPushA = a btPush.iPushB = b.
      END.

      ASSIGN 
        btPush.iLocX = (a * piButtonA[1]) + (b * piButtonB[1])
        btPush.iLocY = (a * piButtonA[2]) + (b * piButtonB[2])
        btPush.iCost = (a * 3) + b.
    END.
  END.
END PROCEDURE. 

