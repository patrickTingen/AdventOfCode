/* AoC 2020 day 20 
 */ 
DEFINE TEMP-TABLE ttTile NO-UNDO
  FIELD iNr       AS INTEGER
  FIELD cData     AS CHARACTER EXTENT 10
  FIELD cSide     AS CHARACTER EXTENT 4
  FIELD cAllSides AS CHARACTER 
  .
DEFINE BUFFER bTile FOR ttTile.

DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLine   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTileNr AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMatch  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPart-1 AS INT64     NO-UNDO.

FUNCTION flip RETURNS CHARACTER (pcLine AS CHARACTER):
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DO i = LENGTH(pcLine) TO 1 BY -1:
    cLine = cLine + SUBSTRING(pcLine,i,1).
  END.
  RETURN cLine.
END FUNCTION.

INPUT FROM "input.txt".

#readData:
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' THEN NEXT. 
  
  IF cLine BEGINS 'Tile' THEN DO:
    CREATE ttTile.
    ASSIGN ttTile.iNr = INTEGER(ENTRY(2, ENTRY(1,cLine,':'),' ')).
    iTileNr = ttTile.iNr.
    iLine = 0.
    NEXT #readData.
  END.

  FIND ttTile WHERE ttTile.iNr = iTileNr.
  iLine = iLine + 1.
  ttTile.cData[iLine] = cLine.
END.
INPUT CLOSE. 

FOR EACH ttTile:
  DO i = 1 TO 10:
    ttTile.cSide[1] = ttTile.cSide[1] + SUBSTRING(ttTile.cData[1],i,1).
    ttTile.cSide[2] = ttTile.cSide[2] + SUBSTRING(ttTile.cData[i],10,1).
    ttTile.cSide[3] = ttTile.cSide[3] + SUBSTRING(ttTile.cData[10],i,1).
    ttTile.cSide[4] = ttTile.cSide[4] + SUBSTRING(ttTile.cData[i],1,1).
  END.

  ttTile.cAllSides = SUBSTITUTE('&1,&2,&3,&4,&5,&6,&7,&8'
                               , ttTile.cSide[1]
                               , ttTile.cSide[2]
                               , ttTile.cSide[3]
                               , ttTile.cSide[4]
                               , flip(ttTile.cSide[1])
                               , flip(ttTile.cSide[2])
                               , flip(ttTile.cSide[3])
                               , flip(ttTile.cSide[4])
                               ).
END.

/* Find corner pieces 
*/ 
iPart-1 = 1.
FOR EACH ttTile:
  iMatch = INTEGER(CAN-FIND(FIRST bTile WHERE bTile.iNr <> ttTile.iNr AND LOOKUP(ttTile.cSide[1], bTile.cAllSides) > 0))
         + INTEGER(CAN-FIND(FIRST bTile WHERE bTile.iNr <> ttTile.iNr AND LOOKUP(ttTile.cSide[2], bTile.cAllSides) > 0))
         + INTEGER(CAN-FIND(FIRST bTile WHERE bTile.iNr <> ttTile.iNr AND LOOKUP(ttTile.cSide[3], bTile.cAllSides) > 0))
         + INTEGER(CAN-FIND(FIRST bTile WHERE bTile.iNr <> ttTile.iNr AND LOOKUP(ttTile.cSide[4], bTile.cAllSides) > 0)).
  IF iMatch = 2 THEN iPart-1 = iPart-1 * ttTile.iNr.
END.

MESSAGE iPart-1
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/*
---------------------------
Information 
---------------------------
7901522557967
---------------------------
OK   
---------------------------
*/
