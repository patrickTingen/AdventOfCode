/* AoC 2021 day 03b
 */ 

DEFINE VARIABLE cData     AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE j         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLen      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iOne      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNul      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cComp     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cScrubber AS CHARACTER NO-UNDO.
DEFINE VARIABLE cOxygen   AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttData
  FIELD lSel    AS LOGICAL 
  FIELD cString AS CHARACTER
  FIELD cBit    AS CHARACTER EXTENT 12.

FUNCTION Bin2Dec RETURNS DECIMAL (cBin AS CHARACTER).
  DEFINE VARIABLE dVal AS DECIMAL NO-UNDO.
  DEFINE VARIABLE i    AS INTEGER NO-UNDO.
  DEFINE VARIABLE iLen AS INTEGER NO-UNDO.

  iLen = LENGTH(cBin).
  DO i = iLen TO 1 BY -1:
    IF SUBSTRING(cBin,i,1) = "1" THEN dVal = dVal + EXP(2,(iLen - i)).
  END.

  RETURN dVal.
END FUNCTION.

/* Init */
COPY-LOB FILE "data.txt" TO cData. 
iLen = LENGTH(ENTRY(1,cData,'~n')) - 1.

DO i = 1 TO NUM-ENTRIES(cData,'~n'):
  CREATE ttData.
  ttData.cString = TRIM(ENTRY(i,cData,'~n'),'~r').

  DO j = 1 TO iLen:
    ttData.cBit[j] = SUBSTRING(ttData.cString, j,1).
    ttData.lSel = TRUE.
  END.
END.

#outerLoop:
DO j = 1 TO 2:

  FOR EACH ttData: 
    ttData.lSel = TRUE. 
  END.

  DO i = 1 TO iLen:
  
    /* Find most used bit */
    iOne = 0.
    iNul = 0.
    FOR EACH ttData WHERE ttData.lSel = TRUE:
      CASE ttData.cBit[i]:
        WHEN '0' THEN iNul = iNul + 1. 
        WHEN '1' THEN iOne = iOne + 1.
      END CASE.
    END.

    /* Determine compare-value */
    IF j = 1 THEN cComp = (IF iNul > iOne THEN '0' ELSE '1'). /* CO2 Scrubber */
             ELSE cComp = (IF iNul > iOne THEN '1' ELSE '0'). /* Oxygen generator rating */
  
    /* Select records */
    FOR EACH ttData WHERE ttData.lSel = TRUE AND ttData.cBit[i] <> cComp:
      ttData.lSel = FALSE.
    END.
  
    /* Only one remaining? */
    FIND ttData WHERE ttData.lSel = TRUE NO-ERROR.
    IF AVAILABLE ttData THEN 
    DO:
      IF j = 1 THEN cScrubber = ttData.cString.
      IF j = 2 THEN cOxygen   = ttData.cString.
      NEXT #outerLoop.
    END.
  END.
END.
  
MESSAGE
  "Scrubber~t:" cScrubber '=' Bin2Dec(cScrubber) SKIP
  "Oxygen~t:"   cOxygen '=' Bin2Dec(cOxygen) SKIP
  "Answer~t:"   Bin2Dec(cScrubber) * Bin2Dec(cOxygen)
  VIEW-AS ALERT-BOX INFO BUTTONS OK.


/*
---------------------------
Information 
---------------------------
Scrubber : 110111110101 = 3573
Oxygen   : 000100100001 = 289
Answer   : 1032597
---------------------------
OK   
---------------------------
*/