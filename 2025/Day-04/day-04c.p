/* AoC 2025 day 04c 
**
** More functions in smallGrid.p at the cost 
** of significant longer run 
*/ 
{..\Snippets\SmallGrid.p} 

RUN part-1.
//RUN part-2.

PROCEDURE part-1:
  DEFINE VARIABLE iTotal AS INTEGER NO-UNDO.
  
  ETIME(YES).
  loadGrid("data.txt").
  
  FOR EACH ttGrid WHERE ttGrid.cVal = "@":
  
    IF countAround(ttGrid.iCol, ttGrid.iRow, "@") < 4 THEN iTotal = iTotal + 1.
  
  END.
  
  MESSAGE iTotal "in" ETIME "ms"
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
  // ---------------------------
  // Information 
  // ---------------------------
  // 1346 in 1345 ms
  // ---------------------------
END. 

PROCEDURE part-2:
  DEFINE VARIABLE iTotal AS INTEGER NO-UNDO.
  DEFINE VARIABLE iPrev  AS INTEGER NO-UNDO.
  
  ETIME(YES).
  loadGrid("data.txt").
  
  REPEAT:
    iPrev = iTotal.

    FOR EACH ttGrid WHERE ttGrid.cVal = "@":
      IF countAround(ttGrid.iCol, ttGrid.iRow, "@") < 4 THEN 
      DO:
        setPos(ttGrid.iCol, ttGrid.iRow, ".").
        iTotal = iTotal + 1.
      END.
    END.
  
    IF iPrev = iTotal THEN LEAVE.
    MESSAGE iTotal
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  END. 

  MESSAGE iTotal "in" ETIME "ms"
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  
  // ---------------------------
  // Information 
  // ---------------------------
  // 8493 in 15667 ms
  // ---------------------------
END. 
