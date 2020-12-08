/* AoC 2020 day 7a
*/
DEFINE TEMP-TABLE ttOuter NO-UNDO
  FIELD cColor  AS CHARACTER FORMAT 'x(20)'
  INDEX iPrim AS PRIMARY UNIQUE cColor.

DEFINE TEMP-TABLE ttInner NO-UNDO
  FIELD cColor  AS CHARACTER FORMAT 'x(20)'
  FIELD iQty    AS INTEGER
  FIELD cColor2 AS CHARACTER FORMAT 'x(20)'
  INDEX iPrim AS PRIMARY cColor cColor2.

DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChunk AS CHARACTER NO-UNDO.
DEFINE VARIABLE iBags  AS INTEGER   NO-UNDO.

INPUT FROM day-07.dat.
REPEAT:
  IMPORT UNFORMATTED cLine.

  cLine = REPLACE(cLine,'bags.', ''). 
  cLine = REPLACE(cLine,'bags', ''). 
  cLine = REPLACE(cLine,'bag.', ''). 
  cLine = REPLACE(cLine,'bag', ''). 

  CREATE ttOuter.
  i = INDEX(cLine, 'contain').
  ttOuter.cColor = SUBSTRING(cLine,1,i - 1).
  cLine = SUBSTRING(cLine, i + 8).

  DO i = 1 TO NUM-ENTRIES(cLine):
    cChunk = TRIM(ENTRY(i,cLine)).
    IF cChunk = 'no other' THEN NEXT. 

    CREATE ttInner.
    ttInner.cColor  = ttOuter.cColor.
    ttInner.iQty     = INTEGER(ENTRY(1,cChunk,' ')).
    ttInner.cColor2 = TRIM(REPLACE(cChunk, STRING(ttInner.iQty),'')).
  END.
END.
INPUT CLOSE. 

FUNCTION bagsInside RETURNS INTEGER (pcOuter AS CHARACTER, pcInner AS CHARACTER):
  DEFINE VARIABLE iNumBags AS INTEGER NO-UNDO.
  DEFINE BUFFER bInner FOR ttInner.

  FIND bInner WHERE bInner.cColor = pcOuter AND bInner.cColor2 = pcInner NO-ERROR.
  IF AVAILABLE bInner THEN iNumBags = bInner.iQty.

  FOR EACH bInner WHERE bInner.cColor = pcOuter:
    iNumBags = iNumBags + bInner.iQty * bagsInside(bInner.cColor2, pcInner).
  END.

  RETURN iNumBags.
END. 

FOR EACH ttOuter:
  IF bagsInside(ttOuter.cColor, "shiny gold") > 0 THEN iBags = iBags + 1.
END.

MESSAGE iBags 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

