/* Advent of code 2018
** day 11
*/
DEFINE TEMP-TABLE ttCell
  FIELD iPosX  AS INTEGER
  FIELD iPosY  AS INTEGER
  FIELD RackId AS INTEGER
  FIELD Power  AS INTEGER
  FIELD TotPwr AS INTEGER
  INDEX iPrim iPosX iPosY.
  
DEFINE TEMP-TABLE ttSquare NO-UNDO
  FIELD iSize  AS INTEGER
  FIELD iPosX  AS INTEGER
  FIELD iPosY  AS INTEGER
  FIELD RackId AS INTEGER
  FIELD TotPwr AS INTEGER.
  
DEFINE BUFFER bCell FOR ttCell. 
DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE j AS INTEGER     NO-UNDO.
DEFINE VARIABLE g AS INTEGER     NO-UNDO INITIAL 300.
DEFINE VARIABLE s AS INTEGER     NO-UNDO.
DEFINE VARIABLE giSerialNr AS INTEGER NO-UNDO INITIAL 1723.

/*
Find the fuel cell's rack ID, which is its X coordinate plus 10.
Begin with a power level of the rack ID times the Y coordinate.
Increase the power level by the value of the grid serial number (your puzzle input).
Set the power level to itself multiplied by the rack ID.
Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
Subtract 5 from the power level.

For example, to find the power level of the fuel cell at 3,5 in a grid with serial number 8:

The rack ID is 3 + 10 = 13.
The power level starts at 13 * 5 = 65.
Adding the serial number produces 65 + 8 = 73.
Multiplying by the rack ID produces 73 * 13 = 949.
The hundreds digit of 949 is 9.
Subtracting 5 produces 9 - 5 = 4.
So, the power level of this fuel cell is 4.

*/
DO i = 1 TO g:
  DO j = 1 TO g:
    CREATE ttCell.
    ASSIGN 
      ttCell.iPosX = i 
      ttCell.iPosY = j
      ttCell.RackId = (i + 10)
      ttCell.Power  = ((ttCell.RackId * ttCell.iPosY) + giSerialNr) * ttCell.RackId
      .
    ttCell.Power = (TRUNC(ttCell.Power / 100,0) MOD 10) - 5.
  END. 
END.

DO s = 3 TO 3:
  
  FOR EACH ttCell WHERE ttCell.iPosX <= (g - s + 1) AND ttCell.iPosY <= (g - s + 1):
    IF ETIME > 1000 THEN DO:      
      HIDE MESSAGE NO-PAUSE. 
      MESSAGE ttCell.iPosX ttCell.iPosY.
      ETIME(YES).
      PROCESS EVENTS.
    END.

    DO i = 1 TO 3:
      DO j = 1 TO 3:
        FIND bCell WHERE bCell.iPosX = ttCell.iPosX + i - 1 AND bCell.iPosY = ttCell.iPosY + j - 1.
        ASSIGN ttCell.TotPwr = ttCell.TotPwr + bCell.Power.
      END.
    END.
  END.

  FOR EACH ttCell BY ttCell.TotPwr DESCENDING:
    CREATE ttSquare.
    ASSIGN 
      ttSquare.iSize  = s
      ttSquare.iPosX  = ttCell.iPosX.
      ttSquare.iPosY  = ttCell.iPosY.
      ttSquare.TotPwr = ttCell.TotPwr.
    LEAVE.
  END. 
END.

 



