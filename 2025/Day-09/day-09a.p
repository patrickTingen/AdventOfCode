/* AoC 2025 day 09a 
 */ 
DEFINE TEMP-TABLE ttTile
  FIELD iTile AS INT64
  FIELD iPosX AS INT64
  FIELD iPosY AS INT64
  INDEX iPrim iTile.

DEFINE VARIABLE iTileNr AS INT64 NO-UNDO.
DEFINE VARIABLE iArea   AS INT64 NO-UNDO.
DEFINE VARIABLE iAnswer AS INT64 NO-UNDO.

DEFINE BUFFER bTileA FOR ttTile.
DEFINE BUFFER bTileB FOR ttTile.

ETIME(YES).

INPUT FROM "data.txt".
REPEAT TRANSACTION:
  iTileNr = iTileNr + 1.
  CREATE ttTile.
  IMPORT DELIMITER "," ttTile.iPosX ttTile.iPosY.
  ttTile.iTile = iTileNr.
END.
INPUT CLOSE. 

FOR EACH bTileA:
  FOR EACH bTileB WHERE bTileB.iTile > bTileA.iTile:

    iArea = (ABS(bTileA.iPosX - bTileB.iPosX) + 1)
          * (ABS(bTileA.iPosY - bTileB.iPosY) + 1).

    iAnswer = MAX(iAnswer,iArea).

  END.
END.
OUTPUT CLOSE. 

MESSAGE iAnswer "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

// ---------------------------
// Information 
// ---------------------------
// 4782268188 in 645 ms
// ---------------------------

