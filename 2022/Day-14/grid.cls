/* Grid.cls
*/
CLASS Grid:

DEFINE TEMP-TABLE ttGrid NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD cValue AS CHARACTER
  INDEX iPrim iPosX iPosY. 

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

  METHOD PUBLIC LOGICAL addLine(piFromX AS INTEGER, piFromY AS INTEGER, piToX AS INTEGER, piToY AS INTEGER):
    /* Read a text file as grid
    */
    DEFINE VARIABLE iX AS INTEGER NO-UNDO.
    DEFINE VARIABLE iY AS INTEGER NO-UNDO.
  
    DO iY = MIN(piFromY,piToY) TO MAX(piFromY,piToY):
      DO iX = MIN(piFromX,piToX) TO MAX(piFromX,piToX):
        THIS-OBJECT:pos(iX,iY,"#").
      END.
    END.
  END METHOD.

  /* Return element at position x,y 
  */
  METHOD PUBLIC CHARACTER pos (piX AS INTEGER, piY AS INTEGER):
    DEFINE BUFFER bGrid FOR ttGrid.
  
    FIND bGrid WHERE bGrid.iPosX = piX AND bGrid.iPosY = piY NO-ERROR.
    RETURN (IF AVAILABLE bGrid THEN bGrid.cValue ELSE ".").
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

      /* Dimensions of playing field */
      IF THIS-OBJECT:iMinX = ? OR piX < THIS-OBJECT:iMinX THEN THIS-OBJECT:iMinX = piX.
      IF THIS-OBJECT:iMaxX = ? OR piX > THIS-OBJECT:iMaxX THEN THIS-OBJECT:iMaxX = piX.
      IF THIS-OBJECT:iMinY = ? OR piY < THIS-OBJECT:iMinY THEN THIS-OBJECT:iMinY = piY.
      IF THIS-OBJECT:iMaxY = ? OR piY > THIS-OBJECT:iMaxY THEN THIS-OBJECT:iMaxY = piY.
    END.

    bGrid.cValue = pcValue.
    RETURN pcValue.
  END METHOD. 


  /* Set value for element at x,y 
  */
  METHOD PUBLIC LONGCHAR getGrid():
    RETURN THIS-OBJECT:getGrid(THIS-OBJECT:iMinX, THIS-OBJECT:iMinY, THIS-OBJECT:iMaxX, THIS-OBJECT:iMaxY).
  END METHOD.


  METHOD PUBLIC LONGCHAR getGrid (piFromX AS INTEGER, piFromY AS INTEGER, piToX AS INTEGER, piToY AS INTEGER):

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
  END METHOD. 

END CLASS. /* Grid */


