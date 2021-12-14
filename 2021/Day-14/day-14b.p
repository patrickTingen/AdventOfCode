/* AoC 2021 day 14b
 */ 
DEFINE VARIABLE iStep   AS INT64 NO-UNDO.
DEFINE VARIABLE iAnswer AS INT64 NO-UNDO.

DEFINE TEMP-TABLE ttPair NO-UNDO
  FIELD cPair AS CHARACTER 
  FIELD cIns  AS CHARACTER
  FIELD iLen  AS INT64
  INDEX iPrim cPair.

DEFINE TEMP-TABLE ttElement NO-UNDO
  FIELD cName  AS CHARACTER 
  FIELD iCount AS INT64
  INDEX iPrim cName
  INDEX iCount iCount.

DEFINE TEMP-TABLE ttCombi NO-UNDO
  FIELD cPair  AS CHARACTER 
  FIELD iCount AS INT64
  INDEX iPrim IS PRIMARY cPair.

DEFINE TEMP-TABLE ttWork NO-UNDO LIKE ttCombi.

/* Main 
*/
RUN loadData.

DO iStep = 1 TO 40:

  /* Save current state of combinations */
  RUN saveCombiTable.

  FOR EACH ttWork:

    FIND ttPair WHERE ttPair.cPair = ttWork.cPair NO-ERROR.
    IF AVAILABLE ttPair THEN 
    DO:
      RUN addCombi(SUBSTRING(ttWork.cPair,1,1) + ttPair.cIns, ttWork.iCount).
      RUN addCombi(ttPair.cIns + SUBSTRING(ttWork.cPair,2,1), ttWork.iCount).
      RUN addElement(ttPair.cIns, ttWork.iCount).
    END.
    ELSE 
      RUN addCombi(ttWork.cPair, ttWork.iCount).

  END. /* f/e ttWork */
END. /* do iStep */


/* Find highest and lowest for answer
*/
FIND LAST ttElement USE-INDEX iCount. 
iAnswer = ttElement.iCount.

FIND FIRST ttElement USE-INDEX iCount. 
iAnswer = iAnswer - ttElement.iCount.

MESSAGE iAnswer SKIP "In" ETIME "ms" VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. 
/* 2516901104210 In 117 ms */


PROCEDURE loadData:
  DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cTemplate AS CHARACTER NO-UNDO.

  ETIME(YES).
  INPUT FROM "data.txt".

  IMPORT cTemplate.
  IMPORT ^.

  /* Read insertions */
  REPEAT:
    CREATE ttPair.
    IMPORT ttPair.cPair ttPair.cIns ttPair.cIns.
  END.
  INPUT CLOSE. 

  /* Save current combinations */
  DO i = 1 TO LENGTH(cTemplate) - 1:
    RUN addCombi(SUBSTRING(cTemplate,i,2), 1).
  END.

  /* Save occurrance of letters in the template */
  DO i = 1 TO LENGTH(cTemplate):
    RUN addElement(SUBSTRING(cTemplate,i,1), 1).
  END.
END PROCEDURE. /* loadData */


PROCEDURE addCombi:
  DEFINE INPUT PARAMETER pcPair  AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piCount AS INT64   NO-UNDO.
  DEFINE BUFFER bCombi FOR ttCombi.

  FIND bCombi WHERE bCombi.cPair = pcPair NO-ERROR.
  IF NOT AVAILABLE bCombi THEN
  DO: 
    CREATE bCombi.
    ASSIGN bCombi.cPair = pcPair.
  END.
  bCombi.iCount = bCombi.iCount + piCount.

END PROCEDURE. /* addCombi */


PROCEDURE addElement:
  DEFINE INPUT PARAMETER pcElement AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piCount   AS INT64   NO-UNDO.
  DEFINE BUFFER btElement FOR ttElement. 

  FIND btElement WHERE btElement.cName = pcElement NO-ERROR.
  
  IF NOT AVAILABLE btElement THEN 
  DO:
    CREATE btElement.
    btElement.cName = pcElement.
  END.

  btElement.iCount = btElement.iCount + piCount.

END PROCEDURE. /* addElement */


PROCEDURE saveCombiTable:
  DEFINE BUFFER btWork FOR ttWork. 
  DEFINE BUFFER btCombi FOR ttCombi.

  EMPTY TEMP-TABLE btWork.
  FOR EACH btCombi: 
    CREATE btWork.
    BUFFER-COPY btCombi TO btWork.
  END.
  EMPTY TEMP-TABLE btCombi.

END PROCEDURE. /* copyTable */


