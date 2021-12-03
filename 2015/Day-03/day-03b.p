/* AoC 2015 day 03b
 */ 
DEFINE VARIABLE cData   AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i       AS INTEGER  NO-UNDO.
DEFINE VARIABLE iPosX   AS INTEGER  NO-UNDO EXTENT 2.
DEFINE VARIABLE iPosY   AS INTEGER  NO-UNDO EXTENT 2 .
DEFINE VARIABLE j       AS INTEGER  NO-UNDO.
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

  j = (i MOD 2) + 1.

  CASE STRING(SUBSTRING(cData,i,1)):
    WHEN "^" THEN iPosY[j] = iPosY[j] + 1.
    WHEN ">" THEN iPosX[j] = iPosX[j] + 1.
    WHEN "v" THEN iPosY[j] = iPosY[j] - 1.
    WHEN "<" THEN iPosX[j] = iPosX[j] - 1.
  END CASE. 

  FIND ttHouse WHERE ttHouse.iX = iPosX[j] AND ttHouse.iY = iPosY[j] NO-ERROR.
  IF NOT AVAILABLE ttHouse THEN 
  DO:
    CREATE ttHouse.
    ttHouse.iX = iPosX[j].
    ttHouse.iY = iPosY[j].
  END.
  ttHouse.iP = ttHouse.iP + 1.
END.

FOR EACH ttHouse WHERE ttHouse.iP > 0: 
  iHouses = iHouses + 1.
END.

MESSAGE 'Part 2:' iHouses SKIP
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 2621                */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
