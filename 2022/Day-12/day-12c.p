/* AoC 2022 day 12a + b combined
 */ 
DEFINE VARIABLE giStart AS INTEGER NO-UNDO.
DEFINE VARIABLE giExit  AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iLocNr  AS INTEGER
  FIELD iPosX   AS INTEGER
  FIELD iPosY   AS INTEGER
  FIELD iDist   AS INTEGER
  FIELD cStatus AS CHARACTER
  FIELD iTotal  AS INTEGER
  INDEX iPrim iPosX iPosY
  INDEX iTodo cStatus iTotal. 

/* Part A 
*/
RUN readData.
RUN findExit("A").

/* Part B 
*/
RUN readData.

FOR EACH ttLoc WHERE ttLoc.iDist = 1:
  ttLoc.cStatus = "Todo".
END.
RUN findExit("B").


PROCEDURE findExit:
  DEFINE INPUT PARAMETER pcPart AS CHARACTER NO-UNDO.

  DEFINE VARIABLE iNewDistance AS INTEGER NO-UNDO.

  DEFINE BUFFER bThis  FOR ttLoc.
  DEFINE BUFFER bOther FOR ttLoc.

  #Main:
  REPEAT:        
    
    /* Find the most promising location */
    FIND FIRST bThis WHERE bThis.cStatus = "Todo" NO-ERROR.
    IF NOT AVAILABLE bThis THEN LEAVE #Main.

    /* Found exit? */
    IF bThis.iLocNr = giExit THEN
    DO:
      MESSAGE "Part" pcPart + ":" bThis.iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. 
      RETURN. 
    END.

    /* Examine the neighbours */
    FOR EACH bOther
      WHERE (bOther.iPosX = bThis.iPosX - 1 AND bOther.iPosY = bThis.iPosY    )
         OR (bOther.iPosX = bThis.iPosX + 1 AND bOther.iPosY = bThis.iPosY    )
         OR (bOther.iPosX = bThis.iPosX     AND bOther.iPosY = bThis.iPosY - 1)
         OR (bOther.iPosX = bThis.iPosX     AND bOther.iPosY = bThis.iPosY + 1):

      IF bOther.iDist > (bThis.iDist + 1) THEN NEXT. /* too high */
      
      iNewDistance = bThis.iTotal + 1.

      CASE bOther.cStatus:
        WHEN "Done" THEN NEXT.
        WHEN "Wait" THEN ASSIGN bOther.iTotal  = iNewDistance
                                bOther.cStatus = "Todo".
        WHEN "Todo" THEN IF iNewDistance < bOther.iTotal THEN bThis.iTotal = iNewDistance.
      END CASE.
    END.

    bThis.cStatus = "Done".
  END. /* main */

END PROCEDURE. /* findExit */


PROCEDURE readData:
  /* Load data into TT
  */
  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE cLoc  AS CHARACTER NO-UNDO CASE-SENSITIVE.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO.

  DEFINE BUFFER bLoc FOR ttLoc. 

  /* Read file and strip nasty characters */
  COPY-LOB FILE "data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').

  EMPTY TEMP-TABLE ttLoc. 

  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:

      cLoc = SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1).

      iNr = iNr + 1.
      CREATE bLoc.
      ASSIGN 
        bLoc.iLocNr  = iNr
        bLoc.iPosX   = iX 
        bLoc.iPosY   = iY 
        bLoc.iTotal  = 0
        bLoc.cStatus = (IF cLoc = "S" THEN "Todo" ELSE "Wait").

      CASE cLoc:
        WHEN 'S' THEN ASSIGN bLoc.iDist = 1  giStart = iNr.
        WHEN 'E' THEN ASSIGN bLoc.iDist = 26 giExit  = iNr.
        OTHERWISE     ASSIGN bLoc.iDist = ASC(cLoc) - 96.
      END CASE.

    END. /* iX */
  END. /* iY */

END PROCEDURE. /* readData */

