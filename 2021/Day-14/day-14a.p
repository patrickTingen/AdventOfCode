/* AoC 2021 day 14a 
 */ 
DEFINE VARIABLE cPolymer  AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cTemplate AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cData     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iStep     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChunk    AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer   AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttIns NO-UNDO
  FIELD cPair   AS CHARACTER 
  FIELD cIns    AS CHARACTER
  INDEX iPrim cPair.

DEFINE TEMP-TABLE ttElement NO-UNDO
  FIELD cName  AS CHARACTER 
  FIELD iCount AS INTEGER
  INDEX iPrim cName
  INDEX iCount iCount.
  
ETIME(YES).
INPUT FROM "data.txt".
IMPORT cData.
cPolymer = cData.
IMPORT ^.

REPEAT:
  CREATE ttIns.
  IMPORT ttIns.cPair cData ttIns.cIns.
END.
INPUT CLOSE. 

DO iStep = 1 TO 10:

  cTemplate = "".
  DO i = 1 TO LENGTH(cPolymer) - 1:
    cChunk = SUBSTRING(cPolymer,i,2).
    FIND ttIns WHERE ttIns.cPair = cChunk NO-ERROR.
    cTemplate = cTemplate + SUBSTRING(cPolymer,i,1) + (IF AVAILABLE ttIns THEN ttIns.cIns ELSE "").
  END.

  cPolymer = cTemplate + SUBSTRING(cPolymer,LENGTH(cPolymer),1).
END.

DO i = 1 TO LENGTH(cPolymer):
  cChunk = SUBSTRING(cPolymer,i,1).
  FIND ttElement WHERE ttElement.cName = cChunk NO-ERROR.
  IF NOT AVAILABLE ttElement THEN DO:
    CREATE ttElement.
    ASSIGN ttElement.cName = cChunk.
  END.
  ttElement.iCount = ttElement.iCount + 1.
END.

/* Find most common element */
FIND LAST ttElement USE-INDEX iCount.
iAnswer = ttElement.iCount.

/* Find least common element */
FIND FIRST ttElement USE-INDEX iCount.
iAnswer = iAnswer - ttElement.iCount.

MESSAGE iAnswer SKIP "In" ETIME "ms" VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. 
/* 2549 In 302 ms */
