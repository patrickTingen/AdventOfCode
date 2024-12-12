/* AoC 2024 day 11a 
 */ 
DEFINE TEMP-TABLE ttStone NO-UNDO
  FIELD iBlink AS INT64
  FIELD iOrder AS INT64
  FIELD iValue AS INT64.

FUNCTION split RETURNS INT64(piPart AS INT64, piVal AS INT64):
  DEFINE VARIABLE cVal AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iLen AS INT64   NO-UNDO.

  cVal = STRING(piVal).
  iLen = LENGTH(cVal) / 2.
  
  IF piPart = 1 THEN RETURN INT64(SUBSTRING(cVal,1,iLen)).
  IF piPart = 2 THEN RETURN INT64(SUBSTRING(cVal,iLen + 1)).
END FUNCTION. 

PROCEDURE readData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE i     AS INT64   NO-UNDO.

  DEFINE BUFFER btStone FOR ttStone. 

  COPY-LOB FILE pcFile TO cData.
  cData = TRIM(REPLACE(REPLACE(cData,'~n',''),'~r',','),', ').

  DO i = 1 TO NUM-ENTRIES(cData,' '):
    CREATE btStone.
    ASSIGN btStone.iOrder = i
           btStone.iValue = INT64(ENTRY(i,cData,' ')).
  END.
END PROCEDURE. 

DEFINE VARIABLE giBlink AS INT64 NO-UNDO.
DEFINE VARIABLE giOrder AS INT64 NO-UNDO.
DEFINE VARIABLE i       AS INT64 NO-UNDO.
DEFINE VARIABLE giPartA AS INT64 NO-UNDO.

DEFINE BUFFER btStone  FOR ttStone. 
DEFINE BUFFER btStone2 FOR ttStone.

ETIME(YES).
RUN readData('data.txt').

DO giBlink = 1 TO 25:

  giOrder = giOrder + 1.

  FOR EACH btStone
    WHERE btStone.iBlink = (giOrder - 1):

    IF btStone.iValue = 0 THEN 
    DO:
      /* 0 -> 1 */
      CREATE btStone2.
      ASSIGN 
         btStone2.iBlink = btStone.iBlink + 1
         btStone2.iOrder = giOrder
         btStone2.iValue = 1.
    END.

    ELSE 
    IF LENGTH(STRING(btStone.iValue)) MOD 2 = 0 THEN 
    DO:
      /* Split */
      DO i = 1 TO 2:
        CREATE btStone2.
        ASSIGN 
          btStone2.iBlink = btStone.iBlink + 1
          btStone2.iOrder = giOrder
          btStone2.iValue = split(i,btStone.iValue).
      END.
    END. 

    ELSE 
    DO:
      /* x 2024 */
      CREATE btStone2.
      ASSIGN 
        btStone2.iBlink = btStone.iBlink + 1
        btStone2.iOrder = giOrder
        btStone2.iValue = btStone.iValue * 2024.
    END.

    DELETE btStone.
  END. /* For each stone */
END. 

FOR EACH btStone WHERE btStone.iBlink = giOrder:
  giPartA = giPartA + 1.
END.

MESSAGE giPartA "in" ETIME "ms" /* 220999 in 10414 ms */
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
