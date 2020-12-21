/* AoC 2020 day 18, part 2
 */ 
DEFINE VARIABLE cStack  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cOutput AS CHARACTER  NO-UNDO.

FUNCTION pushStack RETURNS CHARACTER (cToken AS CHARACTER):
  cStack = TRIM(cStack + ',' + cToken,',').
  RETURN cStack.
END FUNCTION.

FUNCTION pushOutput RETURNS CHARACTER (cToken AS CHARACTER):
  cOutput = TRIM(cOutput + ',' + cToken,',').
  RETURN cOutput.
END FUNCTION.

FUNCTION popStack RETURNS CHARACTER():
  DEFINE VARIABLE cPop AS CHARACTER   NO-UNDO.
  IF NUM-ENTRIES(cStack) = 0 THEN RETURN ''.
  cPop = ENTRY(NUM-ENTRIES(cStack),cStack).
  ENTRY(NUM-ENTRIES(cStack),cStack) = ''.
  cStack = TRIM(cStack,',').
  RETURN cPop.
END FUNCTION.

FUNCTION peekStack RETURNS CHARACTER():
  RETURN (IF NUM-ENTRIES(cStack) = 0 THEN '' ELSE ENTRY(NUM-ENTRIES(cStack),cStack)).
END FUNCTION.


FUNCTION calc RETURNS INT64 (cExpr AS CHARACTER):
  DEFINE VARIABLE i       AS INT64      NO-UNDO. 
  DEFINE VARIABLE cToken  AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE iOne    AS INT64      NO-UNDO.
  DEFINE VARIABLE iTwo    AS INT64      NO-UNDO.

  cExpr   = REPLACE(cExpr,' ','').
  cOutput = ''.
  cStack  = ''.
  
  #token:
  DO i = 1 TO LENGTH(cExpr):
    cToken = SUBSTRING(cExpr,i,1).
    IF LOOKUP(cToken,'0,1,2,3,4,5,6,7,8,9') > 0 THEN
    DO:
      pushOutput(cToken).
      NEXT #token.
    END.
     
    IF LOOKUP(cToken,'+,-,*') > 0 THEN
    DO:
      DO WHILE peekStack() = '+':
        pushOutput(popStack()).    
      END.
      pushStack(cToken). 
      NEXT #token.        
    END.
      
    IF LOOKUP(cToken,'(') > 0 THEN
    DO:
      pushStack(cToken).
      NEXT #token.        
    END.
      
    IF cToken = ')' THEN
    DO:
      REPEAT:
        cToken = popStack().
        IF cToken = '(' THEN NEXT #token.
        pushOutput(cToken).
      END.  
      NEXT #token.
    END.
  END.

  REPEAT:
    IF cStack = '' THEN LEAVE.
    pushOutput(popStack()).
  END.

  cExpr = REPLACE(cOutput,',','').
  cOutput = ''.
  cStack = ''.

  #token:
  DO i = 1 TO LENGTH(cExpr):
    cToken = SUBSTRING(cExpr,i,1).

    IF LOOKUP(cToken,'0,1,2,3,4,5,6,7,8,9') > 0 THEN
    DO:
      pushStack(cToken).
      NEXT #token.
    END.

    IF LOOKUP(cToken,'+,-,*') > 0 THEN
    DO:
      iOne = INT64(popStack()).
      iTwo = INT64(popStack()).
      CASE cToken:
        WHEN '+' THEN pushStack(STRING(iOne + iTwo)).
        WHEN '-' THEN pushStack(STRING(iTwo - iOne)).
        WHEN '*' THEN pushStack(STRING(iOne * iTwo)).
      END CASE.
      NEXT #token.
    END.
  END.
    
  RETURN INT64(cStack).
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

MESSAGE 'Part 2:' iTotal SKIP 'Time:' ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* INFORMATION                 */
/* --------------------------- */
/* Part 2: 129770152447927     */
/* Time: 445                   */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
