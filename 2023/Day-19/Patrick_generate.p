PROCEDURE addFunction:
/*------------------------------------------------------------------------------
 Purpose: Transform input string in a function
 Notes:   Sample input:
          brn{a>3342:A,R}
          
          
      
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER ipcFunction AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER opcCode     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cTemplateStart AS CHARACTER NO-UNDO.
DEFINE VARIABLE cTemplateEnd   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cName          AS CHARACTER NO-UNDO.
DEFINE VARIABLE iRule          AS INTEGER   NO-UNDO.
DEFINE VARIABLE cRule          AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFunctionStart AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFunctionBody  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFunctionEnd   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iOperator      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cOperators     AS CHARACTER NO-UNDO INITIAL "<>".
DEFINE VARIABLE cOperator      AS CHARACTER NO-UNDO.
DEFINE VARIABLE cTest          AS CHARACTER NO-UNDO.
DEFINE VARIABLE cNext          AS CHARACTER NO-UNDO.
DEFINE VARIABLE iPart          AS INTEGER   NO-UNDO.
DEFINE VARIABLE cPart          AS CHARACTER NO-UNDO.
   ASSIGN 
      cTemplateStart = "FUNCTION fn&2 RETURNS CHARACTER (x AS INT, m AS INT, a AS INT, s AS INT):" + "~n" +
                       "/*------------------------------------------------------------------------------" + "~n" +
                       "Purpose: Workflow implemenation for '&2'" + "~n" +
                       "Notes:   &1" + "~n" +
                       "------------------------------------------------------------------------------*/"
      cTemplateEnd   = "END FUNCTION."
   .                       
   ASSIGN 
      cName = ENTRY (1, ipcFunction, "~{")
   .
   
   
   ASSIGN 
      cFunctionStart = SUBSTITUTE (cTemplateStart,
                                   ipcFunction,
                                   cName)
   .
   
   ipcFunction = ENTRY (1, SUBSTRING (ipcFunction, INDEX (ipcFunction, "~{") + 1), "}").
   
   opcCode = cFunctionStart.
   
   DO iPart = 1 TO NUM-ENTRIES (ipcFunction):
      cPart = ENTRY (iPart, ipcFunction).
      
      IF NUM-ENTRIES (cPart, ":") EQ 2 THEN DO:
         /* Add spaces around operator */
         DO iOperator = 1 TO LENGTH (cOperators):
            cOperator = SUBSTRING (cOperators, iOperator, 1).
            cPart = REPLACE (cPart, cOperator, " " + cOperator + " ").
         END.
         
         ASSIGN
            cTest = ENTRY (1, cPart, ":") 
            cNext = ENTRY (2, cPart, ":")
         .
         
         cFunctionBody = SUBSTITUTE ("   IF &1 THEN RETURN &2.", cTest, QUOTER (cNext)).
         
         /* Save Function Body for Part Two */
         iNewIDFunctionBody = iNewIDFunctionBody + 1.
         CREATE ttFunctionBody.
         ASSIGN 
            ttFunctionBody.IDFunctionBody    = iNewIDFunctionBody
            ttFunctionBody.FunctionName      = cName
            ttFunctionBody.ParameterName     = ENTRY (1, cTest, " ")
            ttFunctionBody.ParameterOperator = ENTRY (2, cTest, " ")
            ttFunctionBody.ParameterValue    = INTEGER (ENTRY (3, cTest, " "))
            ttFunctionBody.ReturnValue       = cNext
         . 
         IF  cNext NE "A"
         AND cNext NE "R" THEN DO:
            iNewIDFun2Fun = iNewIDFun2Fun + 1.
            CREATE ttFun2Fun.
            ASSIGN 
               ttFun2Fun.IDFun2Fun      = iNewIDFun2Fun
               ttFun2Fun.FunctionFrom   = cName
               ttFun2Fun.FunctionTo     = cNext
               ttFun2Fun.IDFunctionBody = ttFunctionBody.IDFunctionBody
            .
         END.            
      END.
      ELSE DO:
         cNext = cPart.         
         cFunctionBody = SUBSTITUTE ("   RETURN &1.", QUOTER (cNext)).   
         /* Save Function Body for Part Two */
         iNewIDFunctionBody = iNewIDFunctionBody + 1.
         CREATE ttFunctionBody.
         ASSIGN 
            ttFunctionBody.IDFunctionBody    = iNewIDFunctionBody
            ttFunctionBody.FunctionName      = cName
            ttFunctionBody.ReturnValue       = cNext
         . 
         
         IF  cNext NE "A"
         AND cNext NE "R" THEN DO:
            iNewIDFun2Fun = iNewIDFun2Fun + 1.
            CREATE ttFun2Fun.
            ASSIGN 
               ttFun2Fun.IDFun2Fun      = iNewIDFun2Fun
               ttFun2Fun.FunctionFrom   = cName
               ttFun2Fun.FunctionTo     = cNext
               ttFun2Fun.IDFunctionBody = ttFunctionBody.IDFunctionBody
            .
         END.            
      END.
      
      opcCode = opcCode + "~n" + cFunctionBody.
   END.
   
   opcCode = opcCode + "~n" + cTemplateEnd. 
END PROCEDURE.