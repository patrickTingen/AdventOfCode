
DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iId    AS INTEGER /* unique id */
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  FIELD iNorth AS INTEGER
  FIELD iEast  AS INTEGER
  FIELD iSouth AS INTEGER
  FIELD iWest  AS INTEGER   
  INDEX idxPrim iPosX iPosY
  INDEX idxId iId. 
  
DEFINE VARIABLE giMinX  AS INTEGER NO-UNDO INITIAL ?.  
DEFINE VARIABLE giMaxX  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giMinY  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giMaxY  AS INTEGER NO-UNDO INITIAL ?.
DEFINE VARIABLE giStart AS INTEGER NO-UNDO.
  
FUNCTION setPos RETURNS LOGICAL
  ( piX AS INTEGER
  , piY AS INTEGER
  , pcValue AS CHARACTER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.
  DEFINE VARIABLE iNewId AS INTEGER NO-UNDO.

  FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
  IF NOT AVAILABLE bGrid THEN 
  DO:
    FIND LAST bGrid USE-INDEX idxId NO-ERROR.
    iNewId = (IF AVAILABLE bGrid THEN bGrid.iId ELSE 0) + 1.
    
    CREATE bGrid.
    ASSIGN bGrid.iId    = iNewId
           bGrid.iPosX  = piX
           bGrid.iPosY  = piY
           bGrid.cValue = pcValue.
           
    /* Might need to adjust dimensions */
    IF giMinX = ? OR piX < giMinX THEN giMinX = piX.
    IF giMaxX = ? OR piX > giMaxX THEN giMaxX = piX.
    IF giMinY = ? OR piY < giMinY THEN giMinY = piY.
    IF giMaxY = ? OR piY > giMaxY THEN giMaxY = piY.             
  END.

  bGrid.cValue = pcValue.
  RETURN TRUE.
END FUNCTION.


FUNCTION getValue RETURNS CHARACTER
  ( piX AS INTEGER
  , piY AS INTEGER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
  RETURN (IF NOT AVAILABLE bGrid THEN "?" ELSE bGrid.cValue). 
  
END FUNCTION. /* getValue */


FUNCTION getPoint RETURNS INTEGER
  ( piX AS INTEGER
  , piY AS INTEGER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
  RETURN (IF NOT AVAILABLE bGrid THEN 0 ELSE bGrid.iId). 
  
END FUNCTION. /* getPoint */


FUNCTION findPoint RETURNS INTEGER
  ( pcValue AS CHARACTER
  ):    
  DEFINE BUFFER bGrid FOR ttGrid.

  FIND bGrid WHERE bGrid.cValue = pcValue NO-ERROR.
  RETURN (IF NOT AVAILABLE bGrid THEN 0 ELSE bGrid.iId). 
  
END FUNCTION. /* findPoint */


FUNCTION loadGrid RETURNS LOGICAL 
  ( pcFile AS CHARACTER 
  ): 
  DEFINE VARIABLE cData  AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cVal   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iStart AS INTEGER   NO-UNDO.
  DEFINE BUFFER bGrid FOR ttGrid.

  /* Read data and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giMaxX = LENGTH(ENTRY(1,cData,'~n')).
  giMaxY = NUM-ENTRIES(cData,'~n').

  DO iY = 1 TO giMaxY:
    DO iX = 1 TO giMaxX:
      cVal = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).
      setPos(iX, iY, cVal).
    END.
  END.

  /* find N/E/S/W */
  FOR EACH bGrid:
    bGrid.iNorth = (IF LOOKUP(getValue(bGrid.iPosX    , bGrid.iPosY - 1),"|,F,7") > 0 THEN getPoint(bGrid.iPosX    , bGrid.iPosY - 1) ELSE 0). /* n */
    bGrid.iEast  = (IF LOOKUP(getValue(bGrid.iPosX + 1, bGrid.iPosY    ),"-,J,7") > 0 THEN getPoint(bGrid.iPosX + 1, bGrid.iPosY    ) ELSE 0). /* e */
    bGrid.iSouth = (IF LOOKUP(getValue(bGrid.iPosX    , bGrid.iPosY + 1),"|,J,L") > 0 THEN getPoint(bGrid.iPosX    , bGrid.iPosY + 1) ELSE 0). /* s */
    bGrid.iWest  = (IF LOOKUP(getValue(bGrid.iPosX - 1, bGrid.iPosY    ),"-,F,L") > 0 THEN getPoint(bGrid.iPosX - 1, bGrid.iPosY    ) ELSE 0). /* w */
  END.
  
  /* Start pos */
  FIND bGrid WHERE bGrid.cValue = "S".
  giStart = bGrid.iId.
  
  bGrid.iNorth = (IF LOOKUP(getValue(bGrid.iPosX    , bGrid.iPosY - 1),"|,F,7") > 0 THEN getPoint(bGrid.iPosX    , bGrid.iPosY - 1) ELSE 0). /* n */
  bGrid.iEast  = (IF LOOKUP(getValue(bGrid.iPosX + 1, bGrid.iPosY    ),"-,J,7") > 0 THEN getPoint(bGrid.iPosX + 1, bGrid.iPosY    ) ELSE 0). /* e */
  bGrid.iSouth = (IF LOOKUP(getValue(bGrid.iPosX    , bGrid.iPosY + 1),"|,J,L") > 0 THEN getPoint(bGrid.iPosX    , bGrid.iPosY + 1) ELSE 0). /* s */
  bGrid.iWest  = (IF LOOKUP(getValue(bGrid.iPosX - 1, bGrid.iPosY    ),"-,F,L") > 0 THEN getPoint(bGrid.iPosX - 1, bGrid.iPosY    ) ELSE 0). /* w */
  
END FUNCTION. /* loadGrid */


FUNCTION getPartialGrid RETURNS CHARACTER
  ( piFromX AS INTEGER
  , piFromY AS INTEGER
  , piToX   AS INTEGER
  , piToY   AS INTEGER
  ): 
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cGrid AS LONGCHAR NO-UNDO.

  DO iY = MIN(piFromY,piToY) TO MAX(piFromY,piToY):
    DO iX = MIN(piFromX,piToX) TO MAX(piFromX,piToX):
      cGrid = cGrid + getValue(iX,iY).
    END.
    cGrid = cGrid + "~n".
  END.

  RETURN STRING(cGrid).
END FUNCTION. /* getPartialGrid */


FUNCTION getGrid RETURNS CHARACTER
  ( ): 
  RETURN getPartialGrid(giMinX, giMinY, giMaxX, giMaxY).
END FUNCTION. /* getPartialGrid */

loadGrid("test.txt").

DEFINE VARIABLE cDir AS CHARACTER NO-UNDO.
FIND ttGrid WHERE ttGrid.iId = giStart.

IF      ttGrid.iNorth > 0 THEN cDir = "N".
ELSE IF ttGrid.iEast  > 0 THEN cDir = "E".
ELSE IF ttGrid.iSouth > 0 THEN cDir = "S".
ELSE IF ttGrid.iWest  > 0 THEN cDir = "W".

MESSAGE cDir SKIP getGrid() SKIP
  ttGrid.iNorth
  ttGrid.iEast 
  ttGrid.iSouth
  ttGrid.iWest
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.












