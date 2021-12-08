/* AoC 2021 day 08b
 */ 
DEFINE VARIABLE cLine      AS CHARACTER NO-UNDO.
DEFINE VARIABLE cInput     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cOutput    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cWord      AS CHARACTER NO-UNDO.
DEFINE VARIABLE i          AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCount     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iWordOrder AS INTEGER   NO-UNDO EXTENT 7 INITIAL [0,1,2,3,6,5,4].
DEFINE VARIABLE cValue     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTotal     AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttWord NO-UNDO
  FIELD cTxt   AS CHARACTER 
  FIELD iLen   AS INTEGER
  FIELD iOrder AS INTEGER
  FIELD cDigit AS CHARACTER 
  .

FUNCTION overlap RETURNS LOGICAL(pcSource AS CHARACTER, pcMaster AS CHARACTER):
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DO i = 1 TO LENGTH(pcMaster):
    IF INDEX(pcSource, SUBSTRING(pcMaster,i, 1)) = 0 THEN RETURN FALSE. 
  END.
  RETURN TRUE. 
END FUNCTION. 


FUNCTION getDigit RETURNS CHARACTER(pcDigit AS CHARACTER):
  DEFINE BUFFER bWord FOR ttWord.
  FIND bWord WHERE bWord.cDigit = pcDigit NO-ERROR.
  RETURN (IF AVAILABLE bWord THEN bWord.cTxt ELSE "").
END FUNCTION.

INPUT FROM "data.txt".
REPEAT :
  IMPORT UNFORMATTED cLine. 

  cInput = ENTRY(1, cLine, '|').

  /* Place in TT so we can process them in the right order */
  EMPTY TEMP-TABLE ttWord. 
  DO i = 1 TO NUM-ENTRIES(cInput,' '):
    CREATE ttWord.
    ASSIGN ttWord.cTxt  = ENTRY(i,cInput,' ')
           ttWord.iLen   = LENGTH(ttWord.cTxt)
           ttWord.iOrder = (IF ttWord.iLen = 0 THEN 0 ELSE iWordOrder[iLen]).
  END.

  /* Decode */
  FOR EACH ttWord BY ttWord.iOrder:
    /* Unique nr of elements */
    IF ttWord.iLen = 2 THEN ttWord.cDigit = "1".
    IF ttWord.iLen = 3 THEN ttWord.cDigit = "7".
    IF ttWord.iLen = 4 THEN ttWord.cDigit = "4".
    IF ttWord.iLen = 7 THEN ttWord.cDigit = "8".

    /* 6 elements, so could be 9,0,6 */
    IF ttWord.iLen = 6 AND overlap(ttWord.cTxt, getDigit('4')) THEN ttWord.cDigit = "9".
    IF ttWord.iLen = 6 AND ttWord.cDigit = "" AND overlap(ttWord.cTxt, getDigit('1')) THEN ttWord.cDigit = "0".
    IF ttWord.iLen = 6 AND ttWord.cDigit = "" THEN ttWord.cDigit = "6".

    /* 5 elements, so could be 3,5,2 */
    IF ttWord.iLen = 5 AND overlap(ttWord.cTxt, getDigit('1')) THEN ttWord.cDigit = "3".
    IF ttWord.iLen = 5 AND ttWord.cDigit = "" AND overlap(getDigit('9'),ttWord.cTxt) THEN ttWord.cDigit = "5".
    IF ttWord.iLen = 5 AND ttWord.cDigit = "" THEN ttWord.cDigit = "2".
  END.

  /* Compose output string */
  cOutput = ENTRY(2, cLine, '|').
  cValue = "".
  DO i = 1 TO NUM-ENTRIES(cOutput,' '):
    cWord = ENTRY(i,cOutput,' ').

    FOR EACH ttWord:
      /* Check overlap both ways; example: 0 will overlap 8, but 8 will not overlap 0 */
      IF overlap(ttWord.cTxt, cWord) AND overlap(cWord, ttWord.cTxt) THEN cValue = cValue + ttWord.cDigit.
    END.
  END.

  iTotal = iTotal + INTEGER(cValue).
END.
INPUT CLOSE. 

MESSAGE iTotal VIEW-AS ALERT-BOX INFO BUTTONS OK. /* 974512 */
