/* Algorithm to find exit in longest possible way
 */ 
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

RUN readData("test2.txt").
RUN findExit(gcStart, gcStart).
MESSAGE "Max route is" giDistance "steps" VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


PROCEDURE findExit:
  DEFINE INPUT PARAMETER pcId   AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcPath AS CHARACTER NO-UNDO.

  DEFINE BUFFER bThis  FOR ttLoc.
  DEFINE BUFFER bOther FOR ttLoc.

  FIND bThis WHERE bThis.cId = pcId.

  /* Found exit? */
  IF bThis.cId = gcExit THEN 
  DO:
    giDistance = MAX(giDistance, NUM-ENTRIES(pcPath) - 1).
    RETURN.
  END.

  /* Examine the neighbours */
  FOR EACH bOther
    WHERE (bOther.iCol = bThis.iCol - 1 AND bOther.iRow = bThis.iRow     AND bOther.cVal <> ">")
       OR (bOther.iCol = bThis.iCol + 1 AND bOther.iRow = bThis.iRow     AND bOther.cVal <> "<")
       OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow - 1 AND bOther.cVal <> "v")
       OR (bOther.iCol = bThis.iCol     AND bOther.iRow = bThis.iRow + 1 AND bOther.cVal <> "^") :

    IF LOOKUP(bOther.cVal,".,v,^,<,>") = 0 THEN NEXT. /* not a path */
    IF LOOKUP(bOther.cId, pcPath) > 0 THEN NEXT. /* been there before */
    
    RUN findExit(bOther.cId, SUBSTITUTE("&1,&2", pcPath,bOther.cId)).
  END.

END PROCEDURE. /* findExit */


PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.
  
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  COPY-LOB FILE pcFile TO cData.

  /* Strip nasty characters */
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').

  EMPTY TEMP-TABLE ttLoc. 

  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:

      iNr = iNr + 1.
      CREATE bLoc.
      ASSIGN 
        bLoc.cId  = STRING(iNr)
        bLoc.iCol = iX 
        bLoc.iRow = iY 
        bLoc.cVal = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).

      CASE bLoc.cVal :
        WHEN 'S' THEN ASSIGN gcStart = bLoc.cId bLoc.cVal = ".".
        WHEN 'E' THEN ASSIGN gcExit  = bLoc.cId bLoc.cVal = ".".
      END CASE.

    END. /* iX */
  END. /* iY */

END PROCEDURE. /* readData */

