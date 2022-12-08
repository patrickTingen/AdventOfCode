/* AoC 2022 day 08b
 */ 
DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  FIELD iScore AS INTEGER INITIAL 1
  INDEX idxRow    iPosX iPosY
  INDEX idxColumn iPosY iPosX. 

DEFINE VARIABLE giMaxX AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giMaxY AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE iPartB AS INTEGER NO-UNDO.

DEFINE BUFFER bLoc FOR ttLoc.
  
RUN readGrid('data.txt').

FOR EACH bLoc:
  
  /* Looking up */
  FIND LAST ttLoc WHERE ttLoc.iPosX = bLoc.iPosX AND ttLoc.iPosY < bLoc.iPosY AND ttLoc.cValue >= bLoc.cValue NO-ERROR.
  bLoc.iScore = bLoc.iScore * ABS((IF AVAILABLE ttLoc THEN ttLoc.iPosY ELSE 1) - bLoc.iPosY).
  
  /* Looking down */
  FIND FIRST ttLoc WHERE ttLoc.iPosX = bLoc.iPosX AND ttLoc.iPosY > bLoc.iPosY AND ttLoc.cValue >= bLoc.cValue NO-ERROR.
  bLoc.iScore = bLoc.iScore * ABS((IF AVAILABLE ttLoc THEN ttLoc.iPosY ELSE giMaxY) - bLoc.iPosY).
  
  /* Looking left */
  FIND LAST ttLoc WHERE ttLoc.iPosY = bLoc.iPosY AND ttLoc.iPosX < bLoc.iPosX AND ttLoc.cValue >= bLoc.cValue NO-ERROR.
  bLoc.iScore = bLoc.iScore * ABS((IF AVAILABLE ttLoc THEN ttLoc.iPosX ELSE 1) - bLoc.iPosX).
  
  /* Looking right */
  FIND FIRST ttLoc WHERE ttLoc.iPosY = bLoc.iPosY AND ttLoc.iPosX > bLoc.iPosX AND ttLoc.cValue >= bLoc.cValue NO-ERROR.
  bLoc.iScore = bLoc.iScore * ABS((IF AVAILABLE ttLoc THEN ttLoc.iPosX ELSE giMaxX) - bLoc.iPosX).
  
  iPartB = MAX(iPartB, bLoc.iScore).
END.

MESSAGE iPartB VIEW-AS ALERT-BOX INFO BUTTONS OK.


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


