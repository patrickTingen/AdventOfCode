DEFINE VARIABLE cData   AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE j       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iBlock  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNum    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFile   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INT64     NO-UNDO.

DEFINE TEMP-TABLE ttBlock NO-UNDO
  FIELD iBlockNr AS INTEGER
  FIELD iFileID  AS INTEGER
  INDEX iPrim iBlockNr
  INDEX iFile iFileId. 

DEFINE BUFFER ttFree FOR ttBlock. 
DEFINE BUFFER ttFile FOR ttBlock. 

ETIME(YES).

INPUT FROM "data.txt".
IMPORT UNFORMATTED cData.
INPUT CLOSE.

DO i = 1 TO LENGTH(cData):

  iNum = INTEGER(SUBSTRING(cData,i,1)).

  DO j = 1 TO iNum:
    CREATE ttBlock.
    ASSIGN ttBlock.iBlockNr = iBlock
           ttBlock.iFileID  = (IF i MOD 2 = 1 THEN iFile ELSE -1).

    iBlock = iBlock + 1.
  END.

  IF i MOD 2 = 1 THEN iFile = iFile + 1.
END.

REPEAT:
                IF ETIME > 5000 THEN LEAVE. 

  FIND FIRST ttFree WHERE ttFree.iFileID = -1 NO-ERROR.
  IF NOT AVAILABLE ttFree THEN LEAVE. 

  FIND LAST ttFile WHERE ttFile.iFileID > -1 NO-ERROR.

  ASSIGN ttFree.iFileID = ttFile.iFileID.
  DELETE ttFile.
END.

iNum = 0.
FOR EACH ttFile: iNum = iNum + 1. END. 
FIND LAST ttFile. ttFile.iBlockNr = iNum - 1.

FOR EACH ttFile:
  iAnswer = iAnswer + (ttFile.iBlockNr * ttFile.iFileID).
END.

MESSAGE iAnswer ETIME
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
