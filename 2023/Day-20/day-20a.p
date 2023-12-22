/* AoC 2023 day 20a 
 */ 
DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO. 
DEFINE VARIABLE cFrom AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cTo   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cMod  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE low   AS LOGICAL     NO-UNDO INITIAL FALSE.
DEFINE VARIABLE high  AS LOGICAL     NO-UNDO INITIAL TRUE.

DEFINE TEMP-TABLE ttMod
  FIELD cName   AS CHARACTER
  FIELD cType   AS CHARACTER
  FIELD cSendTo AS CHARACTER
  FIELD lHigh   AS LOGICAL /* on/off */ 
  FIELD cInputs AS CHARACTER /* list of inputs */
  . 
DEFINE TEMP-TABLE ttTodo
  FIELD iOrder     AS INTEGER
  FIELD cModule    AS CHARACTER
  FIELD lHighPulse AS LOGICAL
  INDEX iPrim iOrder.
  
DEFINE BUFFER ttMod2 FOR ttMod.
  
INPUT FROM "test.txt".
REPEAT:
  IMPORT UNFORMATTED cLine.
  cFrom = TRIM(ENTRY(1,cLine," ")).
  cTo   = TRIM(ENTRY(2,cLine,">")).
  
  FIND ttMod WHERE ttMod.cName = cFrom NO-ERROR.
  IF NOT AVAILABLE ttMod THEN 
  DO:
    CREATE ttMod.
    ASSIGN ttMod.cName = cFrom
           ttMod.cType = (IF cName BEGINS "%" THEN "FF" ELSE
                          IF cName BEGINS "&" THEN "CON" ELSE "Other")
           ttMod.cSendTo = REPLACE(cTo," ","").
           
    IF ttMod.cType <> "other" THEN
      ttMod.cName = SUBSTRING(ttMod.cName,2).
  END.
END.
INPUT CLOSE. 

/* Find flipflops connected to conjunction */
FOR EACH ttMod WHERE ttMod.cType = "CON":
  FOR EACH ttMod2 
    WHERE ttMod2.cType = "FF" 
      AND LOOKUP(ttMod.cName, ttMod2.cSendTo) > 0:
    ttMod.cInputs = TRIM(ttMod.cInputs + "," + ttMod2.cName,",").
  END.
END.


FUNCTION addTask RETURNS LOGICAL (pcModule AS CHARACTER, plHigh AS LOGICAL):
  DEFINE BUFFER btLast FOR ttTodo.
  DEFINE BUFFER btTodo FOR ttTodo.
  FIND LAST btLast NO-ERROR.
  CREATE btTodo. 
  ASSIGN btTodo.iOrder     = (IF AVAILABLE btLast THEN btLast.iOrder + 1 ELSE 1)
         btTodo.cModule    = pcModule
         btTodo.lHighPulse = plHigh.
END FUNCTION.         

FOR EACH ttMod: DISP ttMod.
END.

/* addTask("broadcaster", low).                     */
/*                                                  */
/* REPEAT:                                          */
/*   FIND FIRST ttTodo NO-ERROR.                    */
/*   IF NOT AVAILABLE ttTodo THEN LEAVE.            */
/*                                                  */
/*   FIND ttMod WHERE ttMod.cName = ttTodo.cModule. */
/*                                                  */
/*   DO i = 1 TO NUM-ENTRIES(ttMod.cSendTo):        */
/*     addTask(ENTRY(i,ttMod.cSendTo),ttMod.lHigh). */
/*   END.                                           */
/*                                                  */
/*   DELETE ttTodo.                                 */
/* END.                                             */
/*                                                  */

/*
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a 
*/
