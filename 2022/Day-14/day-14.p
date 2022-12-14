/* AoC 2022 day 14 a + b 
 */ 
DEFINE VARIABLE g      AS grid.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cGrid  AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cPos   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cPrev  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSandX AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSandY AS INTEGER   NO-UNDO.
DEFINE VARIABLE iUnits AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPartA AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFloor AS INTEGER   NO-UNDO.

g = NEW grid().

INPUT FROM data.txt.
REPEAT:
  IMPORT UNFORMATTED cLine. 
  DO i = 1 TO NUM-ENTRIES(cLine,' ').
    
    cPos = ENTRY(i, cLine, ' ').

    IF cPos = '->' THEN NEXT. 
    IF i = 1 THEN cPrev = "".

    IF cPos <> '' AND cPrev <> '' THEN 
      g:addLine( INTEGER(ENTRY(1,cPos)), INTEGER(ENTRY(2,cPos))
               , INTEGER(ENTRY(1,cPrev)), INTEGER(ENTRY(2,cPrev))).

    cPrev = cPos.
  END.
END.
INPUT CLOSE. 

iFloor = g:iMaxY.

#SandUnit:
REPEAT:

  /* Init new unit of sand */
  iUnits = iUnits + 1.
  iSandX = 500.
  iSandY = 0.

  #SandMove:
  REPEAT:

    IF ETIME > 1000 THEN 
    DO:
      HIDE MESSAGE NO-PAUSE.
      MESSAGE SUBSTITUTE('&1 units, gridsize: &2 x &3', iUnits, g:iMaxX - g:iMinX, g:iMaxY - g:iMinY).
      ETIME(YES).
      PROCESS EVENTS. 
    END.

    IF iSandY = (iFloor + 1) THEN 
    DO:
      /* Add extra lines below floor */
      g:pos(iSandX - 1, iFloor + 2, "#").
      g:pos(iSandX    , iFloor + 2, "#").
      g:pos(iSandX + 1, iFloor + 2, "#").
    END.

    /* Can it fall? */
    IF g:pos(iSandX, iSandY + 1) = '.' THEN 
    DO:
      iSandY = iSandY + 1.

      /* Below floor? */
      IF iSandY > iFloor THEN 
      DO:
        IF iPartA = 0 THEN 
        DO:
          iPartA = iUnits - 1.
          MESSAGE "Part A:" iPartA VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
          COPY-LOB g:getGrid() TO FILE "Part-1.txt".
        END.
      END.
      NEXT #SandMove.
    END.
    
    /* Move left-down */
    IF g:pos(iSandX - 1, iSandY + 1) = '.' THEN 
    DO:
      iSandX = iSandX - 1.
      iSandY = iSandY + 1.
      NEXT #SandMove.
    END.

    /* Move right-down */
    IF g:pos(iSandX + 1, iSandY + 1) = '.' THEN 
    DO:
      iSandX = iSandX + 1.
      iSandY = iSandY + 1.
      NEXT #SandMove.
    END.

    /* Cannot move */
    g:pos(iSandX, iSandY, 'o').
    IF iSandX = 500 AND iSandY = 0 THEN 
    DO:
      MESSAGE "Part 2:" iUnits VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      COPY-LOB g:getGrid() TO FILE "Part-2.txt".
      LEAVE #SandUnit.
    END.

    NEXT #SandUnit.
  END.
END.
