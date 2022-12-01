/* AoC 2022 day 01b
 */ 
DEFINE VARIABLE iCurrentElf  AS INTEGER NO-UNDO INITIAL 1. 
DEFINE VARIABLE iNumCalories AS INTEGER NO-UNDO.
DEFINE VARIABLE i            AS INTEGER NO-UNDO.
DEFINE VARIABLE iTotal       AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttElf
  FIELD iELfNr    AS INTEGER
  FIELD iCalories AS INTEGER.

INPUT FROM data.txt.
REPEAT:
  iNumCalories = 0.
  IMPORT iNumCalories.
  IF iNumCalories = 0 THEN iCurrentElf = iCurrentElf + 1.
  
  FIND ttElf WHERE ttElf.iElfNr = iCurrentElf NO-ERROR.
  IF NOT AVAILABLE ttElf THEN 
  DO:
    CREATE ttElf.  
    ttElf.iElfNr = iCurrentElf.
  END.
  
  ttElf.iCalories = ttElf.iCalories + iNumCalories.
END.
INPUT CLOSE. 

FOR EACH ttElf BY ttElf.iCalories DESCENDING:
  iTotal = iTotal + ttElf.iCalories.
  i = i + 1.
  IF i = 3 THEN
  DO:
    MESSAGE iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    LEAVE.
  END.
END.

/* ---------------------------                  */
/* Information (Press HELP to view stack trace) */
/* ---------------------------                  */
/* 210367                                       */
/* ---------------------------                  */
/* OK   Help                                    */
/* ---------------------------                  */
