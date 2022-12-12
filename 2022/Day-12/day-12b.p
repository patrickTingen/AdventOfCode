/* AoC 2022 day 12b
 */ 
DEFINE VARIABLE giExit  AS INTEGER NO-UNDO.
DEFINE VARIABLE giStart AS INTEGER NO-UNDO.
DEFINE VARIABLE giPartA AS INTEGER NO-UNDO.
DEFINE VARIABLE giPartB AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iLocNr  AS INTEGER
  FIELD iPosX   AS INTEGER 
  FIELD iPosY   AS INTEGER 
  FIELD iHeight AS INTEGER 
  FIELD cStatus AS CHARACTER
  FIELD iSteps  AS INTEGER
  INDEX iPrim iPosX iPosY
  INDEX iTodo cStatus iSteps. 

FUNCTION stepsToExit RETURNS INTEGER(piStart AS INTEGER, piExit AS INTEGER) FORWARD.

RUN readData("data.txt").

DEFINE VARIABLE iNumLocs AS INTEGER NO-UNDO.

FOR EACH ttLoc WHERE ttLoc.iHeight = 1: 
  iNumLocs = iNumLocs + 1. 
END.

giPartA = stepsToExit(giStart, giExit).
giPartB = giPartA.

PAUSE 0 BEFORE-HIDE. 
FOR EACH ttLoc WHERE ttLoc.iHeight = 1:
  
  RUN resetGrid.
  IF ETIME > 1000 THEN 
  DO:
    MESSAGE iNumLocs.
    PROCESS EVENTS. 
    ETIME(YES).
  END.

  giPartB = MINIMUM(giPartB ,stepsToExit(ttLoc.iLocNr, giExit)).
  iNumLocs = iNumLocs - 1.
END.

MESSAGE giPartA giPartB
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* Implementation
*/
FUNCTION stepsToExit RETURNS INTEGER(piStart AS INTEGER, piExit AS INTEGER):

  DEFINE VARIABLE iNewSteps AS INTEGER NO-UNDO.

  DEFINE BUFFER bThis  FOR ttLoc.
  DEFINE BUFFER bOther FOR ttLoc.

  /* Init */
  FIND bThis WHERE bThis.iLocNr = piStart.
  bThis.cStatus = "Todo".

  #Main:
  REPEAT:        
    
    /* Find the most promising location */
    FIND FIRST bThis WHERE bThis.cStatus = "Todo" NO-ERROR.
    IF NOT AVAILABLE bThis THEN LEAVE #Main.

    /* Found exit? */
    IF bThis.iLocNr = piExit THEN RETURN bThis.iSteps.

    /* Examine the neighbours */
    FOR EACH bOther
      WHERE (bOther.iPosX = bThis.iPosX - 1 AND bOther.iPosY = bThis.iPosY    )
         OR (bOther.iPosX = bThis.iPosX + 1 AND bOther.iPosY = bThis.iPosY    )
         OR (bOther.iPosX = bThis.iPosX     AND bOther.iPosY = bThis.iPosY - 1)
         OR (bOther.iPosX = bThis.iPosX     AND bOther.iPosY = bThis.iPosY + 1):

      IF bOther.iHeight > (bThis.iHeight + 1) THEN NEXT. /* too high */
      
      iNewSteps = bThis.iSteps + 1.

      CASE bOther.cStatus:
        WHEN "Done" THEN NEXT.
        WHEN "Wait" THEN ASSIGN bOther.iSteps  = iNewSteps
                                bOther.cStatus = "Todo".
        WHEN "Todo" THEN IF iNewSteps < bOther.iSteps THEN bThis.iSteps = iNewSteps.
      END CASE.
    END.

    bThis.cStatus = "Done".
  END. /* main */

  RETURN 999999.

END FUNCTION. /* stepsToExit */


PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE cLoc  AS CHARACTER NO-UNDO CASE-SENSITIVE.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Read file and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').

  EMPTY TEMP-TABLE ttLoc. 

  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:

      cLoc = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).

      iNr = iNr + 1.
      CREATE bLoc.
      ASSIGN 
        bLoc.iLocNr  = iNr
        bLoc.iPosX   = iX 
        bLoc.iPosY   = iY 
        bLoc.iSteps  = 0
        bLoc.cStatus = "Wait".

      CASE cLoc:
        WHEN 'S' THEN ASSIGN bLoc.iHeight = 1  giStart = iNr.
        WHEN 'E' THEN ASSIGN bLoc.iHeight = 26 giExit  = iNr.
        OTHERWISE     ASSIGN bLoc.iHeight = ASC(cLoc) - 96.
      END CASE.

    END. /* iX */
  END. /* iY */
END PROCEDURE. /* readData */


PROCEDURE resetGrid:
  DEFINE BUFFER bLoc FOR ttLoc. 

  FOR EACH bLoc: 
    bLoc.iSteps  = 0.
    bLoc.cStatus = 'Wait'.
  END.
END PROCEDURE. /* resetGrid */


