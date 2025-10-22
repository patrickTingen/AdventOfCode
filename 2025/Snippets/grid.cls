/* Grid.cls
*/
CLASS Grid:

DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iId    AS INTEGER /* unique id */
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  INDEX idxPrim iPosX iPosY
  INDEX idxId iId. 

  DEFINE PUBLIC PROPERTY iMinX AS INTEGER NO-UNDO INITIAL ?
    GET: RETURN iMinX. END GET.
    PRIVATE SET.

  DEFINE PUBLIC PROPERTY iMinY AS INTEGER NO-UNDO INITIAL ?
    GET: RETURN iMinY. END GET.
    PRIVATE SET.
  
  DEFINE PUBLIC PROPERTY iMaxX AS INTEGER NO-UNDO INITIAL ? 
    GET: RETURN iMaxX. END GET. 
    PRIVATE SET.

  DEFINE PUBLIC PROPERTY iMaxY AS INTEGER NO-UNDO INITIAL ? 
    GET: RETURN iMaxY. END GET. 
    PRIVATE SET.   
    

  CONSTRUCTOR Grid
    ( pcFile AS CHARACTER
    ):
    /* Read a text file as grid
    */
    DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
    DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
    DEFINE VARIABLE cVal  AS CHARACTER NO-UNDO.
  
    /* Read data and strip nasty characters */
    COPY-LOB FILE pcFile TO cData.
    cData = TRIM(REPLACE(cData,'~r',''),'~n').

    /* Max dimensions of playing field */
    THIS-OBJECT:iMaxX = LENGTH(ENTRY(1,cData,'~n')).
    THIS-OBJECT:iMaxY = NUM-ENTRIES(cData,'~n').
    
    DO iY = 1 TO THIS-OBJECT:iMaxY:
      DO iX = 1 TO THIS-OBJECT:iMaxX:
        cVal = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).
        THIS-OBJECT:pos(iX, iY, cVal).
      END.
    END.
    
    THIS-OBJECT:find-neighbours().
  END CONSTRUCTOR.  
  

  /* Return element at position x,y 
  */
  METHOD PUBLIC CHARACTER pos 
    ( piX AS INTEGER
    , piY AS INTEGER
    ):
    DEFINE BUFFER bGrid FOR ttGrid.
  
    FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
    RETURN (IF AVAILABLE bGrid THEN bGrid.cValue ELSE '?').
  END METHOD. 


  /* Set value for element at x,y 
  */
  METHOD PUBLIC CHARACTER pos 
    ( piX AS INTEGER
    , piY AS INTEGER
    , pcValue AS CHARACTER
    ):    
    DEFINE BUFFER bGrid FOR ttGrid.
    DEFINE VARIABLE iNewId AS INTEGER   NO-UNDO.
  
    FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
    IF NOT AVAILABLE bGrid THEN 
    DO:
      FIND LAST bGrid USE-INDEX idxId NO-ERROR.
      iNewId = (IF AVAILABLE bGrid THEN bGrid.iId ELSE 0) + 1.
      
      CREATE bGrid.
      ASSIGN bGrid.iId   = iNewId
             bGrid.iPosX = piX
             bGrid.iPosY = piY.
             
      /* Might need to adjust dimensions */
      IF THIS-OBJECT:iMinX = ? OR piX < THIS-OBJECT:iMinX THEN THIS-OBJECT:iMinX = piX.
      IF THIS-OBJECT:iMaxX = ? OR piX > THIS-OBJECT:iMaxX THEN THIS-OBJECT:iMaxX = piX.
      IF THIS-OBJECT:iMinY = ? OR piY < THIS-OBJECT:iMinY THEN THIS-OBJECT:iMinY = piY.
      IF THIS-OBJECT:iMaxY = ? OR piY > THIS-OBJECT:iMaxY THEN THIS-OBJECT:iMaxY = piY.             
    END.

    bGrid.cValue = pcValue.
    RETURN pcValue.
  END METHOD. /* pos */

  
  /* Return full grid as longchar
  */
  METHOD PUBLIC LONGCHAR getGrid():
    RETURN THIS-OBJECT:getGrid(THIS-OBJECT:iMinX, THIS-OBJECT:iMinY, THIS-OBJECT:iMaxX, THIS-OBJECT:iMaxY).
  END METHOD. /* getGrid */


  /* Return part of grid as longchar
  */
  METHOD PUBLIC LONGCHAR getGrid 
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
        cGrid = cGrid + THIS-OBJECT:pos(iX,iY).
      END.
      cGrid = cGrid + "~n".
    END.

    RETURN cGrid.
  END METHOD. /* getGrid */
  
  
  /* For debugging 
  */
  METHOD OVERRIDE PUBLIC CHARACTER toString():
    RETURN STRING(SUBSTRING(THIS-OBJECT:getGrid(),1, 20000)).
  END METHOD.

  
  METHOD PUBLIC CHARACTER findValue 
    ( pcValue AS CHARACTER ):
    
    DEFINE BUFFER bGrid FOR ttGrid.
    FIND FIRST bGrid WHERE bGrid.cValue = pcValue NO-ERROR.
    IF AVAILABLE bGrid THEN
      RETURN SUBSTITUTE("&1,&2", bGrid.iPosX, bGrid.iPosY).
    ELSE
      RETURN "?,?".
  END METHOD.   
  
  
  METHOD PUBLIC VOID find-neighbours():
    DEFINE BUFFER bGrid FOR ttGrid.
    
    FOR EACH bGrid:
      
    END.    
  
  END METHOD.  
  
END CLASS. /* Grid */

