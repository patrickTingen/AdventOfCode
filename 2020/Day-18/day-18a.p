/* AoC 2020 day 18, part 1
 */ 
FUNCTION calc RETURNS INT64 (pcExpr AS CHARACTER):
  DEFINE VARIABLE iResult   AS INT64     NO-UNDO.
  DEFINE VARIABLE cOperator AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cToken    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iOpen     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE VARIABLE j AS INTEGER NO-UNDO.
  
  pcExpr = REPLACE(pcExpr,' ','').
  
  #token:
  DO i = 1 TO LENGTH(pcExpr):
    cToken = SUBSTRING(pcExpr,i,1).
    
    IF LOOKUP(cToken,'+,-,*') > 0 THEN
    DO:
      cOperator = cToken.
      NEXT #token.        
    END.
    
    IF cToken = '(' THEN
    DO:
      CASE cOperator:
        WHEN '+' THEN iResult = iResult + calc(SUBSTRING(pcExpr,i + 1)).
        WHEN '-' THEN iResult = iResult - calc(SUBSTRING(pcExpr,i + 1)).
        WHEN '*' THEN iResult = iResult * calc(SUBSTRING(pcExpr,i + 1)).
        WHEN ''  THEN iResult = calc(SUBSTRING(pcExpr,i + 1)).
      END CASE.
      
      DO j = i TO LENGTH(pcExpr):
        CASE SUBSTRING(pcExpr,j,1):
          WHEN '(' THEN iOpen = iOpen + 1.
          WHEN ')' THEN iOpen = iOpen - 1.              
        END CASE.
        
        IF iOpen = 0 THEN 
        DO:
          i = j.
          NEXT #token.
        END.
      END.
    END.
    
    IF LOOKUP(cToken,'0,1,2,3,4,5,6,7,8,9') > 0 THEN
    DO:
      CASE cOperator:
        WHEN '+' THEN iResult = iResult + INTEGER(cToken).
        WHEN '-' THEN iResult = iResult - INTEGER(cToken).
        WHEN '*' THEN iResult = iResult * INTEGER(cToken).
        WHEN ''  THEN iResult = INTEGER(cToken).
      END CASE.
      NEXT #token.        
    END.
    
    IF cToken = ')' THEN RETURN iResult.
  END.
  
  RETURN iResult. 
END FUNCTION.

DEFINE VARIABLE iTotal AS INT64     NO-UNDO.
DEFINE VARIABLE cSum   AS CHARACTER NO-UNDO.

ETIME(yes).
INPUT FROM "input.txt".
REPEAT:
  IMPORT UNFORMATTED cSum.
  iTotal = iTotal + calc(cSum).
END.
INPUT CLOSE. 

MESSAGE 'Part 1:' iTotal SKIP 'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* INFORMATION                 */
/* --------------------------- */
/* Part 1: 6811433855019       */
/* Time: 68                    */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
