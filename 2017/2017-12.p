/*------------------------------------------------------------------------
    File        : 2017-12.p
    Purpose     : Day 12 of AoC 2017 

    28-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

&GLOBAL-DEFINE testrun false 

DEFINE VARIABLE s AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttRoute NO-UNDO
  FIELD a AS CHARACTER
  FIELD b AS CHARACTER. 

DEFINE TEMP-TABLE ttProg NO-UNDO  
  FIELD cName  AS CHARACTER
  FIELD cRoute AS CHARACTER FORMAT 'x(30)'. 
  
FUNCTION getRouteToZero RETURNS CHARACTER 
  ( cRouteSoFar AS CHARACTER
  , cStartNode  AS CHARACTER ):
  
  DEFINE BUFFER bRoute FOR ttRoute.
  DEFINE BUFFER bProg FOR ttProg.
  DEFINE VARIABLE cReturnValue AS CHARACTER   NO-UNDO.

  cRouteSoFar = cRouteSoFar + ',' + cStartNode.
  
  FOR EACH bRoute WHERE bRoute.a = cStartNode:
    IF bRoute.b = '0' THEN RETURN TRIM(cRouteSoFar + ',0',','). // found it!
    IF LOOKUP(bRoute.b, cRouteSoFar) > 0 THEN NEXT. // already done
    FIND bProg WHERE bProg.cName = bRoute.b.
    IF bProg.cRoute <> '' THEN RETURN TRIM(cRouteSoFar + ',' + bProg.cRoute,','). // found it!
    cReturnValue = TRIM(getRouteToZero(cRouteSoFar, bRoute.b),','). // route to 0 s
    IF cReturnValue <> '' THEN RETURN cReturnValue.
  END.
  
  RETURN "".  
END FUNCTION.

PAUSE 0 BEFORE-HIDE. 

/* Attempt 1: eliminate opposite steps */
RUN getData(OUTPUT s).

FOR EACH ttProg:
  ttProg.cRoute = getRouteToZero('',ttProg.cName).
  IF ETIME > 1000 THEN DO:
    MESSAGE ttProg.cName.
    ETIME(YES).
  END.
END.

FOR EACH ttProg WHERE ttProg.cRoute <> '':
  DISPLAY ttProg.
END.

// uikomst ?!?!?


PROCEDURE getData:
  DEFINE OUTPUT PARAMETER s AS LONGCHAR NO-UNDO.
  
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DEFINE VARIABLE k AS CHARACTER NO-UNDO.
  DEFINE VARIABLE p AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.
 
  COPY-LOB FILE 'd:\Data\DropBox\AdventOfCode\2017\2017-12-input.dat' TO s.
  s = TRIM(s,'~n').
  
  IF {&testrun} THEN
    s = '0 <-> 2 ~n
         1 <-> 1 ~n
         2 <-> 0, 3, 4 ~n
         3 <-> 2, 4 ~n
         4 <-> 2, 3, 6 ~n
         5 <-> 6 ~n
         6 <-> 4, 5'. 

  DO i = 1 TO NUM-ENTRIES(s,'~n'):
                        
    c = TRIM(ENTRY(i,s,'~n')).
    p = TRIM(ENTRY(1,c,' ')).
    k = TRIM(ENTRY(2,c,'>')).
    k = REPLACE(k,' ','').
    
    CREATE ttProg.
    ASSIGN ttProg.cName = p.
    
    DO j = 1 TO NUM-ENTRIES(k):
      IF p = ENTRY(j,k) THEN NEXT. 
      /* register route a -> b */
      IF NOT CAN-FIND(ttRoute WHERE ttRoute.a = p AND ttRoute.b = ENTRY(j,k)) THEN
      DO:
        CREATE ttRoute. ASSIGN ttRoute.a = p ttRoute.b = ENTRY(j,k).
      END.
      /* and other way around a <- b as well*/
      IF NOT CAN-FIND(ttRoute WHERE ttRoute.b = p AND ttRoute.a = ENTRY(j,k)) THEN
      DO:
        CREATE ttRoute. ASSIGN ttRoute.b = p ttRoute.a = ENTRY(j,k).
      END.
    END.    
  END.         
         
END PROCEDURE.   
  
  
  
  
  
  
  
  
  
  
  
  
  
