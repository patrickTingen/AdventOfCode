/* Grid.cls
*/
CLASS Grid:

DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  INDEX iPrim iPosX iPosY. 

  DEFINE PUBLIC PROPERTY iMaxX AS INTEGER NO-UNDO 
    GET: RETURN iMaxX. END GET. 
    PRIVATE SET.

  DEFINE PUBLIC PROPERTY iMaxY AS INTEGER NO-UNDO 
    GET: RETURN iMaxY. END GET. 
    PRIVATE SET.

  CONSTRUCTOR Grid(pcFile AS CHARACTER):
    /* Read a text file as grid
    */
    DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
    DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
    DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  
    DEFINE BUFFER bGrid FOR ttGrid. 
    
    /* Read data and strip nasty characters */
    COPY-LOB FILE pcFile TO cData.
    cData = TRIM(REPLACE(cData,'~r',''),'~n').
  
    /* Max dimensions of playing field */
    THIS-OBJECT:iMaxX = LENGTH(ENTRY(1,cData,'~n')).
    THIS-OBJECT:iMaxY = NUM-ENTRIES(cData,'~n').
    
    DO iY = 1 TO THIS-OBJECT:iMaxY:
      DO iX = 1 TO THIS-OBJECT:iMaxX:
        CREATE bGrid.
        ASSIGN 
          bGrid.iPosX  = iX
          bGrid.iPosY  = iY
          bGrid.cValue = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).
      END.
    END.
  END CONSTRUCTOR.
  

  /* Return element at position x,y 
  */
  METHOD PUBLIC CHARACTER pos (piX AS INTEGER, piY AS INTEGER):
    DEFINE BUFFER bGrid FOR ttGrid.
  
    FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
    RETURN (IF AVAILABLE bGrid THEN bGrid.cValue ELSE ?).
  END METHOD. 


  /* Set value for element at x,y 
  */
  METHOD PUBLIC CHARACTER pos (piX AS INTEGER, piY AS INTEGER, pcValue AS CHARACTER):
    DEFINE BUFFER bGrid FOR ttGrid.
  
    FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
    IF NOT AVAILABLE bGrid THEN 
    DO:
      CREATE bGrid.
      ASSIGN bGrid.iPosX = piX
             bGrid.iPosY = piY.
    END.

    bGrid.cValue = pcValue.
    RETURN pcValue.
  END METHOD. 


END CLASS. /* Grid */
