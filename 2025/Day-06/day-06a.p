/* AoC 2025 day 06a 
 */ 
DEFINE TEMP-TABLE ttNr NO-UNDO
  FIELD iRow AS INTEGER
  FIELD iCol AS INTEGER
  FIELD iVal AS INTEGER.
  
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iColNr  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRowNr  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTotal  AS INT64     NO-UNDO EXTENT 1000.
DEFINE VARIABLE cOper   AS CHARACTER NO-UNDO EXTENT 1000.
DEFINE VARIABLE iAnswer AS INT64     NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".

REPEAT:
  IMPORT UNFORMATTED cLine.
  
  iRowNr = iRowNr + 1.
  iColNr = 0.
  
  DO i = 1 TO NUM-ENTRIES(cLine, " "):
    IF ENTRY(i,cLine," ") = "" THEN NEXT.
    iColNr = iColNr + 1.

    IF iRowNr = 5 THEN cOper[iColNr] = ENTRY(i,cLine," ").
    ELSE 
    DO:
      CREATE ttNr.
      ASSIGN ttNr.iRow = iRowNr
             ttNr.iCol = iColNr
             ttNr.iVal = INTEGER(ENTRY(i,cLine," ")). 
    END.
           
  END.  
END.

FOR EACH ttNr:

  IF iTotal[ttNr.iCol] = 0 THEN 
    iTotal[ttNr.iCol] = ttNr.iVal.
  ELSE 
  IF cOper[ttNr.iCol] = "+" 
    THEN iTotal[ttNr.iCol] = iTotal[ttNr.iCol] + ttNr.iVal.
    ELSE iTotal[ttNr.iCol] = iTotal[ttNr.iCol] * ttNr.iVal.
    
END.

DO i = 1 TO iColNr:
  iAnswer = iAnswer + iTotal[i].
END.

MESSAGE iAnswer "in" ETIME "ms"
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

// ---------------------------
// Information
// ---------------------------
// 7326876294741 in 75 ms
// ---------------------------
