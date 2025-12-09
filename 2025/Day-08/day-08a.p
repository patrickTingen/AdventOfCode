/* AoC 2025 day 08a
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

DEFINE TEMP-TABLE ttCirc NO-UNDO
  FIELD iCirc AS INTEGER
  FIELD iConn AS INTEGER
  INDEX iPrim iConn
  INDEX iCirc iCirc.

DEFINE BUFFER bPoint  FOR ttPoint.
DEFINE BUFFER bPointA FOR ttPoint.
DEFINE BUFFER bPointB FOR ttPoint. 

DEFINE VARIABLE iPointNr AS INTEGER NO-UNDO.  
DEFINE VARIABLE iCircNr  AS INTEGER NO-UNDO.
DEFINE VARIABLE iMaxConn AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumCirc AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumConn AS INTEGER NO-UNDO.
DEFINE VARIABLE iTotal   AS INT64   NO-UNDO.
DEFINE VARIABLE iCount   AS INT64   NO-UNDO.
DEFINE VARIABLE cFile    AS CHARACTER NO-UNDO INITIAL "data.txt".

ETIME(YES).
iMaxConn = (IF cFile = "test.txt" THEN 10 ELSE 1000).

// Import data
INPUT FROM VALUE(cFile).
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
FOR EACH ttConn BY ttConn.iDist:

  iNumConn = iNumConn + 1.
  IF iNumConn > iMaxConn THEN LEAVE.

  FIND bPointA WHERE bPointA.iPoint = ttConn.iPointA.
  FIND bPointB WHERE bPointB.iPoint = ttConn.iPointB.
  
  // new circuit - connect them
  IF bPointA.iCirc = 0 AND bPointB.iCirc = 0 THEN
  DO:
    iCircNr = iCircNr + 1.
    bPointA.iCirc = iCircNr.
    bPointB.iCirc = iCircNr.  
    iNumCirc = iNumCirc + 1.
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
  END.
END.

// Count nr of junction boxes per circuit
FOR EACH ttPoint WHERE ttPoint.iCirc > 0 BY ttPoint.iCirc DESC:
  FIND ttCirc WHERE ttCirc.iCirc = ttPoint.iCirc NO-ERROR.
  IF NOT AVAILABLE ttCirc THEN
  DO:
    CREATE ttCirc.
    ASSIGN ttCirc.iCirc = ttPoint.iCirc. 
  END.
  ASSIGN ttCirc.iConn = ttCirc.iConn + 1.
END.

// Calc total of 3 largest circuits
iTotal = 1.
iCount = 0.
FOR EACH ttCirc BY ttCirc.iConn DESC:
  iTotal = iTotal * ttCirc.iConn.
  iCount = iCount + 1.
  IF iCount = 3 THEN LEAVE.
END.

MESSAGE iTotal "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  

// ---------------------------
// Information                
// ---------------------------
// 163548 in 5402 ms
// ---------------------------
//                            

