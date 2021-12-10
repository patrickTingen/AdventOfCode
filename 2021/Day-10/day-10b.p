/* AoC 2021 day 10b
 */ 
DEFINE VARIABLE cLine      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNumLines  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLastChar  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cCloseChar AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttLine NO-UNDO
  FIELD cTxt   AS CHARACTER FORMAT 'X(40)'
  FIELD iScore AS INT64
  .

FUNCTION removePairs RETURNS CHARACTER (pcLine AS CHARACTER):
  DEFINE VARIABLE cBefore AS CHARACTER NO-UNDO.

  REPEAT :
    cBefore = pcLine.
    pcLine = REPLACE(pcLine,'()','').
    pcLine = REPLACE(pcLine,'[]','').
    pcLine = REPLACE(pcLine,'<>','').
    pcLine = REPLACE(pcLine,'~{}','').
    IF pcLine = '' OR pcLine = cBefore THEN LEAVE. 
  END.

  RETURN pcLine.
END FUNCTION. 


FUNCTION lineIsCorrupt RETURNS LOGICAL (pcLine AS CHARACTER):
  pcLine = removePairs(pcLine).
  pcLine = LEFT-TRIM(pcLine, "~{[(<").
  RETURN INDEX("]})>", SUBSTRING(pcLine,1,1)) > 0.
END FUNCTION. 
 

INPUT FROM data.txt.
REPEAT:
  IMPORT cLine.
  IF lineIsCorrupt(cLine) THEN NEXT. 
  
  CREATE ttLine.
  ASSIGN 
    iNumLines   = iNumLines + 1
    ttLine.cTxt = cLine.

  REPEAT:
    cLine = removePairs(ttLine.cTxt).
    IF cLine = "" THEN LEAVE. 
    cLastChar = SUBSTRING(cLine, LENGTH(cLine),1).

    CASE cLastChar:
      WHEN "("  THEN cCloseChar = ")".
      WHEN "["  THEN cCloseChar = "]".
      WHEN "~{" THEN cCloseChar = "}".
      WHEN "<"  THEN cCloseChar = ">".
      OTHERWISE cCloseChar = "".
    END CASE.

    ASSIGN 
      ttLine.cTxt   = ttLine.cTxt + cCloseChar
      ttLine.iScore = (ttLine.iScore * 5) + INDEX(")]}>", cCloseChar)
      .
  END.
END.
INPUT CLOSE. 

iNumLines = iNumLines / 2. /* integer division rounds up */

FOR EACH ttLine BY ttLine.iScore:
  iNumLines = iNumLines - 1.
  IF iNumLines = 0 THEN 
  DO:
    MESSAGE ttLine.iScore VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 4263222782 */
    LEAVE.
  END.
END.

