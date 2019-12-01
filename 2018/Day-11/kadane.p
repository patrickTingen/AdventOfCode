
PROCEDURE kadane:
  DEFINE INPUT  PARAMETER pInput  AS INTEGER NO-UNDO EXTENT.
  DEFINE OUTPUT PARAMETER pResult AS INTEGER NO-UNDO EXTENT 3 INITIAL [-100,0,-1].
  
  DEFINE VARIABLE currentSum AS INTEGER NO-UNDO.
  DEFINE VARIABLE localStart AS INTEGER NO-UNDO.
  DEFINE VARIABLE i          AS INTEGER NO-UNDO.
  
  DO i = 1 TO EXTENT(pInput):
    currentSum = currentSum + pInput[i].
    IF currentSum < 0 THEN
      ASSIGN 
        currentSum = 0
        localStart = i + 1.
    ELSE 
    IF currentSum > pResult[1] THEN
      ASSIGN 
        pResult[1] = currentSum
        pResult[2] = localStart
        pResult[3] = i.
  END.
  IF pResult[3] = -1 THEN 
  DO: 
    pResult[1] = 1.
    DO i = 1 TO EXTENT(pInput):
      IF pInput[i] > pResult[1] THEN
        ASSIGN 
          pResult[1] = pInput[i]
          pResult[2] = i
          pResult[3] = i.
    END.
  END.  
END. 


PROCEDURE kadane2d:
  DEFINE INPUT PARAMETER pInput AS INTEGER NO-UNDO EXTENT. 
  
  DEFINE VARIABLE leftCol  AS INTEGER     NO-UNDO.
  DEFINE VARIABLE rightCol AS INTEGER     NO-UNDO.
  DEFINE VARIABLE maxSum   AS INTEGER     NO-UNDO INITIAL -9999.
  DEFINE VARIABLE iLeft    AS INTEGER     NO-UNDO.
  DEFINE VARIABLE iRight   AS INTEGER     NO-UNDO.
  DEFINE VARIABLE iTop     AS INTEGER     NO-UNDO.
  DEFINE VARIABLE iBottom  AS INTEGER     NO-UNDO.
  DEFINE VARIABLE iRows    AS INTEGER     NO-UNDO INITIAL 300.
  DEFINE VARIABLE iCols    AS INTEGER     NO-UNDO INITIAL 300.
  DEFINE VARIABLE currentResult AS INTEGER NO-UNDO EXTENT. //A list of the current sums being calculated
  DEFINE VARIABLE iTmp     AS INTEGER     NO-UNDO EXTENT 300.
  
  // The idea here is to store the sum after each iteration in the currentResult array.
  // With this it is possible to quickly calculate new sums simply by iterating through
  // the matrix and combining the sums.
  DO leftCol = 1 TO iCols:
  
    iTmp = 0.
    DO rightCol = leftCol TO iCols:
 
      DO i = 1 TO rows:
        iTmp[i] = iTmp[i] + pInput[i][rightCol]; //Adding to the temporary array.
      END.
         
      RUN kadane(INPUT iTmp, OUTPUT currentResult).
          
      //We want to change all the variables if the sum is now greater than the output we had
      IF (currentResult[0] > maxSum) THEN 
      DO:
        maxSum  = currentResult[0].
        iLeft   = leftCol.
        iTop    = currentResult[1].
        iRight  = rightCol.
        iBottom = currentResult[2].
      END.  
    END.
  END.

  MESSAGE 
    "MaxSum:" maxSum SKIP
    "Range: (" iLeft "," iTop ") - (" iRight "," iBottom ")" 
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    
END PROCEDURE. 




DEFINE VARIABLE a AS INTEGER NO-UNDO EXTENT 9
  INITIAL [-2, 1, -3, 4, -1, 2, 1, -5, 4].
DEFINE VARIABLE r AS INTEGER NO-UNDO EXTENT 3.

RUN kadane(a, OUTPUT r).  
MESSAGE r[1] r[2] r[3]
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
