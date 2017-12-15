/*------------------------------------------------------------------------
    File        : 2017-08.p
    Purpose     : Day 8 of AoC 2017 (a and b)

    15-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE cInst      AS CHARACTER NO-UNDO EXTENT.
DEFINE VARIABLE iMaxVal    AS INTEGER   NO-UNDO INITIAL ?.
DEFINE VARIABLE iMaxEndVal AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttInst
  FIELD iNum  AS INTEGER   FORMAT '->>9'
  FIELD cReg  AS CHARACTER FORMAT 'x(4)'
  FIELD cIns  AS CHARACTER FORMAT 'x(4)'
  FIELD iAmt  AS INTEGER   FORMAT '->>9'
  FIELD cIf   AS CHARACTER FORMAT 'x(4)'
  FIELD cOpr  AS CHARACTER FORMAT 'x(4)'
  FIELD cCmp  AS CHARACTER FORMAT 'x(4)'
  FIELD iCmp  AS INTEGER   FORMAT '->>9'
  . 

DEFINE TEMP-TABLE ttReg
  FIELD cReg AS CHARACTER
  FIELD iVal AS INTEGER. 
  
FUNCTION addReg RETURNS LOGICAL
  ( pcReg AS CHARACTER
  , pcIns AS CHARACTER
  , piVal AS INTEGER):
  
  DEFINE BUFFER bReg FOR ttReg. 
  FIND bReg WHERE bReg.cReg = pcReg NO-ERROR.
  IF NOT AVAILABLE bReg THEN 
  DO:
    CREATE bReg.
    ASSIGN bReg.cReg = pcReg.
  END.
  IF pcIns = 'dec' THEN bReg.iVal = bReg.iVal - piVal.  
  IF pcIns = 'inc' THEN bReg.iVal = bReg.iVal + piVal.  
END FUNCTION. 

FUNCTION chkReg RETURNS LOGICAL
  ( pcReg AS CHARACTER
  , pcOpr AS CHARACTER
  , piVal AS INTEGER):
  
  DEFINE BUFFER bReg FOR ttReg. 
  FIND bReg WHERE bReg.cReg = pcReg NO-ERROR.
  IF NOT AVAILABLE bReg THEN 
  DO:
    CREATE bReg.
    ASSIGN bReg.cReg = pcReg.
  END.
  
  CASE pcOpr:
    WHEN '>'  THEN RETURN bReg.iVal >  piVal.
    WHEN '<'  THEN RETURN bReg.iVal <  piVal.
    WHEN '>=' THEN RETURN bReg.iVal >= piVal.
    WHEN '<=' THEN RETURN bReg.iVal <= piVal.
    WHEN '!=' THEN RETURN bReg.iVal <> piVal.
    WHEN '==' THEN RETURN bReg.iVal =  piVal.
    OTHERWISE MESSAGE pcOpr VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  END CASE.
END FUNCTION.  
  
RUN getData('d:\Data\DropBox\AdventOfCode\2017\2017-08-input.dat').


FOR EACH ttInst:
  IF chkReg(ttInst.cCmp, ttInst.cOpr, ttInst.iCmp)
    THEN addReg(ttInst.cReg, ttInst.cIns, ttInst.iAmt).
    ELSE addReg(ttInst.cReg, ttInst.cIns, 0).
    
  FOR EACH ttReg:
    IF iMaxVal = ? THEN iMaxVal = ttReg.iVal.
    iMaxVal = MAXIMUM(iMaxVal,ttReg.iVal).
  END.    
END.

FOR EACH ttReg BY ttReg.iVal DESC:
  iMaxEndVal = ttReg.iVal.
  LEAVE.
END.

MESSAGE 
  'Max end val:' iMaxEndVal '(a)' SKIP
  'Max val during:' iMaxVal '(b)' 
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


PROCEDURE getData:
  DEFINE INPUT PARAMETER pcFile AS CHARACTER   NO-UNDO.
  DEFINE VARIABLE cData AS LONGCHAR NO-UNDO.
  DEFINE VARIABLE ii    AS INTEGER  NO-UNDO.
  DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
  
  COPY-LOB FROM FILE pcFile TO cData.
  DO ii = 1 TO NUM-ENTRIES(cData,'~n'):
    cLine = TRIM(ENTRY(ii,cData,'~n')).
    IF cLine = '' THEN LEAVE. 
  
    CREATE ttInst.
    ASSIGN 
        ttInst.iNum = ii
        ttInst.cReg = TRIM(ENTRY(1,cLine,' '))
        ttInst.cIns = TRIM(ENTRY(2,cLine,' '))
        ttInst.iAmt = INTEGER(TRIM(ENTRY(3,cLine,' ')))
        ttInst.cIf  = TRIM(ENTRY(4,cLine,' '))
        ttInst.cCmp = TRIM(ENTRY(5,cLine,' '))
        ttInst.cOpr = TRIM(ENTRY(6,cLine,' '))
        ttInst.iCmp = INTEGER(TRIM(ENTRY(7,cLine,' ')))
        . 
    
  END.
  
END PROCEDURE. 
