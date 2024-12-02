/* AoC 2024 day 01b
 */ 
DEFINE TEMP-TABLE ttNr
  FIELD iOne AS INTEGER
  FIELD iTwo AS INTEGER
  INDEX idxOne iOne
  INDEX idxTwo iTwo.  

DEFINE VARIABLE iDiff AS INT64 NO-UNDO.  

FUNCTION sim RETURNS INTEGER (piNr AS INTEGER):
  DEFINE BUFFER bNr FOR ttNr.
  DEFINE VARIABLE iSim AS INTEGER NO-UNDO.
  FOR EACH bNr WHERE bNr.iTwo = piNr:
    iSim = iSim + 1.
  END.
  RETURN iSim.
END FUNCTION.

INPUT FROM "test.txt".
REPEAT TRANSACTION:
  CREATE ttNr.
  IMPORT ttNr.
END.
INPUT CLOSE. 

FOR EACH ttNr:
  iDiff = iDiff + (ttNr.iOne * sim(ttNr.iOne)).
END.

MESSAGE iDiff
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  