/* Advent of code 2018
** day 1
*/
DEFINE TEMP-TABLE ttChange 
  FIELD iNr AS INTEGER
  FIELD iFr AS INTEGER
  INDEX iPrim AS PRIMARY iNr.
  
DEFINE TEMP-TABLE ttFreq NO-UNDO
  FIELD iNr AS INTEGER
  FIELD iFr AS INTEGER
  INDEX iPrim AS PRIMARY iFr iNr.

DEFINE VARIABLE cData   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iFreq#  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cLine#  AS CHARACTER .
DEFINE VARIABLE iCount# AS INTEGER   NO-UNDO.

PAUSE 0 BEFORE-HIDE. 

/* read data */
INPUT FROM "2018-01.dat".
REPEAT TRANSACTION:
  IMPORT cLine#.
  IF cLine# = '' THEN LEAVE.
  iCount# = iCount# + 1.
  CREATE ttChange.
  ASSIGN 
    ttChange.iNr = iCount# 
    ttChange.iFr = INTEGER(cLine#).
END. 

/* starting situation */
iCount# = 1.
iFreq#  = 0.

CREATE ttFreq.
ASSIGN ttFreq.iNr = iCount#
       ttFreq.iFr = iFreq#.

#main:       
REPEAT:
  FOR EACH ttChange BY ttChange.iNr:
    iCount# = iCount# + 1.
    iFreq#  = iFreq# + ttChange.iFr.
      
    CREATE ttFreq.
    ASSIGN ttFreq.iNr = iCount#
           ttFreq.iFr = iFreq#.
             
    IF CAN-FIND(ttFreq WHERE ttFreq.iFr = iFreq# AND ttFreq.iNr < iCount#) THEN
    DO:
      MESSAGE iFreq# VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      LEAVE #main.
    END.    
  END.    
  
  DISPLAY STRING(TIME,'hh:mm:ss') iCount# iFreq#.
  PROCESS EVENTS.   
  READKEY PAUSE 0.
  IF LASTKEY <> -1 THEN LEAVE.
  
END. /* main */

