/* AoC 2024 day 09b
 */ 
DEFINE TEMP-TABLE ttBlock NO-UNDO
  FIELD lFree AS LOGICAL  
  FIELD iNr   AS INTEGER 
  FIELD iPos  AS INTEGER   
  FIELD iSize AS INTEGER        
  INDEX idx1 lFree iPos
  INDEX idx2 lFree iNr.

DEFINE VARIABLE iMaxNr AS INTEGER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER NO-UNDO.
DEFINE VARIABLE iSum   AS INT64   NO-UNDO.

DEFINE BUFFER btFile FOR ttBlock.
DEFINE BUFFER btFree FOR ttBlock.

ETIME(YES).
RUN loadMap('data.txt', OUTPUT iMaxNr).

DO i = iMaxNr TO 1 BY -1:

  FIND btFile 
    WHERE btFile.lFree = FALSE
      AND btFile.iNr   = i NO-ERROR.

  IF AVAILABLE btFile THEN 
  DO:
    FIND FIRST btFree
      WHERE btFree.lFree  = TRUE
        AND btFree.iSize >= btFile.iSize
        AND btFree.iPos  <  btFile.iPos NO-ERROR.

    IF AVAILABLE btFree THEN 
    DO:
      ASSIGN
        btFile.iPos  = btFree.iPos
        btFree.iSize = btFree.iSize - btFile.iSize
        btFree.iPos  = btFree.iPos  + btFile.iSize.

      IF btFree.iSize = 0 THEN DELETE btFree.
    END.
  END.
END.

FOR EACH btFile WHERE btFile.lFree = FALSE:
  DO i = btFile.iPos TO btFile.iPos + btFile.iSize - 1:
    iSum = iSum + i * btFile.iNr.
  END.
END.

MESSAGE iSum 'in' ETIME 'ms' /* 6250605700557 in 1740 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.



PROCEDURE loadMap:
  DEFINE INPUT  PARAMETER pcFile  AS CHARACTER NO-UNDO.
  DEFINE OUTPUT PARAMETER piMaxNr AS INTEGER   NO-UNDO.

  DEFINE VARIABLE cData AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iSize AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iPos  AS INTEGER   NO-UNDO.

  DEFINE BUFFER btBlock FOR ttBlock.

  INPUT FROM VALUE(pcFile).
  IMPORT UNFORMATTED cData.
  INPUT CLOSE.

  DO i = 1 TO LENGTH(cData) BY 2:

    CREATE btBlock.
    ASSIGN
      btBlock.lFree = FALSE 
      btBlock.iNr   = piMaxNr
      btBlock.iPos  = iPos
      btBlock.iSize = INTEGER(SUBSTRING(cData, i, 1)).

    iSize = INTEGER(SUBSTRING(cData, i + 1, 1)).
    iPos  = iPos + btBlock.iSize.
    
    IF iSize > 0 THEN 
    DO:
      CREATE btBlock.
      ASSIGN
        btBlock.lFree = TRUE
        btBlock.iNr   = piMaxNr
        btBlock.iPos  = iPos
        btBlock.iSize = iSize.

      iPos = iPos + btBlock.iSize.
    END.

    piMaxNr = piMaxNr + 1.
  END.
END PROCEDURE. // loadMap
