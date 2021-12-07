/* AoC 2021 day 07a
 */ 
DEFINE VARIABLE iCrab    AS INTEGER   NO-UNDO EXTENT.
DEFINE VARIABLE iDist    AS INTEGER   NO-UNDO EXTENT.
DEFINE VARIABLE cData    AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE j        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMin     AS INTEGER   NO-UNDO INITIAL 9999.
DEFINE VARIABLE iMax     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMinFuel AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFuel    AS INTEGER   NO-UNDO.

FUNCTION fuelUsage RETURNS INTEGER (piDist AS INTEGER):
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  
  IF piDist = 0 THEN RETURN 0.

  IF iDist[piDist] = 0 THEN 
  DO:
    DO i = 1 TO piDist:
      iDist[piDist] = iDist[piDist] + i.
    END.
  END.

  RETURN iDist[piDist].
END FUNCTION.

/* Read input */
COPY-LOB FILE "c:\Data\DropBox\AdventOfCode\2021\Day-07\data.txt" TO cData.
EXTENT(iCrab) = NUM-ENTRIES(cData).
DO i = 1 TO NUM-ENTRIES(cData):
  iCrab[i] = INTEGER(ENTRY(i,cData)).
  iMin = MINIMUM(iMin,iCrab[i]).
  iMax = MAXIMUM(iMax,iCrab[i]).
END.

EXTENT(iDist) = iMax.
DO i = iMin TO iMax: 

  iFuel = 0.
  DO j = 1 TO EXTENT(iCrab):
    iFuel = iFuel + fuelUsage(ABS(i - iCrab[j])).
  END.

  iMinFuel = (IF i = iMin THEN iFuel ELSE MIN(iMinFuel,iFuel)).
END.

MESSAGE iMinFuel VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 99634572 */
