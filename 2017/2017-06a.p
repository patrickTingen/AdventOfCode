/*------------------------------------------------------------------------
    File        : 2017-06a.p
    Purpose     : Day 6 of AoC 2017

    12-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

/* DEFINE VARIABLE iBank   AS INTEGER   NO-UNDO EXTENT 4 INITIAL [0,2,7,0]. */
DEFINE VARIABLE iBank   AS INTEGER   NO-UNDO EXTENT 16 INITIAL [5,1,10,0,1,7,13,14,3,12,8,10,7,12,0,6].  
DEFINE VARIABLE iNr     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iVal    AS INTEGER   NO-UNDO.
DEFINE VARIABLE ii      AS INTEGER     NO-UNDO.
DEFINE VARIABLE iRedist AS INTEGER     NO-UNDO.
DEFINE VARIABLE cSerial AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iCount  AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttHist
  FIELD c AS CHARACTER
  INDEX iprim c.
  
REPEAT:
  /* save current situation */
  cSerial = ''.
  DO ii = 1 TO EXTENT(iBank):
    cSerial = cSerial + ',' + STRING(iBank[ii]).
  END.
  IF CAN-FIND(ttHist WHERE ttHist.c = cSerial) THEN
  DO:
    MESSAGE 'infinite loop after' iCount 'cycles'
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.    
  END.
  
  iCount = iCount + 1.
  CREATE ttHist.
  ASSIGN ttHist.c = cSerial.
  
  /* find highest bank */
  iVal = 0.
  DO ii = 1 TO EXTENT(iBank):
    IF iBank[ii] > iVal THEN
      ASSIGN iVal = iBank[ii]
             iNr  = ii.
  END.

  /* redistribute */
  iRedist = iBank[iNr].
  iBank[iNr] = 0.
  
  DO ii = 1 TO iRedist:
    iNr = iNr + 1.
    IF iNr > EXTENT(iBank) THEN iNr = 1.
    iBank[iNr] = iBank[iNr] + 1.
  END.     

/*   MESSAGE iBank[1] iBank[2] iBank[3] iBank[4] */
/*     VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. */
/*                                               */
END.

/* ---------------------------     */
/* Information                     */
/* ---------------------------     */
/* infinite loop after 5042 cycles */
/* ---------------------------     */
/* OK                              */
/* ---------------------------     */
