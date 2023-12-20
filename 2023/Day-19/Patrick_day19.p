DEFINE VARIABLE cInputFile   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iSolution    AS INT64     NO-UNDO.
DEFINE VARIABLE cInputLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cProgramFile AS CHARACTER NO-UNDO INITIAL "C:\OpenEdge\WRK\AOC2023\Patrick_day19fns.p".
DEFINE VARIABLE hProgram     AS HANDLE    NO-UNDO.
DEFINE VARIABLE lFoundInput  AS LOGICAL   NO-UNDO.
DEFINE VARIABLE intX         AS INTEGER   NO-UNDO.
DEFINE VARIABLE intM         AS INTEGER   NO-UNDO.
DEFINE VARIABLE intA         AS INTEGER   NO-UNDO.
DEFINE VARIABLE intS         AS INTEGER   NO-UNDO.
DEFINE VARIABLE fnCall       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cReturnValue AS CHARACTER NO-UNDO.
DEFINE VARIABLE iStartInput  AS INTEGER   NO-UNDO.

/* Patrick's input: */
ETIME(TRUE).
cInputfile = "C:\Users\wim\Downloads\data (1).txt".

RUN VALUE (cProgramFile) PERSISTENT SET hProgram.             

lFoundInput = FALSE.
INPUT FROM VALUE (cInputFile).
REPEAT:
   IMPORT UNFORMATTED 
   	cInputLine.
   	
	IF TRIM (cInputLine) EQ "" THEN DO:
	   lFoundInput = TRUE.
	   NEXT.
	END.
	
   IF lFoundInput THEN DO:		
      
      RUN getInputValues
         (INPUT  cInputLine,
          OUTPUT intX,
          OUTPUT intM,
          OUTPUT intA,
          OUTPUT intS).

      /* Start with function 'in' */  
      fnCall = "fnin".
      fnCallBlock:
      REPEAT:
         cReturnValue = DYNAMIC-FUNCTION (fnCall IN hProgram, intX, intM, intA, intS).
         IF cReturnValue EQ "R" THEN
            /* Rejected */
            LEAVE fnCallBlock.
         IF cReturnValue EQ "A" THEN DO:
            /* Accepted */
            iSolution = iSolution + (intX + intM + intA + intS).
            LEAVE fnCallBlock.
         END.
         /* Continue the Workflow */
         fnCall = SUBSTITUTE ("fn&1", cReturnValue).
      END.
   END.
END.

   
OUTPUT TO "clipboard".
PUT UNFORMATTED iSolution SKIP.
OUTPUT CLOSE.
MESSAGE 
   SUBSTITUTE ("Solution: &1.", iSolution) SKIP (1)
   SUBSTITUTE ("Found solution in &1 msecs.", ETIME)
VIEW-AS ALERT-BOX TITLE " 2023 - Day 19 - Part One".
   
   
   
PROCEDURE getInputValues:
/*------------------------------------------------------------------------------
 Purpose: Extract the values for x, m, a, s from an input line
 Notes:   Sample input line:
          {x=1065,m=825,a=1002,s=2038}
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER ipcValueList AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER opiX         AS INTEGER   NO-UNDO.
DEFINE OUTPUT PARAMETER opiM         AS INTEGER   NO-UNDO.
DEFINE OUTPUT PARAMETER opiA         AS INTEGER   NO-UNDO.
DEFINE OUTPUT PARAMETER opiS         AS INTEGER   NO-UNDO.

DEFINE VARIABLE iPair     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cPair     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cVariable AS CHARACTER NO-UNDO.
DEFINE VARIABLE iValue    AS INTEGER NO-UNDO.

   /* Remove {} characters */
   ipcValueList = TRIM (ipcValueList, "~{}").

   /* Loop through the variable=value pairs */
   DO iPair = 1 TO NUM-ENTRIES (ipcValueList):
      cPair = ENTRY (iPair, ipcValueList).
      ASSIGN 
         cVariable = ENTRY (1, cPair, "=")
         iValue    = INTEGER (ENTRY (2, cPair, "="))
      .
      CASE cVariable:
         WHEN "x" THEN opiX = iValue.
         WHEN "m" THEN opiM = iValue.
         WHEN "a" THEN opiA = iValue.
         WHEN "s" THEN opiS = iValue.
      END CASE.   
   END.
   
END PROCEDURE.
