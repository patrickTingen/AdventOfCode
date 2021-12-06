/* AoC 2021 day 04 
 */ 
DEFINE TEMP-TABLE ttCard
  FIELD iCard     AS INTEGER
  FIELD iBingoRow AS INTEGER
  FIELD iBingoCol AS INTEGER
  INDEX iPrim iCard.

DEFINE TEMP-TABLE ttNr 
  FIELD iCard  AS INTEGER
  FIELD iRow   AS INTEGER
  FIELD iCol   AS INTEGER
  FIELD iNr    AS INTEGER
  FIELD lDrawn AS LOGICAL
  INDEX iPrim iCard iRow iCol
  INDEX iNr iNr
  INDEX iRow iCard iRow lDrawn
  INDEX iCol iCard iCol lDrawn
  .

DEFINE BUFFER bCard FOR ttCard. 

DEFINE VARIABLE cNrList  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNumber  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTurn    AS INTEGER   NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCardNr  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRowNr   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iColNr   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFullRow AS INTEGER   NO-UNDO EXTENT 5.
DEFINE VARIABLE iTotal   AS INTEGER   NO-UNDO.
DEFINE VARIABLE lOneDone AS LOGICAL   NO-UNDO.

INPUT FROM data.txt.
IMPORT UNFORMATTED cNrList.

REPEAT:  
  IMPORT ^.
  iCardNr = iCardNr + 1.

  DO iRowNr = 1 TO 5:
    IMPORT iFullRow.

    IF iRowNr = 1 THEN
    DO:
      CREATE ttCard.
      ASSIGN ttCard.iCard = iCardNr.
    END.

    DO iColNr = 1 TO 5:
      CREATE ttNr.
      ASSIGN 
        ttNr.iCard = iCardNr
        ttNr.iRow  = iRowNr
        ttNr.iCol  = iColNr
        ttNr.iNr   = iFullRow[iColNr].
    END.
  END.
END.

#Game:
DO iTurn = 1 TO NUM-ENTRIES(cNrList):
  iNumber = INTEGER(ENTRY(iTurn,cNrList)).

  FOR EACH ttNr WHERE ttNr.iNr = iNumber:
    ttNr.lDrawn = TRUE.
  END.

  IF iTurn >= 5 THEN 
  FOR EACH bCard:

    DO i = 1 TO 5:
      IF    CAN-FIND(FIRST ttNr WHERE ttNr.iCard = bCard.iCard AND ttNr.iRow = i AND ttNr.lDrawn = TRUE)
        AND NOT CAN-FIND(FIRST ttNr WHERE ttNr.iCard = bCard.iCard AND ttNr.iRow = i AND ttNr.lDrawn = FALSE) THEN bCard.iBingoRow = i.

      IF    CAN-FIND(FIRST ttNr WHERE ttNr.iCard = bCard.iCard AND ttNr.iCol = i AND ttNr.lDrawn = TRUE)
        AND NOT CAN-FIND(FIRST ttNr WHERE ttNr.iCard = bCard.iCard AND ttNr.iCol = i AND ttNr.lDrawn = FALSE) THEN bCard.iBingoCol = i.
    END.
  
    IF bCard.iBingoRow > 0 OR bCard.iBingoCol > 0 THEN
    DO:
      iTotal = 0.
      FOR EACH ttNr WHERE ttNr.iCard = bCard.iCard AND ttNr.lDrawn = FALSE:
        iTotal = iTotal + ttNr.iNr. 
      END.
      
      IF NOT lOneDone THEN 
      DO:
        MESSAGE "Part 1" iTotal * iNumber VIEW-AS ALERT-BOX INFO BUTTONS OK.
        lOneDone = TRUE.
      END.
      ELSE IF NOT CAN-FIND(FIRST ttCard WHERE ttCard.iCard <> bCard.iCard) THEN
      DO:
        MESSAGE "Part 2" iTotal * iNumber VIEW-AS ALERT-BOX INFO BUTTONS OK.
        LEAVE #Game.
      END.

      FOR EACH ttNr WHERE ttNr.iCard = bCard.iCard: 
        DELETE ttNr.
      END.
      DELETE bCard.
    END.
  END.
END.

/* For debugging */
PROCEDURE dumpData:
  DEFINE BUFFER bNr FOR ttNr.
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.

  OUTPUT TO dbg.txt.
  FOR EACH bNr BREAK BY bNr.iCard BY bNr.iRow BY bNr.iCol:

    IF FIRST-OF(bNr.iCard) THEN
      PUT UNFORMATTED SKIP(1) "Card:" bNr.iCard SKIP.

    IF bNr.lDrawn THEN
      PUT UNFORMATTED STRING(bNr.iNr," [>9] ").
    ELSE
      PUT UNFORMATTED STRING(bNr.iNr,"  >9  ").

    IF LAST-OF(bNr.iRow) THEN PUT UNFORMATTED SKIP.
  END.
  OUTPUT CLOSE.

END PROCEDURE. 
