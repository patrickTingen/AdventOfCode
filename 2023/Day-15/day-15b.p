/* AoC 2023 day 15b 
 */ 
DEFINE TEMP-TABLE ttSlot NO-UNDO  
  FIELD iBox    AS INTEGER
  FIELD iSlot   AS INTEGER
  FIELD cLabel  AS CHARACTER 
  FIELD iLength AS INTEGER
  INDEX iPrim iBox iSlot.
  
FUNCTION hash RETURNS INTEGER(pcWord AS CHARACTER):
  DEFINE VARIABLE iHash AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.

  pcWord = TRIM(pcWord).
  DO i = 1 TO LENGTH(pcWord):
    iHash = iHash + ASC(SUBSTRING(pcWord,i,1)).
    iHash = iHash * 17.
    iHash = iHash MOD 256.
  END.
  RETURN iHash.
END FUNCTION.


FUNCTION removeLens RETURNS LOGICAL (piBox AS INTEGER, pcLabel AS CHARACTER):
  DEFINE BUFFER btSlot FOR ttSlot. 
  FIND btSlot WHERE btSlot.iBox = piBox AND btSlot.cLabel = pcLabel NO-ERROR.
  IF AVAILABLE btSlot THEN DELETE btSlot. 
END FUNCTION. 


FUNCTION addLens RETURNS LOGICAL (piBox AS INTEGER, pcLabel AS CHARACTER, piLength AS INTEGER):
  /* Add or replace lens */
  DEFINE VARIABLE iSlotNr AS INTEGER NO-UNDO.
  DEFINE BUFFER btSlot FOR ttSlot. 

  FIND btSlot WHERE btSlot.iBox = piBox AND btSlot.cLabel = pcLabel NO-ERROR.
  IF AVAILABLE btSlot THEN ASSIGN btSlot.iLength = piLength.
  ELSE
  DO:
    FIND LAST btSlot WHERE btSlot.iBox = piBox NO-ERROR.
    iSlotNr = (IF AVAILABLE btSlot THEN btSlot.iSlot ELSE 0) + 1.
    CREATE btSlot.
    ASSIGN btSlot.iBox   = piBox
           btSlot.iSlot  = iSlotNr
           btSlot.cLabel = pcLabel
           btSlot.iLength = piLength.
  END.
END FUNCTION. 


FUNCTION boxState RETURNS CHARACTER ():
  /* For debugging */
  DEFINE VARIABLE cState AS CHARACTER NO-UNDO.
  DEFINE BUFFER btSlot FOR ttSlot. 

  FOR EACH btSlot BREAK BY btSlot.iBox BY btSlot.iSlot:
    IF FIRST-OF(btSlot.iBox) THEN cState = cState + SUBSTITUTE('Box &1:', btSlot.iBox).
    cState = SUBSTITUTE('&1 [&2 &3]', cState, btSlot.cLabel, btSlot.iLength).
    IF LAST-OF(btSlot.iBox) THEN cState = cState + "~n".
  END.

  RETURN cState.
END FUNCTION.


DEFINE VARIABLE cData      AS CHARACTER NO-UNDO.  
DEFINE VARIABLE i          AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSlotNr    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cWord      AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLabel     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cOperation AS CHARACTER NO-UNDO.
DEFINE VARIABLE iValue     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iBox       AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer    AS INTEGER   NO-UNDO.

INPUT FROM "data.txt".
IMPORT UNFORMATTED cData.
INPUT CLOSE. 

/* Process all instructions 
*/
DO i = 1 TO NUM-ENTRIES(cData):

  cWord      = ENTRY(i,cData).
  cOperation = (IF cWord MATCHES "*=*" THEN "=" ELSE "-").
  cLabel     = ENTRY(1,cWord,cOperation).
  iValue     = INTEGER(ENTRY(2,cWord,cOperation)).           
  
  iBox = hash(cLabel).
  IF cOperation = "-" THEN removeLens(iBox,cLabel).
  IF cOperation = "=" THEN addLens(iBox,cLabel,iValue).
END.

/* Calculate total power 
*/
DO i = 0 TO 255:
  iSlotNr = 0.
  FOR EACH ttSlot WHERE ttSlot.iBox = i:
    iSlotNr = iSlotNr + 1.
    iAnswer = iAnswer + (i + 1) * iSlotNr * ttSlot.iLength.
  END.
END.

MESSAGE iAnswer  /* 279116 */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


