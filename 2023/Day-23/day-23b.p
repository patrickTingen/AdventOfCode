/* AoC 2023 day 23b
*/
DEFINE VARIABLE giNumCols  AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumRows  AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE giNumLocs  AS INTEGER   NO-UNDO.
DEFINE VARIABLE giNumPaths AS INTEGER   NO-UNDO.
DEFINE VARIABLE gcStart    AS CHARACTER NO-UNDO.
DEFINE VARIABLE gcExit     AS CHARACTER NO-UNDO.
DEFINE VARIABLE giDistance AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD cId  AS CHARACTER
  FIELD iCol AS INTEGER /* x-pos    */
  FIELD iRow AS INTEGER /* y-pos    */
  FIELD cVal AS CHARACTER
  FIELD cPath AS CHARACTER
  INDEX iPrim cId
  INDEX iPos iCol iRow. 

DEFINE TEMP-TABLE ttPath NO-UNDO
  FIELD cId      AS CHARACTER FORMAT 'x(4)'  COLUMN-LABEL "Id"
  FIELD cFrom    AS CHARACTER FORMAT 'x(4)'  COLUMN-LABEL "From"
  FIELD cTo      AS CHARACTER FORMAT 'x(4)'  COLUMN-LABEL "To"
  FIELD iFromCol AS INTEGER   FORMAT '>>9'   COLUMN-LABEL "From!Col"
  FIELD iFromRow AS INTEGER   FORMAT '>>9'   COLUMN-LABEL "From!Row"
  FIELD iToCol   AS INTEGER   FORMAT '>>9'   COLUMN-LABEL "To!Col"
  FIELD iToRow   AS INTEGER   FORMAT '>>9'   COLUMN-LABEL "To!Row"
  FIELD cRoute   AS CHARACTER FORMAT "x(210)" COLUMN-LABEL "Route"
  FIELD iSteps   AS INTEGER   FORMAT '>>>9'  COLUMN-LABEL "Steps"
  INDEX iPrim cId.
  
FUNCTION getCoord RETURNS CHARACTER 
  (pcPath AS CHARACTER):
  DEFINE VARIABLE i    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cVal AS CHARACTER NO-UNDO.
  DEFINE BUFFER bLoc FOR ttLoc.
  DO i = 1 TO NUM-ENTRIES(pcPath):
    FIND bLoc WHERE bLoc.cId = ENTRY(i,pcPath).
    cVal = SUBSTITUTE('&1|&2,&3', cVal, bLoc.iCol, bLoc.iRow).
  END.
  RETURN TRIM(cVal,"|").
END FUNCTION. 

/* > 6432 */
RUN readData("test.txt").
RUN findRoutes.

FIND FIRST ttPath.
RUN findHikes(ttPath.cId, ttPath.cId, 0).

OUTPUT TO "debug.txt".
FOR EACH ttPath: 
  FIND ttLoc WHERE ttLoc.cId = ttPath.cFrom.
  ttPath.iFromCol = ttLoc.iCol.
  ttPath.iFromRow = ttLoc.iRow.

  FIND ttLoc WHERE ttLoc.cId = ttPath.cTo.
  ttPath.iToCol = ttLoc.iCol.
  ttPath.iToRow = ttLoc.iRow.

  ttPath.cRoute = getCoord(ttPath.cRoute).

  DISP ttPath.cFrom ttPath.cTo ttPath.cRoute WITH STREAM-IO WIDTH 400. 
END.
OUTPUT CLOSE. 


FUNCTION getRoute RETURNS CHARACTER 
  ( pcPath AS CHARACTER ):

  /* Get route from a given point to either 
  ** the start/exit or another crossing
  */
  DEFINE BUFFER bThis  FOR ttLoc.
  DEFINE BUFFER bOther FOR ttLoc.

  DEFINE VARIABLE cHere AS CHARACTER NO-UNDO.
  
  cHere = ENTRY(NUM-ENTRIES(pcPath),pcPath).
  FIND bThis WHERE bThis.cId = cHere.

  #Walk:
  REPEAT:
    PROCESS EVENTS. 
    FIND bThis WHERE bThis.cId = cHere.
  
    FOR EACH bOther
      WHERE (bOther.iCol = bThis.iCol - 1 AND bOther.iRow = bThis.iRow    )
         OR (bOther.iCol = bThis.iCol + 1 AND bOther.iRow = bThis.iRow    )
         OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow - 1)
         OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow + 1) :
      
      IF LOOKUP(bOther.cId, pcPath) > 0 THEN NEXT. /* been there before */
      IF CAN-FIND(FIRST ttPath WHERE ttPath.cFrom = cHere) THEN LEAVE #Walk. /* other crossing */

      cHere = bOther.cId.
      pcPath = SUBSTITUTE("&1,&2", pcPath, cHere). /* add this tile to the path */
      IF cHere = gcExit OR cHere = gcStart THEN LEAVE #Walk. /* exit */ 

      NEXT #Walk.
    END.
  END.

  RETURN pcPath.
END FUNCTION. /* getRoute */


PROCEDURE findRoutes:
  /* Find all routes in the maze from 
  ** one crossing to another
  */
  DEFINE VARIABLE iNumPaths AS INTEGER NO-UNDO.

  DEFINE BUFFER bThis  FOR ttLoc.
  DEFINE BUFFER bOther FOR ttLoc.
  DEFINE BUFFER bPath  FOR ttPath.
  DEFINE BUFFER bPath2 FOR ttPath.
  
  /* Find all crossings */
  FOR EACH bThis:
  
    iNumPaths = 0.
    FOR EACH bOther
      WHERE (bOther.iCol = bThis.iCol - 1 AND bOther.iRow = bThis.iRow    )
         OR (bOther.iCol = bThis.iCol + 1 AND bOther.iRow = bThis.iRow    )
         OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow - 1)
         OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow + 1):
      
      iNumPaths = iNumPaths + 1.
    END.

    IF iNumPaths > 2 OR bThis.cId = gcStart THEN 
    DO:
      FOR EACH bOther
        WHERE (bOther.iCol = bThis.iCol - 1 AND bOther.iRow = bThis.iRow    )
           OR (bOther.iCol = bThis.iCol + 1 AND bOther.iRow = bThis.iRow    )
           OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow - 1)
           OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow + 1) :
  
        giNumPaths = giNumPaths + 1.
        CREATE bPath.
        ASSIGN 
          bPath.cId    = STRING(giNumPaths)
          bPath.cFrom  = bThis.cId
          bPath.cRoute = SUBSTITUTE("&1,&2", bThis.cId,bOther.cId).
      END.
    END.
  END.

  FOR EACH bPath:
    bPath.cRoute = getRoute(bPath.cRoute).
    bPath.iSteps = NUM-ENTRIES(bPath.cRoute) - 1.
    bPath.cTo    = ENTRY(NUM-ENTRIES(bPath.cRoute),bPath.cRoute).    
  END.

END PROCEDURE. /* findRoutes */


PROCEDURE findHikes:
  DEFINE INPUT PARAMETER pcId     AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcPath   AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER piLength AS INTEGER   NO-UNDO.

  DEFINE BUFFER bThis  FOR ttPath.
  DEFINE BUFFER bOther FOR ttPath.

  FIND bThis WHERE bThis.cId = pcId.
  .MESSAGE pcId "/" bThis.cFrom bThis.cTo SKIP pcPath SKIP piLength VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

  PROCESS EVENTS.

  /* Found exit? */
  IF bThis.cTo = gcExit THEN 
  DO:
    giDistance = MAX(giDistance, piLength + bThis.iSteps).
    HIDE MESSAGE NO-PAUSE. 
    MESSAGE giDistance .
    RETURN.
  END.

  /* Examine the neighbours */
  FOR EACH bOther
    WHERE bOther.cFrom = bThis.cTo:

    IF LOOKUP(bOther.cFrom, pcPath) > 0 THEN NEXT. /* been there before */

    RUN findHikes( bOther.cId
                 , SUBSTITUTE("&1,&2", pcPath, bOther.cFrom)
                 , piLength + bOther.iSteps
                 ).
  END.

END PROCEDURE. /* findHikes */


PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cTxt  AS CHARACTER NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Read file and strip nasty characters */
  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').
  
  /* For part b, slopes are not interesting */
  cData = REPLACE(cData,">",".").
  cData = REPLACE(cData,"<",".").
  cData = REPLACE(cData,"v",".").
  cData = REPLACE(cData,"^",".").

  /* Max dimensions of playing field */
  giNumCols = LENGTH(ENTRY(1,cData,'~n')).
  giNumRows = NUM-ENTRIES(cData,'~n').

  DO iY = 1 TO giNumRows:
    DO iX = 1 TO giNumCols:

      cTxt = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).
      IF cTxt = "#" THEN NEXT. /* Walls not needed */

      giNumLocs = giNumLocs + 1.
      CREATE bLoc.
      ASSIGN 
        bLoc.cId  = STRING(giNumLocs)
        bLoc.iCol = iX 
        bLoc.iRow = iY 
        bLoc.cVal = cTxt.

      /* start and exit */
      IF bLoc.iRow = 1 THEN gcStart = bLoc.cId.
      IF bLoc.iRow = giNumRows THEN gcExit = bLoc.cId.

    END. /* iX */
  END. /* iY */

END PROCEDURE. /* readData */
