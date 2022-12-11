/* List.cls
*/
CLASS tools.List:

DEFINE TEMP-TABLE ttList NO-UNDO
  FIELD iNr   AS INTEGER
  FIELD cData AS CHARACTER 
  INDEX iPrim IS PRIMARY iNr
  INDEX iData cData.

  DEFINE PUBLIC PROPERTY iSize AS INTEGER NO-UNDO 
    GET: RETURN iSize. END GET. 
    PRIVATE SET.

  /* Add element to begin or end of list */
  METHOD PRIVATE tools.List addElement 
    ( pcData  AS CHARACTER
    , plFirst AS LOGICAL 
    ):
    DEFINE BUFFER bList FOR ttList.
    DEFINE VARIABLE iElementNr AS INTEGER NO-UNDO.

    IF pcData = "" THEN RETURN ?.

    IF plFirst THEN FIND FIRST bList NO-ERROR.
               ELSE FIND LAST bList NO-ERROR.

    iElementNr = (IF AVAILABLE bList THEN bList.iNr - 1 ELSE 0)
               + (IF plFirst THEN -1 ELSE 1).

    CREATE bList.
    ASSIGN bList.iNr   = iElementNr
           bList.cData = pcData
           iSize       = iSize + 1.

    RETURN THIS-OBJECT.
  END METHOD. /* addElement */


  /* Add to begin of list */
  METHOD PUBLIC tools.List addFirst (pcData AS CHARACTER):
    RETURN addElement(pcData, YES).
  END METHOD. /* addFirst */


  /* Add to end of list */
  METHOD PUBLIC tools.List addLast (pcData AS CHARACTER):
    RETURN addElement(pcData, NO).
  END METHOD. /* addLast */


  /* Add to end of list */
  METHOD PUBLIC tools.List push (pcData AS CHARACTER):
    RETURN addElement(pcData, NO).
  END METHOD. /* push */


  /* Return first or last element and remove it */
  METHOD PRIVATE CHARACTER popElement 
    ( plFirst AS LOGICAL 
    ):
    DEFINE BUFFER bList FOR ttList.
    DEFINE VARIABLE cValue AS CHARACTER NO-UNDO.
  
    IF plFirst THEN FIND FIRST bList NO-ERROR.
               ELSE FIND LAST bList NO-ERROR.

    IF AVAILABLE bList THEN 
    DO:
      cValue = bList.cData.
      iSize = iSize - 1.
      DELETE bList.
      RETURN cValue.  
    END.
    ELSE 
      RETURN ?.
  END METHOD. /* popElement */


  /* Return first element and remove it */
  METHOD PUBLIC CHARACTER popFirst ():
    RETURN popElement(YES).
  END METHOD. /* popFirst */


  /* Return last element and remove it */
  METHOD PUBLIC CHARACTER popLast ():
    RETURN popElement(NO).
  END METHOD. /* popLast */


  /* Return last element and remove it */
  METHOD PUBLIC CHARACTER pop ():
    RETURN popElement(NO).
  END METHOD. /* pop */


  /* Return first/last element without removing */
  METHOD PRIVATE CHARACTER peekElement 
    ( plFirst AS LOGICAL 
    ):
    DEFINE BUFFER bList FOR ttList.
  
    IF plFirst THEN FIND FIRST bList NO-ERROR.
               ELSE FIND LAST bList NO-ERROR.

    RETURN (IF AVAILABLE bList THEN bList.cData ELSE ?).
  END METHOD. /* peekElement */


  /* Return first element without removing */
  METHOD PUBLIC CHARACTER peekFirst ():
    RETURN peekElement(YES).
  END METHOD. /* peekFirst */


  /* Return last element without removing */
  METHOD PUBLIC CHARACTER peekLast ():
    RETURN peekElement(NO).
  END METHOD. /* peekLast */


  /* Is the List empty? */
  METHOD PUBLIC LOGICAL isEmpty():
    RETURN (iSize = 0).
  END METHOD. /* isEmpty */


  /* Is the List empty? */
  METHOD PUBLIC LOGICAL isInList(pcData AS CHARACTER):
    DEFINE BUFFER bList FOR ttList.
    FIND FIRST bList WHERE bList.cData = pcData NO-ERROR.
    RETURN (AVAILABLE bList).
  END METHOD. /* isInList */


  /* Is the List empty? */
  METHOD PUBLIC LOGICAL swap(pcData-1 AS CHARACTER, pcData-2 AS CHARACTER):
    DEFINE BUFFER bList-1 FOR ttList.
    DEFINE BUFFER bList-2 FOR ttList.

    FIND FIRST bList-1 WHERE bList-1.cData = pcData-1 NO-ERROR.
    FIND FIRST bList-2 WHERE bList-2.cData = pcData-2 NO-ERROR.

    IF NOT AVAILABLE bList-1 OR NOT AVAILABLE bList-2 THEN RETURN NO.
    bList-1.cData = pcData-2.
    bList-2.cData = pcData-1.
    
    RETURN YES.
  END METHOD. /* swap */


  METHOD PUBLIC CHARACTER getList (pcSep AS CHARACTER):
    DEFINE VARIABLE cValue AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cSep   AS CHARACTER NO-UNDO.
    DEFINE BUFFER bList FOR ttList.

    FOR EACH bList:
      cValue = cValue + cSep + bList.cData.
      cSep = pcSep.
    END.

    RETURN cValue.
  END METHOD. /* getList */

END CLASS. /* List */
