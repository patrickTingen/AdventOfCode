/* AoC 2021 day 16a 
 */ 
DEFINE VARIABLE gcMessage  AS LONGCHAR NO-UNDO.
DEFINE VARIABLE giPtr      AS INTEGER  NO-UNDO INITIAL 1.
DEFINE VARIABLE giVersions AS INTEGER  NO-UNDO.

FUNCTION bits RETURNS CHARACTER (piLength AS INTEGER):
  DEFINE VARIABLE cChunk AS CHARACTER NO-UNDO.
  cChunk = SUBSTRING(gcMessage, giPtr, piLength).
  giPtr = giPtr + piLength.
  RETURN cChunk.
END FUNCTION. 


FUNCTION toInt RETURNS INTEGER(pcBin AS CHARACTER):
  DEFINE VARIABLE iValue AS INTEGER NO-UNDO.
  iValue = System.Convert:ToInt32(pcBin,2) NO-ERROR.
  RETURN iValue.
END FUNCTION. 


FUNCTION getVersion RETURNS INTEGER ():
  DEFINE VARIABLE iVersion AS INTEGER   NO-UNDO.
  iVersion = toInt(bits(3)).
  giVersions = giVersions + iVersion. 
  RETURN iVersion.
END FUNCTION. 


FUNCTION getType RETURNS INTEGER():
  RETURN toInt(bits(3)).
END FUNCTION. 

/* Main
*/
RUN readData(OUTPUT gcMessage).
RUN parseMessage.

MESSAGE giVersions VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 969 */


PROCEDURE parseMessage:
  DEFINE VARIABLE iVersion AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iType    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iValue   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cValue   AS CHARACTER NO-UNDO.

  #Parser:
  REPEAT:
    PROCESS EVENTS. 

    /* First 6 bits hold version and type */
    iVersion = getVersion().
    iType    = getType().

    CASE iType:
      WHEN 4 THEN RUN getLiteral(OUTPUT iValue).
      OTHERWISE   RUN getOperator(OUTPUT cValue).
    END CASE.

    IF giPtr >= LENGTH(gcMessage) - 6 THEN LEAVE. 
  END.
END PROCEDURE. /* parseMessage */


PROCEDURE getLiteral:
  DEFINE OUTPUT PARAMETER piValue AS INTEGER NO-UNDO.

  DEFINE VARIABLE cChunk AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cValue AS CHARACTER NO-UNDO.

  REPEAT:
    PROCESS EVENTS. 
    cChunk = bits(5).
    cValue = cValue + SUBSTRING(cChunk,2).
    IF cChunk BEGINS "0" THEN LEAVE. 
  END.

  piValue = toInt(cValue).
END PROCEDURE. /* getLiteral */


PROCEDURE getOperator:
  DEFINE OUTPUT PARAMETER pcOperator AS INTEGER NO-UNDO.

  DEFINE VARIABLE cType       AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cValue      AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iLength     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNumPackets AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iVersion    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iType       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iValue      AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iPtrOld     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE i           AS INTEGER   NO-UNDO.

  /* Length type ID */ 
  cType = bits(1).

  /* 0: next 15 bits is total length in bits of the sub-packets */
  IF cType = "0" THEN 
  DO:
    /* 001 110 0 000000000011011 110100 01010 010100 10001 00100 0000000 */
    /* VVV TTT I LLLLLLLLLLLLLLL AAAAAA AAAAA BBBBBB BBBBB BBBBB Junk    */
    /*                           VVVTTT       VVVTTT                     */
    iLength = toInt(bits(15)).
    iPtrOld = giPtr.

    #Parser:
    REPEAT:
      PROCESS EVENTS. 

      /* First 6 bits hold version and type */
      iVersion = getVersion().
      iType    = getType().

      CASE iType:
        WHEN 4 THEN RUN getLiteral(OUTPUT iValue).
        OTHERWISE   RUN getOperator(OUTPUT cValue).
      END CASE.
      
      /* Check if we have consumed <iLength> chars from the message */
      IF (giPtr - iPtrOld) = iLength THEN LEAVE. 
    END.
  END.

  /* 1: next 11 bits is number of sub-packets */
  IF cType = "1" THEN 
  DO:
    /* 111 011 1 00000000011 010100 00001 100100 00010 001100 00011 00000 */
    /* VVV TTT I LLLLLLLLLLL AAAAAA AAAAA BBBBBB BBBBB CCCCCC CCCCC Junk  */
    /*                       VVVTTT       VVVTTT       VVVTTT             */
    iNumPackets = toInt(bits(11)).
    DO i = 1 TO iNumPackets:
      PROCESS EVENTS. 

      /* First 6 bits hold version and type */
      iVersion = getVersion().
      iType    = getType().

      CASE iType:
        WHEN 4 THEN RUN getLiteral(OUTPUT iValue).
        OTHERWISE   RUN getOperator(OUTPUT cValue).
      END CASE.
    END.
  END.

END PROCEDURE. /* getLiteral */


PROCEDURE readData:
  DEFINE OUTPUT PARAMETER pcMessage AS LONGCHAR NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cHex  AS CHARACTER NO-UNDO.

  /* Read data and strip nasty characters */
  COPY-LOB FROM FILE "c:\Data\DropBox\AdventOfCode\2021\Day-16\data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Convert message in chunks from HEX to BIN */
  DO i = 1 TO LENGTH(cData):
    cHex = SUBSTRING(cData,i,1).
    pcMessage = pcMessage + ENTRY( LOOKUP(cHex, "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F")
                                 , "0000,0001,0010,0011,0100,0101,0110,0111,1000,1001,1010,1011,1100,1101,1110,1111").
  END.

END PROCEDURE. /* readData */
