/* AoC 2022 day 08a 
 */ 
DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iPosX    AS INTEGER /* x-pos  */
  FIELD iPosY    AS INTEGER /* y-pos  */
  FIELD cValue   AS CHARACTER
  FIELD lVisible AS LOGICAL INITIAL TRUE
  INDEX iPrim iPosX iPosY. 

DEFINE VARIABLE giMaxX AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giMaxY AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iTrees AS INTEGER NO-UNDO.
DEFINE BUFFER bLoc FOR ttLoc.

RUN readGrid('data.txt').

FOR EACH bLoc:
  
  /* Edges */
  IF bLoc.iPosX = 1 OR bLoc.iPosX = giMaxX OR bLoc.iPosY = 1 OR bLoc.iPosY = giMaxY THEN 
    bLoc.lVisible = TRUE.

  ELSE
  DO:
    /* Invisible? */
    IF    CAN-FIND(FIRST ttLoc WHERE ttLoc.iPosY = bLoc.iPosY AND ttLoc.iPosX < bLoc.iPosX AND ttLoc.cValue >= bLoc.cValue) 
      AND CAN-FIND(FIRST ttLoc WHERE ttLoc.iPosY = bLoc.iPosY AND ttLoc.iPosX > bLoc.iPosX AND ttLoc.cValue >= bLoc.cValue) 
      AND CAN-FIND(FIRST ttLoc WHERE ttLoc.iPosX = bLoc.iPosX AND ttLoc.iPosY < bLoc.iPosY AND ttLoc.cValue >= bLoc.cValue)
      AND CAN-FIND(FIRST ttLoc WHERE ttLoc.iPosX = bLoc.iPosX AND ttLoc.iPosY > bLoc.iPosY AND ttLoc.cValue >= bLoc.cValue) THEN bLoc.lVisible = NO.
  END.

  IF bLoc.lVisible THEN iTrees = iTrees + 1.
END.

MESSAGE iTrees VIEW-AS ALERT-BOX INFO BUTTONS OK.


PROCEDURE readGrid:
  /* Read grid via longchar into TT
  */
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giMaxX = LENGTH(ENTRY(1,cData,'~n')).
  giMaxY = NUM-ENTRIES(cData,'~n').

  DO iY = 1 TO giMaxY:
    DO iX = 1 TO giMaxX:
      CREATE bLoc.
      ASSIGN 
        bLoc.iPosX  = iX
        bLoc.iPosY  = iY
        bLoc.cValue = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).
    END.
  END.

END PROCEDURE. /* readGrid */


