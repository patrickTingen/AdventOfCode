/* AoC 2022 day 01b 
 * optimized version, handles 500 mb test file in < 3 minutes.
 */ 
DEFINE VARIABLE iNumCalories AS INT64 NO-UNDO.
DEFINE VARIABLE iMaxCalories AS INT64 NO-UNDO.
DEFINE VARIABLE iTotal       AS INT64 NO-UNDO.

DEFINE TEMP-TABLE ttCal NO-UNDO
  FIELD iNumCal AS INT64
  INDEX iPrim iNumCal.

CREATE ttCal.
CREATE ttCal.
CREATE ttCal.

INPUT FROM data.txt.
REPEAT:
  iNumCalories = 0.
  IMPORT iNumCalories.

  IF iNumCalories = 0 THEN
  DO:
    FIND FIRST ttCal WHERE ttCal.iNumCal < iTotal NO-ERROR.
    IF AVAILABLE ttCal THEN ttCal.iNumCal = iTotal.
    
    iMaxCalories = MAXIMUM(iMaxCalories, iTotal).
    iTotal = 0.
  END.
  ELSE
    iTotal = iTotal + iNumCalories.

END.
INPUT CLOSE. 

iTotal = 0.
FOR EACH ttCal:
  iTotal = iTotal + ttCal.iNumCal.
END.

MESSAGE 'Max  :' iMaxCalories SKIP
        'Top3 :' iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* Max  : 72478                */
/* Top3 : 210367               */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
