/* AoC 2021 day 16b
 */ 
DEFINE VARIABLE gcMessage  AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE giPtr      AS INT64     NO-UNDO INITIAL 1.
DEFINE VARIABLE giValue    AS INT64     NO-UNDO.
DEFINE VARIABLE giLevel    AS INT64     NO-UNDO.

FUNCTION bits RETURNS CHARACTER (piLength AS INT64):
  DEFINE VARIABLE cChunk AS CHARACTER NO-UNDO.
  cChunk = SUBSTRING(gcMessage, giPtr, piLength).
  giPtr = giPtr + piLength.
  RETURN cChunk.
END FUNCTION. 


FUNCTION toInt RETURNS INT64(pcBin AS CHARACTER):
  DEFINE VARIABLE iValue AS INT64 NO-UNDO.
  iValue = System.Convert:ToInt32(pcBin,2) NO-ERROR.
  RETURN iValue.
END FUNCTION. 


FUNCTION getVersion RETURNS INT64 ():
  DEFINE VARIABLE iVersion AS INT64 NO-UNDO.
  iVersion = toInt(bits(3)).
  RETURN iVersion.
END FUNCTION. 


FUNCTION getType RETURNS INT64():
  DEFINE VARIABLE iType AS INT64 NO-UNDO.
  iType = toInt(bits(3)).
  RETURN iType.
END FUNCTION. 

/* Main
*/
RUN readData(OUTPUT gcMessage).
OUTPUT TO dbg.txt.
RUN parsePacket(OUTPUT giValue).
OUTPUT CLOSE. 

MESSAGE giValue VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

PROCEDURE parsePacket:
  DEFINE OUTPUT PARAMETER piValue AS INT64 NO-UNDO.
  
  DEFINE VARIABLE cValues     AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iLength     AS INT64     NO-UNDO.
  DEFINE VARIABLE iNumPackets AS INT64     NO-UNDO.
  DEFINE VARIABLE iType       AS INT64     NO-UNDO.
  DEFINE VARIABLE iResult     AS INT64     NO-UNDO.
  DEFINE VARIABLE iPtrOld     AS INT64     NO-UNDO.
  DEFINE VARIABLE i           AS INT64     NO-UNDO.
  DEFINE VARIABLE iLengthType AS INT64     NO-UNDO.
  DEFINE VARIABLE cChunk      AS CHARACTER NO-UNDO.
  
  getVersion(). /* version not interesting */
  iType = getType().  

  
  IF iType = 4 THEN
  DO:
    REPEAT:
      cChunk = bits(5).
      cValues = cValues + SUBSTRING(cChunk,2).
      IF cChunk BEGINS "0" THEN LEAVE. 
    END.

    piValue = toInt(cValues).    
    PUT UNFORMATTED FILL(" ", giLevel * 2) "Type:" iType " " ENTRY(iType + 1, "Sum,Prd,Min,Max,Lit,GT,LT,EQ") " = " piValue SKIP.
    giLevel = giLevel + 1.
  END. /* literal */
  
  ELSE
  DO:
    PUT UNFORMATTED FILL(" ", giLevel * 2) "Type:" iType " " ENTRY(iType + 1, "Sum,Prd,Min,Max,Lit,GT,LT,EQ") SKIP.
    giLevel = giLevel + 1.

    /* Length type ID */ 
    iLengthType = toInt(bits(1)).

    CASE iLengthType:
      /* 0: next 15 bits is total length in bits of the sub-packets */
      WHEN 0 THEN       
      DO:
        /* 001 110 0 000000000011011 110100 01010 010100 10001 00100 0000000 */
        /* VVV TTT I LLLLLLLLLLLLLLL AAAAAA AAAAA BBBBBB BBBBB BBBBB Junk    */
        /*                           VVVTTT       VVVTTT                     */
        iLength = toInt(bits(15)).
        iPtrOld = giPtr.

        #Parser:
        REPEAT:
          RUN parsePacket(OUTPUT iResult).
          cValues = TRIM(SUBSTITUTE("&1,&2", cValues, iResult), ",").

          /* Check if we have consumed <iLength> chars from the message */
          IF (giPtr - iPtrOld) = iLength THEN LEAVE. 
        END.
      END. /* 0 */

      /* 1: next 11 bits is number of sub-packets */
      WHEN 1 THEN 
      DO:
        /* 111 011 1 00000000011 010100 00001 100100 00010 001100 00011 00000 */
        /* VVV TTT I LLLLLLLLLLL AAAAAA AAAAA BBBBBB BBBBB CCCCCC CCCCC Junk  */
        /*                       VVVTTT       VVVTTT       VVVTTT             */
        iNumPackets = toInt(bits(11)).
        DO i = 1 TO iNumPackets:
          RUN parsePacket(OUTPUT iResult).
          cValues = TRIM(SUBSTITUTE("&1,&2", cValues, iResult), ","). 
        END.
      END. /* 1 */
    END CASE.    

    /* PUT UNFORMATTED FILL(" ", giLevel * 2) "Values:" cValues SKIP.    */
    
    CASE iType:
      WHEN 0 THEN /* sum */
        DO i = 1 TO NUM-ENTRIES(cValues):
          piValue = piValue + INT64(ENTRY(i,cValues)).
        END.
                  
      WHEN 1 THEN /* product */
        DO i = 1 TO NUM-ENTRIES(cValues):
          piValue = (IF i = 1 THEN 1 ELSE piValue) * INT64(ENTRY(i,cValues)).
        END.
      
      WHEN 2 THEN /* Minimum */
        DO i = 1 TO NUM-ENTRIES(cValues):
          IF i = 1 THEN piValue = INT64(ENTRY(i,cValues)).
                   ELSE piValue = MINIMUM(piValue, INT64(ENTRY(i,cValues))).
        END.

      WHEN 3 THEN /* Maximum */
        DO i = 1 TO NUM-ENTRIES(cValues):
          IF i = 1 THEN piValue = INT64(ENTRY(i,cValues)).
                   ELSE piValue = MAXIMUM(piValue, INT64(ENTRY(i,cValues))).
        END.

      WHEN 5 THEN /* Greater */
        piValue = (IF INT64(ENTRY(1,cValues)) > INT64(ENTRY(2,cValues)) THEN 1 ELSE 0).
      
      WHEN 6 THEN /* Smaller */
        piValue = (IF INT64(ENTRY(1,cValues)) < INT64(ENTRY(2,cValues)) THEN 1 ELSE 0).
      
      WHEN 7 THEN /* Equal */
        piValue = (IF INT64(ENTRY(1,cValues)) = INT64(ENTRY(2,cValues)) THEN 1 ELSE 0).
        
    END CASE.
    
    PUT UNFORMATTED FILL(" ", giLevel * 2) 
      ENTRY(iType + 1, "Sum,Prd,Min,Max,Lit,GT,LT,EQ") ": " cValues " --> " piValue SKIP.
  END. /* operator */

  giLevel = giLevel - 1.
  
END PROCEDURE. /* parsePacket */


PROCEDURE readData:
  DEFINE OUTPUT PARAMETER pcMessage AS LONGCHAR NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE i     AS INT64     NO-UNDO.
  DEFINE VARIABLE cHex  AS CHARACTER NO-UNDO.

  /* Read data and strip nasty characters */
  COPY-LOB FROM FILE "data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').
  
  /* Convert message in chunks from HEX to BIN */
  DO i = 1 TO LENGTH(cData):
    cHex = SUBSTRING(cData,i,1).
    pcMessage = pcMessage + ENTRY( LOOKUP(cHex, "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F")
                                 , "0000,0001,0010,0011,0100,0101,0110,0111,1000,1001,1010,1011,1100,1101,1110,1111").
  END.

END PROCEDURE. /* readData */

