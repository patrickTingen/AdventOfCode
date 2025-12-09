/* AoC 2025 day 08b
 */ 
DEFINE TEMP-TABLE ttPoint
  FIELD iPoint AS INTEGER
  FIELD iPosX  AS INTEGER
  FIELD iPosY  AS INTEGER
  FIELD iPosZ  AS INTEGER
  FIELD iCirc  AS INTEGER
  INDEX iPrim iPoint
  INDEX iCirc iCirc.
  
DEFINE TEMP-TABLE ttConn NO-UNDO
  FIELD iPointA AS INTEGER
  FIELD iPointB AS INTEGER
  FIELD iDist   AS INT64
  INDEX iPrim iDist.

DEFINE BUFFER bPoint  FOR ttPoint.
DEFINE BUFFER bPointA FOR ttPoint.
DEFINE BUFFER bPointB FOR ttPoint. 
DEFINE BUFFER bConn   FOR ttConn. 

DEFINE VARIABLE iPointNr AS INTEGER NO-UNDO.  
DEFINE VARIABLE iCircNr  AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumCirc AS INTEGER NO-UNDO.

ETIME(YES).

// Import data
INPUT FROM VALUE("data.txt").
REPEAT TRANSACTION:
  iPointNr = iPointNr + 1.
  CREATE ttPoint.
  IMPORT DELIMITER "," ttPoint.iPosX ttPoint.iPosY ttPoint.iPosZ.  
  ASSIGN ttPoint.iPoint = iPointNr.
END.
INPUT CLOSE.  

// Create combinations and calc distance 
FOR EACH bPointA:
  FOR EACH bPointB WHERE bPointB.iPoint > bPointA.iPoint:

    CREATE ttConn.
    ASSIGN 
      ttConn.iPointA = bPointA.iPoint
      ttConn.iPointB = bPointB.iPoint
      ttConn.iDist    = SQRT( EXP(bPointA.iPosX - bPointB.iPosX,2) 
                            + EXP(bPointA.iPosY - bPointB.iPosY,2)
                            + EXP(bPointA.iPosZ - bPointB.iPosZ,2)).
  END.
END.

// Connect circuits
FOR EACH ttConn: 

  FIND bPointA WHERE bPointA.iPoint = ttConn.iPointA.
  FIND bPointB WHERE bPointB.iPoint = ttConn.iPointB.

  // new circuit - connect them
  IF bPointA.iCirc = 0 AND bPointB.iCirc = 0 THEN
  DO:
    iCircNr = iCircNr + 1.
    iNumCirc = iNumCirc + 1.

    bPointA.iCirc = iCircNr.
    bPointB.iCirc = iCircNr.  
  END.

  // existing circuit, nothing happens
  ELSE
  IF bPointA.iCirc = bPointB.iCirc THEN
    NEXT.
  
  // A unconnected, attach to circuit of B
  ELSE
  IF bPointA.iCirc = 0 THEN
    bPointA.iCirc = bPointB.iCirc.
    
  // B unconnected, attach to circuit of A
  ELSE   
  IF bPointB.iCirc = 0 THEN
    bPointB.iCirc = bPointA.iCirc.
  
  // both in different circuits - connect both 
  ELSE
  DO:
    FOR EACH bPoint WHERE bPoint.iCirc = bPointA.iCirc:
       bPoint.iCirc = bPointB.iCirc.
    END.
    iNumCirc = iNumCirc - 1.
  END.

  // Report final circuit complete
  IF iNumCirc = 1 AND NOT CAN-FIND(FIRST bPoint WHERE bPoint.iCirc = 0) THEN
  DO:
    MESSAGE bPointA.iPosX * bPointB.iPosX "in" ETIME "ms" VIEW-AS ALERT-BOX.
    LEAVE.
  END.

END.


// ---------------------------
// Message 
// ---------------------------
// 772452514 in 5459 ms
// ---------------------------
