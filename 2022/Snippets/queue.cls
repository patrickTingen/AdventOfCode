/* Queue.cls
*/
CLASS tools.Queue:

DEFINE TEMP-TABLE ttQueue NO-UNDO
  FIELD iNr   AS INTEGER
  FIELD cData AS CHARACTER 
  INDEX iPrim IS PRIMARY iNr.

  DEFINE PUBLIC PROPERTY iSize AS INTEGER NO-UNDO 
    GET: RETURN iSize. END GET. 
    PRIVATE SET.

  /* Queue push 
  */
  METHOD PUBLIC tools.Queue push (pcData AS CHARACTER):
    DEFINE BUFFER bQueue FOR ttQueue.
  
    IF pcData = "" THEN RETURN ?.
    iSize = iSize + 1.
  
    CREATE bQueue.
    ASSIGN bQueue.iNr   = iSize
           bQueue.cData = pcData.
  
    RETURN THIS-OBJECT.
  END METHOD. 


  /* Queue pop 
  */
  METHOD PUBLIC CHARACTER pop ():
    DEFINE BUFFER bQueue FOR ttQueue.
    DEFINE VARIABLE cValue AS CHARACTER NO-UNDO.
  
    FIND FIRST bQueue NO-ERROR.
    IF AVAILABLE bQueue THEN 
    DO:
      cValue = bQueue.cData.
      iSize = iSize - 1.
      DELETE bQueue.
      RETURN cValue.  
    END.
    ELSE 
      RETURN ?.
  END METHOD. 


  /* Queue peek
  */
  METHOD PUBLIC CHARACTER peek ():
    DEFINE BUFFER bQueue FOR ttQueue.
  
    FIND FIRST bQueue NO-ERROR.
    RETURN (IF AVAILABLE bQueue THEN bQueue.cData ELSE ?).
  END METHOD. /* peek */


  /* Data in the queue? 
  */
  METHOD PUBLIC LOGICAL isInQueue(pcData AS CHARACTER):
    DEFINE BUFFER bQueue FOR ttQueue.
    FIND FIRST bQueue WHERE bQueue.cData = pcData NO-ERROR.
    RETURN (AVAILABLE bQueue).
  END METHOD. 


  /* Is the Queue empty 
  */
  METHOD PUBLIC LOGICAL isEmpty():
    RETURN (iSize = 0).
  END METHOD. /* isEmpty */

END CLASS. /* Queue */
