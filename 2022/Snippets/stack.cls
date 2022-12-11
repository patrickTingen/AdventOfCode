/* Stack.cls
*/
CLASS tools.Stack:

DEFINE TEMP-TABLE ttStack NO-UNDO
  FIELD iNr   AS INTEGER
  FIELD cData AS CHARACTER 
  INDEX iPrim IS PRIMARY iNr.

  DEFINE PUBLIC PROPERTY iSize AS INTEGER NO-UNDO 
    GET: RETURN iSize. END GET. 
    PRIVATE SET.

  /* Stack push 
  */
  METHOD PUBLIC tools.Stack push (pcData AS CHARACTER):
    DEFINE BUFFER bStack FOR ttStack.
  
    IF pcData = "" THEN RETURN ?.
    iSize = iSize + 1.
  
    CREATE bStack.
    ASSIGN bStack.iNr   = iSize
           bStack.cData = pcData.
  
    RETURN THIS-OBJECT.
  END METHOD. /* push */

  /* Stack pop 
  */
  METHOD PUBLIC CHARACTER pop ():
    DEFINE BUFFER bStack FOR ttStack.
    DEFINE VARIABLE cValue AS CHARACTER NO-UNDO.
  
    FIND LAST bStack NO-ERROR.
    IF AVAILABLE bStack THEN 
    DO:
      cValue = bStack.cData.
      iSize = iSize - 1.
      DELETE bStack.
      RETURN cValue.  
    END.
    ELSE 
      RETURN ?.

  END METHOD. /* pop */

  /* Stack peek
  */
  METHOD PUBLIC CHARACTER peek ():
    DEFINE BUFFER bStack FOR ttStack.
  
    FIND LAST bStack NO-ERROR.
    RETURN (IF AVAILABLE bStack THEN bStack.cData ELSE ?).
  END METHOD. /* peek */

  /* Is the stack empty 
  */
  METHOD PUBLIC LOGICAL isEmpty():
    RETURN (iSize = 0).
  END METHOD. /* isEmpty */

END CLASS. /* Stack */
