/* AoC 2021 day 11a, both parts
 */ 
DEFINE VARIABLE iEnergy     AS INTEGER NO-UNDO EXTENT 100.
DEFINE VARIABLE lFlashed    AS LOGICAL NO-UNDO EXTENT 100.
DEFINE VARIABLE i           AS INTEGER NO-UNDO.
DEFINE VARIABLE iNumFlashes AS INTEGER NO-UNDO.
DEFINE VARIABLE iTotFlashes AS INTEGER NO-UNDO.
DEFINE VARIABLE iStep       AS INTEGER NO-UNDO.
DEFINE VARIABLE lNewFlash   AS LOGICAL NO-UNDO.
DEFINE VARIABLE iPart       AS INTEGER NO-UNDO EXTENT 2.

PROCEDURE flashOcto:
  DEFINE INPUT PARAMETER piOcto AS INTEGER NO-UNDO.
  
  DEFINE VARIABLE iX AS INTEGER NO-UNDO.
  DEFINE VARIABLE iY AS INTEGER NO-UNDO.
  DEFINE VARIABLE xx AS INTEGER NO-UNDO.
  DEFINE VARIABLE yy AS INTEGER NO-UNDO.
  DEFINE VARIABLE i  AS INTEGER NO-UNDO.

  DEFINE VARIABLE x-from AS INTEGER     NO-UNDO.
  DEFINE VARIABLE x-to   AS INTEGER     NO-UNDO.
  DEFINE VARIABLE y-from AS INTEGER     NO-UNDO.
  DEFINE VARIABLE y-to   AS INTEGER     NO-UNDO.
  
  lFlashed[piOcto] = YES.  

  /* Calc X,Y */
  iX = piOcto MOD 10.
  IF iX = 0 THEN iX = 10.
  iY = TRUNC((piOcto - 1) / 10,0) + 1.

  /* Calc range for neighbours */
  x-from = MAX(1,iX - 1).
  x-to   = MIN(10, iX + 1).
  y-from = MAX(1,iY - 1).
  y-to   = MIN(10, iY + 1).  
  
  /* Increase energy of neighbours */
  DO yy = y-from TO y-to:
    DO xx = x-from TO x-to:
      IF xx = iX AND yy = iY THEN NEXT. /* this one flashes */      
      i = (yy - 1) * 10 + xx.
      iEnergy[i] = iEnergy[i] + 1. 
    END.
  END.  
END PROCEDURE.

/* Main */
ETIME(YES).
RUN readData.

REPEAT:
  iStep = iStep + 1.

  /* Reset flash for all octopusses */
  lFlashed = FALSE.

  /* Increase energy level of each octopus */
  DO i = 1 TO 100:
    iEnergy[i] = iEnergy[i] + 1.
  END.

  /* Any octopus with energy level > 9 flashes */
  iNumFlashes = 0.
  REPEAT:    
    lNewFlash = FALSE.
    
    DO i = 1 TO 100:
      IF iEnergy[i] > 9 AND NOT lFlashed[i] THEN 
      DO:
        RUN flashOcto(i).
        lNewFlash = TRUE.
        iNumFlashes = iNumFlashes + 1.
      END.      
    END.
    
    IF NOT lNewFlash THEN LEAVE.
  END.
  iTotFlashes = iTotFlashes + iNumFlashes.

  /* Answers */
  IF iStep = 100 THEN iPart[1] = iTotFlashes.
  IF iNumFlashes = 100 AND iPart[2] = 0 THEN iPart[2] = iStep.
  IF iPart[1] > 0 AND iPart[2] > 0 THEN LEAVE.

  /* Reset energy for any octopus that flashed */
  DO i = 1 TO 100:
    IF lFlashed[i] THEN iEnergy[i] = 0.
  END.

END.

MESSAGE "Part 1:" iPart[1] SKIP 
        "Part 2:" iPart[2] SKIP 
        "Time:" ETIME "ms" VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
        
/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Part 1: 1757                */
/* Part 2: 422                 */
/* Time: 651 ms                */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
    
        
PROCEDURE readData:
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  
  /* Read data */
  INPUT FROM "data.txt".
  DO iY = 1 TO 10:
    IMPORT cLine.
    DO iX = 1 TO 10:
      i = i + 1.
      iEnergy[i] = INTEGER(SUBSTRING(cLine,iX,1)).
    END.
  END.
  INPUT CLOSE. 
END PROCEDURE. 
