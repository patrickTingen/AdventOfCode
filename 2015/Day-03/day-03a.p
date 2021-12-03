/* AoC 2015 day 03a 
 */ 
DEFINE VARIABLE cData   AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i       AS INTEGER  NO-UNDO.
DEFINE VARIABLE iPosX   AS INTEGER  NO-UNDO.
DEFINE VARIABLE iPosY   AS INTEGER  NO-UNDO.
DEFINE VARIABLE iHouses AS INTEGER  NO-UNDO.

DEFINE TEMP-TABLE ttHouse NO-UNDO
  FIELD iX AS INTEGER
  FIELD iY AS INTEGER
  FIELD iP AS INTEGER
  INDEX iPrim iX iY.

COPY-LOB FILE "data.txt" TO cData.

CREATE ttHouse.
ttHouse.iP = 1.

DO i = 1 TO LENGTH(cData):

  CASE STRING(SUBSTRING(cData,i,1)):
    WHEN "^" THEN iPosY = iPosY + 1.
    WHEN ">" THEN iPosX = iPosX + 1.
    WHEN "v" THEN iPosY = iPosY - 1.
    WHEN "<" THEN iPosX = iPosX - 1.
  END CASE. 

  FIND ttHouse WHERE ttHouse.iX = iPosX AND ttHouse.iY = iPosY NO-ERROR.
  IF NOT AVAILABLE ttHouse THEN 
  DO:
    CREATE ttHouse.
    ttHouse.iX = iPosX.
    ttHouse.iY = iPosY.
  END.
  ttHouse.iP = ttHouse.iP + 1.
END.

FOR EACH ttHouse WHERE ttHouse.iP > 0: 
  iHouses = iHouses + 1.
END.

MESSAGE 'Part 1:' iHouses SKIP
  VIEW-AS ALERT-BOX INFO BUTTONS OK.


/* ---------------------------                  */
/* Information (Press HELP to view stack trace) */
/* ---------------------------                  */
/* Part 1: 2572                                 */
/* ---------------------------                  */
/* OK   Help                                    */
/* ---------------------------                  */