/* AoC 2021 day 09b
 */ 
DEFINE VARIABLE gcData AS LONGCHAR NO-UNDO.
DEFINE VARIABLE giMaxX AS INTEGER  NO-UNDO.
DEFINE VARIABLE giMaxY AS INTEGER  NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iPosX  AS INTEGER /* x-pos  */
  FIELD iPosY  AS INTEGER /* y-pos  */
  FIELD iBasin AS INTEGER /* basin  */
  INDEX iPrim iPosX iPosY. 

DEFINE TEMP-TABLE ttBasin
  FIELD iBasin AS INTEGER
  FIELD iSize AS INTEGER.

/* Main
*/
RUN initObject.
RUN calcBasins.
RUN calcAnswer.


PROCEDURE calcBasins:
  /* Assign all basins 
  */
  DEFINE VARIABLE iBasin AS INTEGER NO-UNDO.
  DEFINE BUFFER bLoc FOR ttLoc. 

  REPEAT:
    FIND FIRST bLoc WHERE bLoc.iBasin = 0 NO-ERROR.
    IF NOT AVAILABLE bLoc THEN LEAVE. 
  
    iBasin = iBasin + 1.
    RUN setBasin(bLoc.iPosX, bLoc.iPosY, iBasin).
  END.
END PROCEDURE. /* calcBasins */


PROCEDURE setBasin:
  /* Assign basin nr to a location and its adjacent locations 
  */
  DEFINE INPUT  PARAMETER piPosX  AS INTEGER  NO-UNDO.
  DEFINE INPUT  PARAMETER piPosY  AS INTEGER  NO-UNDO.
  DEFINE INPUT  PARAMETER piBasin AS INTEGER  NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* If not a valid location or it is already processed or a border, go back */
  FIND bLoc WHERE bLoc.iPosX = piPosX AND bLoc.iPosY = piPosY NO-ERROR.
  IF NOT AVAILABLE bLoc OR bLoc.iBasin <> 0 THEN RETURN. 
  bLoc.iBasin = piBasin.

  /* Add surrounding locations to this basin */
  RUN setBasin(piPosX - 1, piPosY, piBasin).
  RUN setBasin(piPosX + 1, piPosY, piBasin).
  RUN setBasin(piPosX, piPosY - 1, piBasin).
  RUN setBasin(piPosX, piPosY + 1, piBasin).

END PROCEDURE. /* setBasin */


PROCEDURE calcAnswer:
  /* Find largest 3 
  */
  DEFINE VARIABLE iScore     AS INTEGER NO-UNDO INITIAL 1.
  DEFINE VARIABLE iNumBasins AS INTEGER NO-UNDO.
  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Calc size of basins */
  FOR EACH bLoc WHERE bLoc.iBasin <> -1 BREAK BY bLoc.iBasin:
    IF FIRST-OF(bLoc.iBasin) THEN 
    DO:
      CREATE ttBasin. 
      ttBasin.iBasin = bLoc.iBasin.
    END.
    ttBasin.iSize = ttBasin.iSize + 1.
  END.
  
  /* Find largest 3 and multiply */
  FOR EACH ttBasin BY ttBasin.iSize DESCENDING: 
    iNumBasins = iNumBasins + 1.
    IF iNumBasins <= 3 THEN iScore = iScore * ttBasin.iSize.
  END.
  
  MESSAGE iScore ETIME VIEW-AS ALERT-BOX INFO BUTTONS OK. /* 900864 */
END PROCEDURE. /* calcAnswer */


PROCEDURE initObject:
  /* Load data into TT
  */
  DEFINE VARIABLE iX AS INTEGER NO-UNDO.
  DEFINE VARIABLE iY AS INTEGER NO-UNDO.
  DEFINE BUFFER bLoc FOR ttLoc. 

  COPY-LOB FILE "data.txt" TO gcData.

  /* Strip nasty characters */
  gcData = TRIM(REPLACE(gcData,'~r',''),'~n').

  /* Max dimensions of playing field */
  giMaxX = LENGTH(ENTRY(1,gcData,'~n')).
  giMaxY = NUM-ENTRIES(gcData,'~n').

  DO iY = 1 TO giMaxY:
    DO iX = 1 TO giMaxX:
      CREATE bLoc.
      ASSIGN 
        bLoc.iPosX = iX
        bLoc.iPosY = iY
        bLoc.iBasin = (IF SUBSTRING(ENTRY(iY, gcData, '~n'), iX, 1) = '9' THEN -1 ELSE 0).
    END.
  END.

END PROCEDURE. /* initObject */
