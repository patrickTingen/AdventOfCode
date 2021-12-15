/* AoC 2021 day 15a + b
 */ 
DEFINE VARIABLE giExit   AS INTEGER NO-UNDO.
DEFINE VARIABLE iNewDist AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD iLocNr  AS INTEGER
  FIELD iPosX   AS INTEGER /* x-pos  */
  FIELD iPosY   AS INTEGER /* y-pos  */
  FIELD iDist   AS INTEGER /* risk   */
  FIELD cStatus AS CHARACTER
  FIELD iTotal  AS INTEGER
  INDEX iPrim iPosX iPosY
  INDEX iTodo cStatus iTotal. 

DEFINE BUFFER bLoc FOR ttLoc. 

/* Part 1 */
RUN readData(1).
RUN findExit(1).

/* Part 2 */ 
RUN readData(5).
RUN findExit(2).

PROCEDURE findExit:
  DEFINE INPUT PARAMETER piPart AS INTEGER NO-UNDO.

  /* Init */
  FIND ttLoc WHERE ttLoc.iLocNr = 1.
  ttLoc.iTotal = 0.
  ttLoc.cStatus = "Todo".

  #Main:
  REPEAT:        
    
    /* Find the most promising location */
    FIND FIRST ttLoc WHERE ttLoc.cStatus = "Todo" NO-ERROR.
    IF NOT AVAILABLE ttLoc THEN LEAVE #Main.

    /* Show that we're busy */
    PROCESS EVENTS. 
    IF ETIME > 1000 THEN DO:
      HIDE MESSAGE NO-PAUSE.
      MESSAGE "Part" piPart "x,y" ttLoc.iPosX ttLoc.iPosY.
      ETIME(YES).
    END.

    /* Found exit? */
    IF ttLoc.iLocNr = giExit THEN 
    DO:
      MESSAGE "Part:" piPart "Risk:" ttLoc.iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 824 / 3063 */
      LEAVE #Main.
    END.

    /* Examine the neighbours */
    FOR EACH bLoc
      WHERE (bLoc.iPosX = ttLoc.iPosX - 1 AND bLoc.iPosY = ttLoc.iPosY    )
         OR (bLoc.iPosX = ttLoc.iPosX + 1 AND bLoc.iPosY = ttLoc.iPosY    )
         OR (bLoc.iPosX = ttLoc.iPosX     AND bLoc.iPosY = ttLoc.iPosY - 1)
         OR (bLoc.iPosX = ttLoc.iPosX     AND bLoc.iPosY = ttLoc.iPosY + 1):

      iNewDist = (ttLoc.iTotal + bLoc.iDist).

      CASE bLoc.cStatus:
        WHEN "Done" THEN NEXT.
        WHEN "Wait" THEN ASSIGN bLoc.iTotal  = iNewDist
                                bLoc.cStatus = "Todo".
        WHEN "Todo" THEN IF iNewDist < bLoc.iTotal THEN bLoc.iTotal = iNewDist.
      END CASE.
    END.

    ttLoc.cStatus = "Done".
  END. /* main */

END PROCEDURE. /* findExit */


PROCEDURE readData:
  /* Load data into TT
  */
  DEFINE INPUT PARAMETER piSize AS INTEGER NO-UNDO.

  DEFINE VARIABLE gcData    AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE iX        AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iY        AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iNr       AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iMaxX     AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iMaxY     AS INTEGER  NO-UNDO.
  DEFINE VARIABLE i         AS INTEGER  NO-UNDO.
  DEFINE VARIABLE iNewDist  AS INTEGER  NO-UNDO.

  DEFINE BUFFER bLoc  FOR ttLoc. 
  DEFINE BUFFER bLoc2 FOR ttLoc.

  COPY-LOB FILE "data.txt" TO gcData.

  /* Strip nasty characters */
  gcData = TRIM(REPLACE(gcData,'~r',''),'~n').

  /* Max dimensions of playing field */
  iMaxX = LENGTH(ENTRY(1,gcData,'~n')).
  iMaxY = NUM-ENTRIES(gcData,'~n').

  EMPTY TEMP-TABLE ttLoc. 

  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:

       iNr = iNr + 1.
       CREATE bLoc.
       ASSIGN 
         bLoc.iLocNr  = iNr
         bLoc.iPosX   = iX 
         bLoc.iPosY   = iY 
         bLoc.iDist   = INTEGER(SUBSTRING(ENTRY(iY, gcData, '~n'), iX, 1))
         bLoc.iTotal  = (iMaxX * iMaxY * piSize * piSize)
         bLoc.cStatus = "Wait"
         .
    END. /* iX */
  END. /* iY */

  /* Copy */
  IF piSize > 1 THEN 
  DO:
    /* Copy right */
    FOR EACH bLoc WHERE bLoc.iPosX <= iMaxX:
      iNewDist = bLoc.iDist.

      DO i = 1 TO (piSize - 1):
        iNewDist = iNewDist + 1.
        IF iNewDist > 9 THEN iNewDist = 1.

        iNr = iNr + 1.
        CREATE bLoc2.
        BUFFER-COPY bLoc TO bLoc2 ASSIGN bLoc2.iLocNr = iNr.
        bLoc2.iPosX = bLoc.iPosX + (i * iMaxX).
        bLoc2.iDist = iNewDist.
      END. /* i */
    END. /* FOR EACH bLoc */

    /* Copy down */
    FOR EACH bLoc WHERE bLoc.iPosY <= iMaxY:
      iNewDist = bLoc.iDist.

      DO i = 1 TO (piSize - 1):
        iNewDist = iNewDist + 1.
        IF iNewDist > 9 THEN iNewDist = 1.

        iNr = iNr + 1.
        CREATE bLoc2.
        BUFFER-COPY bLoc TO bLoc2 ASSIGN bLoc2.iLocNr = iNr.
        bLoc2.iPosY = bLoc.iPosY + (i * iMaxY).
        bLoc2.iDist = iNewDist.
      END. /* i */
    END. /* FOR EACH bLoc */
  END.
  
  /* Remember the location of the exit */
  giExit = iNr.

END PROCEDURE. /* readData */
