/* AoC 2022 day 07 a+b 
 */ 
DEFINE TEMP-TABLE ttDir NO-UNDO
  FIELD cDirName AS CHARACTER FORMAT 'x(60)'
  FIELD iDirSize AS INTEGER
  INDEX iPrim IS PRIMARY UNIQUE cDirName
  INDEX iSize iDirSize.

DEFINE TEMP-TABLE ttFile NO-UNDO
  FIELD cFileName AS CHARACTER FORMAT 'x(60)'
  FIELD iFileSize AS INTEGER
  INDEX iPrim IS PRIMARY cFileName.

FUNCTION md RETURNS CHARACTER (pcDir AS CHARACTER):
  DEFINE BUFFER bDir FOR ttDir.
  FIND bDir WHERE bDir.cDirName = pcDir NO-ERROR.
  IF NOT AVAILABLE bDir THEN CREATE bDir.
  ASSIGN bDir.cDirName = pcDir. 
  RETURN pcDir.
END FUNCTION. 

FUNCTION addFile RETURNS CHARACTER (pcFile AS CHARACTER, piSize AS INTEGER):
  DEFINE BUFFER bFile FOR ttFile.
  FIND bFile WHERE bFile.cFileName = pcFile NO-ERROR.
  IF NOT AVAILABLE bFile THEN CREATE bFile.
  ASSIGN bFile.cFileName = pcFile
         bFile.iFileSize = piSize.
  RETURN pcFile.
END FUNCTION. 

FUNCTION cd RETURNS CHARACTER (pcDir AS CHARACTER, pcArg AS CHARACTER):
  CASE pcArg:
    WHEN '/' THEN RETURN md('/').
    WHEN '..' THEN RETURN SUBSTRING(pcDir, 1, R-INDEX(RIGHT-TRIM(pcDir,'/'),'/')).
    OTHERWISE RETURN md(pcDir + pcArg + '/').
  END CASE.
END FUNCTION. 

DEFINE VARIABLE cDir   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iPartA AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPartB AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFree  AS INTEGER   NO-UNDO.
DEFINE VARIABLE a AS CHARACTER   NO-UNDO.
DEFINE VARIABLE b AS CHARACTER   NO-UNDO.
DEFINE VARIABLE c AS CHARACTER   NO-UNDO.

ETIME(YES).

INPUT FROM data.txt.
REPEAT:
  IMPORT a b c.

  IF a = 'dir' THEN md(cDir + b + '/').
  ELSE IF a = '$' AND b = 'cd' THEN cDir = cd(cDir, c).
  ELSE IF a = '$' AND b = 'ls' THEN NEXT.
  ELSE addFile(cDir + b, INTEGER(a)).

END.
INPUT CLOSE.

/* Calc dir sizes */
FOR EACH ttDir:
  FOR EACH ttFile WHERE ttFile.cFileName BEGINS ttDir.cDirName:
    ttDir.iDirSize = ttDir.iDirSize + ttFile.iFileSize.
  END.
  /* Part A */
  IF ttDir.iDirSize <= 100000 THEN iPartA = iPartA + ttDir.iDirSize.
END.

/* Part B */
FIND ttDir WHERE ttDir.cDirName = "/".
iFree = (70000000 - ttDir.iDirSize).

FOR EACH ttDir BY ttDir.iDirSize:
  IF (iFree + ttDir.iDirSize) >= 30000000 THEN
  DO:
    iPartB = ttDir.iDirSize.
    LEAVE.
  END.
END.

MESSAGE "Part A:" iPartA 
   SKIP "Part B:" iPartB ETIME
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

