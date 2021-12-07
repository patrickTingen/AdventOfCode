/* AoC 2021 day 07a 
 */ 
DEFINE VARIABLE iCrab    AS INTEGER   NO-UNDO EXTENT.
DEFINE VARIABLE cData    AS CHARACTER NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE j        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMin     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMax     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMinFuel AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFuel    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDist    AS INTEGER   NO-UNDO.

ETIME(YES).

cData = "{data.txt}".
EXTENT(iCrab) = NUM-ENTRIES(cData).
DO i = 1 TO EXTENT(iCrab):
  iCrab[i] = INTEGER(ENTRY(i,cData)).
  iMin = (IF i = 1 THEN iCrab[i] ELSE MINIMUM(iMin,iCrab[i])).
  iMax = (IF i = 1 THEN iCrab[i] ELSE MAXIMUM(iMax,iCrab[i])).
END.

DO i = iMin TO iMax: 

  iFuel = 0.
  DO j = 1 TO EXTENT(iCrab):
    iDist = ABS(i - iCrab[j]).
    iFuel = iFuel + INTEGER(iDist * (iDist + 1) / 2).
  END.

  iMinFuel = (IF i = iMin THEN iFuel ELSE MIN(iMinFuel,iFuel)).
END.

MESSAGE iMinFuel ETIME 'ms' VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. 

/* 99634572 
function with code   : 5119
function with formula: 4658 
inline formula       : 2603
*/
