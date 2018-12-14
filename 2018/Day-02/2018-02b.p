/* Advent of code 2018
** day 2
*/
DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMask AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttBox NO-UNDO
  FIELD cBoxId AS CHARACTER FORMAT 'x(20)'.
DEFINE BUFFER bBox FOR ttBox. 

INPUT FROM "2018-02.dat".
REPEAT:
  CREATE ttBox.
  IMPORT ttBox.cBoxId.
END. 
INPUT CLOSE. 

#Main:
FOR EACH ttBox: 
  DO i = 1 TO LENGTH(ttBox.cBoxId):
    cMask = ttBox.cBoxId.
    SUBSTRING(cMask,i,1) = '*'.
    FIND bBox 
      WHERE bBox.cBoxId MATCHES cMask AND RECID(bBox) <> RECID(ttBox) NO-ERROR.
    IF AVAILABLE bBox THEN 
    DO:
      MESSAGE bBox.cBoxId SKIP ttBox.cBoxId
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      LEAVE #Main.
    END.
  END.
END.

/*

---------------------------
Information
---------------------------
agimdjvlhedpsyoqfzuknpjwt 
agimdjvlhedpsyoqfzuknpjwt
---------------------------
OK   
---------------------------
*/
