/* AoC 2021 day 20a + b
 */ 
DEFINE VARIABLE giEnhancer AS INTEGER   NO-UNDO EXTENT 512.
DEFINE VARIABLE giTurn     AS INTEGER   NO-UNDO.
DEFINE VARIABLE giDefault  AS INTEGER   NO-UNDO INITIAL 1.

DEFINE TEMP-TABLE ttLoc NO-UNDO
  FIELD lFlag  AS LOGICAL 
  FIELD iPosY  AS INTEGER /* y-pos */
  FIELD iPosX  AS INTEGER /* x-pos */
  FIELD iValue AS INTEGER
  INDEX iPrim lFlag iPosY iPosX. 

FUNCTION getNumBits RETURNS INTEGER(plFlag AS LOGICAL):
  /* Calc total nr of bits 
  */
  DEFINE VARIABLE iNum  AS INTEGER   NO-UNDO.
  DEFINE BUFFER bLoc FOR ttLoc.

  FOR EACH bLoc WHERE bLoc.lFlag = plFlag:
    iNum = iNum + bLoc.iValue.
  END.
  RETURN iNum.
END FUNCTION.


RUN readData(FALSE).

DO giTurn = 1 TO 25:
  RUN enhanceImage(FALSE).
  RUN enhanceImage(TRUE).
  IF giTurn = 1  THEN MESSAGE "Part 1:" getNumBits(FALSE) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 5765 */
  IF giTurn = 25 THEN MESSAGE "Part 2:" getNumBits(FALSE) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 18509 */
END.

RUN showGrid(FALSE). 


PROCEDURE enhanceImage:
  DEFINE INPUT PARAMETER plFlag AS LOGICAL NO-UNDO.
  
  DEFINE VARIABLE iBoxX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iBoxY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iVal     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iBitNr   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iBitVal  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE lNewFlag AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE iMinX    AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxX    AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMinY    AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY    AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iFieldX  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iFieldY  AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iBinary  AS INTEGER   NO-UNDO EXTENT 9 INITIAL [1,2,4,8,16,32,64,128,256].

  DEFINE BUFFER bLoc  FOR ttLoc.
  DEFINE BUFFER bLoc2 FOR ttLoc.

  /*
  Een default waarde meegeven voor lookups buiten het bord. 
  Als t[0] = '.' dan is de default altijd 0. 
  Als t[0] = '#' en t[511] = '#' dan is de waarde de eerste keer 0 en daarna 1. 
  En als t[0] = '#' and t[511] = '.' dan alterneert de waarde tussen 0 en 1 
  */
  IF giEnhancer[1] = 0 THEN giDefault = 0.
  IF giEnhancer[1] = 1 AND giEnhancer[512] = 1 THEN giDefault = (IF giTurn = 1 THEN 0 ELSE 1).
  IF giEnhancer[1] = 1 AND giEnhancer[512] = 0 THEN giDefault = (1 - giDefault).

  /* Toggle flag */
  lNewFlag = NOT plFlag.

  /* Find min/max dimensions */
  RUN getGridSize(plFlag, OUTPUT iMinX, OUTPUT iMaxX, OUTPUT iMinY, OUTPUT iMaxY).

  /* Calc new pixel values, use a slightly larger box 
  */
  DO iFieldY = iMinY - 1 TO iMaxY + 1:
    DO iFieldX = iMinX - 1 TO iMaxX + 1:

      IF ETIME > 1000 THEN DO:
        HIDE MESSAGE NO-PAUSE. 
        MESSAGE giTurn iFieldY iFieldX.
        ETIME(YES).
        PROCESS EVENTS. 
      END.
    
      /* Calc bit value of 3x3 box around pixel */
      iVal = 0.
      iBitNr = 9.
      DO iBoxY = -1 TO 1:
        DO iBoxX = -1 TO 1:
          FIND bLoc2 WHERE bLoc2.lFlag = plFlag AND bLoc2.iPosX = iFieldX + iBoxX AND bLoc2.iPosY = iFieldY + iBoxY NO-ERROR.
          iBitNr = iBitNr - 1.
          iBitVal = (IF AVAILABLE bLoc2 THEN bLoc2.iValue ELSE giDefault).
          IF iBitVal = 1 THEN iVal = iVal + iBinary[iBitNr + 1].
        END.
      END.

      /* Set new value from enhancement algorithm */
      FIND bLoc2 WHERE bLoc2.lFlag = lNewFlag AND bLoc2.iPosX = iFieldX AND bLoc2.iPosY = iFieldY NO-ERROR.
      IF NOT AVAILABLE bLoc2 THEN 
      DO:
        CREATE bLoc2.
        ASSIGN bLoc2.lFlag = lNewFlag
               bLoc2.iPosX = iFieldX 
               bLoc2.iPosY = iFieldY.
      END.
      bLoc2.iValue = giEnhancer[iVal + 1].

    END.
  END.

END PROCEDURE. /* enhanceImage */


PROCEDURE getGridSize:
  DEFINE INPUT  PARAMETER plFlag AS LOGICAL     NO-UNDO.
  DEFINE OUTPUT PARAMETER piMinX AS INTEGER     NO-UNDO.
  DEFINE OUTPUT PARAMETER piMaxX AS INTEGER     NO-UNDO.
  DEFINE OUTPUT PARAMETER piMinY AS INTEGER     NO-UNDO.
  DEFINE OUTPUT PARAMETER piMaxY AS INTEGER     NO-UNDO.
  
  DEFINE BUFFER bLoc FOR ttLoc. 
  
  FOR EACH bLoc WHERE bLoc.lFlag = plFlag:
    ACCUMULATE bLoc.iPosX (MIN MAX). 
    ACCUMULATE bLoc.iPosY (MIN MAX).
  END.
  
  piMinX = ACCUM MIN bLoc.iPosX.
  piMaxX = ACCUM MAX bLoc.iPosX.
  piMinY = ACCUM MIN bLoc.iPosY.
  piMaxY = ACCUM MAX bLoc.iPosY.  
  
END PROCEDURE. /* getGridSize */


PROCEDURE readData:
  /* Read grid via longchar into TT
  */
  DEFINE INPUT PARAMETER plFlag AS LOGICAL NO-UNDO.

  DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL ?.

  DEFINE BUFFER bLoc FOR ttLoc. 
  
  /* Read data and strip nasty characters */
  COPY-LOB FILE "{&path}data.txt" TO cData.
  cData = TRIM(REPLACE(cData,'~r',''),'~n').

  /* Image enhance map */
  cLine = ENTRY(1, cData, '~n').
  DO i = 1 TO LENGTH(cLine):
    giEnhancer[i] = (IF SUBSTRING(cLine,i,1) = "#" THEN 1 ELSE 0).
  END.

  /* Rest of data is playing field */
  cData = TRIM(SUBSTRING(cData, LENGTH(cLine) + 1)).
  iMaxX = LENGTH(ENTRY(1,cData,'~n')).
  iMaxY = NUM-ENTRIES(cData,'~n').
  
  DO iY = 1 TO iMaxY:
    DO iX = 1 TO iMaxX:
      CREATE bLoc.
      ASSIGN 
        bLoc.lFlag  = plFlag
        bLoc.iPosX  = iX
        bLoc.iPosY  = iY
        bLoc.iValue = (IF SUBSTRING(ENTRY(iY, cData, '~n'), iX, 1) = "#" THEN 1 ELSE 0).
    END.
  END.
    
END PROCEDURE. /* readData */


PROCEDURE showGrid:
  /* Show a grid (debugging)
  */
  DEFINE INPUT PARAMETER plFlag AS LOGICAL NO-UNDO.
  
  DEFINE VARIABLE cGrid AS LONGCHAR  NO-UNDO.
  DEFINE VARIABLE iX    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iY    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMinX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMinY AS INTEGER   NO-UNDO INITIAL ?.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL ?.

  DEFINE BUFFER bLoc FOR ttLoc.

  /* Find min/max dimensions */
  RUN getGridSize(plFlag, OUTPUT iMinX, OUTPUT iMaxX, OUTPUT iMinY, OUTPUT iMaxY).

  /* Export to var
  */
  DO iY = iMinY TO iMaxY:
    DO iX = iMinX TO iMaxX:
      FIND FIRST bLoc WHERE bLoc.lFlag = plFlag AND bLoc.iPosX = iX AND bLoc.iPosY = iY NO-ERROR.
      cGrid = cGrid + STRING(AVAILABLE bLoc AND bLoc.iValue = 1, "#/.").
    END.
    cGrid = cGrid + "~n".
  END.

  /* Show and dump */
  COPY-LOB cGrid TO FILE "{&path}debug.txt".

END PROCEDURE. /* showGrid */
