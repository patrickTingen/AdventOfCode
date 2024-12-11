/* AoC 2024 day 07a 
 */ 
FUNCTION tryCalc RETURNS LOGICAL
  ( piTotal    AS INT64     
  , piSubTotal AS INT64
  , pcOperator AS CHARACTER
  , pcList     AS CHARACTER ):

  DEFINE VARIABLE iVal AS INT64 NO-UNDO.

  iVal   = INT64(ENTRY(1,pcList,' ')).
  pcList = TRIM(SUBSTRING(pcList,INDEX(pcList + ' ',' ') + 1)).
  
  IF piSubTotal = 0 THEN 
    piSubTotal = iVal.
  ELSE 
  DO:
    CASE pcOperator:
      WHEN '+' THEN piSubTotal = piSubTotal + iVal.
      WHEN '*' THEN piSubTotal = piSubTotal * iVal.
    END CASE.
  END.

  IF piSubTotal > piTotal THEN RETURN NO. 
  IF pcList = '' THEN RETURN (piTotal = piSubTotal).

  IF tryCalc(piTotal,piSubTotal,'+',pcList) THEN RETURN YES.
  IF tryCalc(piTotal,piSubTotal,'*',pcList) THEN RETURN YES.
  RETURN NO.

END FUNCTION.  
  
DEFINE VARIABLE cTotal AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTotal AS INT64     NO-UNDO.
DEFINE VARIABLE cNrs   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iPartA AS INT64     NO-UNDO.

ETIME(YES).

INPUT FROM "data.txt".
REPEAT:
  IMPORT DELIMITER ":" cTotal cNrs.
  iTotal = INT64(cTotal).

  IF tryCalc(iTotal,0,'',cNrs) THEN
    iPartA = iPartA + iTotal.
END.
INPUT CLOSE.

MESSAGE iPartA 'in' ETIME 'ms' /* 6392012777720 in 976 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


