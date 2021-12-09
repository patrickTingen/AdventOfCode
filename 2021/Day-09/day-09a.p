/* AoC 2021 day 09a
 */
DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iRisk AS INTEGER   NO-UNDO.
DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO.

FUNCTION getHeight RETURNS INTEGER
  ( piX AS INTEGER
  , piY AS INTEGER ):

  IF    piX >= 1 AND piX <= iMaxX
    AND piY >= 1 AND piY <= iMaxY THEN
    RETURN INTEGER(SUBSTRING(ENTRY(piY, cData, '~n'), piX, 1)).
  ELSE
    RETURN -1.

END FUNCTION. /* getHeight */

FUNCTION getRiskLevel RETURNS INTEGER
  ( piX AS INTEGER
  , piY AS INTEGER ):

  DEFINE VARIABLE iSelf AS INTEGER NO-UNDO.

  iSelf = getHeight(piX, piY).

  IF    (getHeight(piX - 1, piY) = -1 OR getHeight(piX - 1, piY) > iSelf)
    AND (getHeight(piX + 1, piY) = -1 OR getHeight(piX + 1, piY) > iSelf)
    AND (getHeight(piX, piY - 1) = -1 OR getHeight(piX, piY - 1) > iSelf)
    AND (getHeight(piX, piY + 1) = -1 OR getHeight(piX, piY + 1) > iSelf) THEN
    RETURN iSelf + 1.

  ELSE
    RETURN 0.

END FUNCTION. /* getRiskLevel */

/* Read data */
COPY-LOB FILE "data.txt" TO cData.
cData = TRIM(REPLACE(cData,'~r',''),'~n').
iMaxX = LENGTH(ENTRY(1,cData,'~n')).
iMaxY = NUM-ENTRIES(cData,'~n').

DO iY = 1 TO iMaxY:
  DO iX = 1 TO iMaxX:
    iRisk = iRisk + getRiskLevel(iX,iY).
  END.
END.

MESSAGE iRisk VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 607 */