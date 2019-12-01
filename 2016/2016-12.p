/* Advent of code, day 12 part 1 */

DEFINE TEMP-TABLE ttCmd NO-UNDO
  FIELD nr  AS INTEGER
  FIELD cmd AS CHARACTER
  FIELD op1 AS CHARACTER
  FIELD op2 AS CHARACTER
  INDEX iPrim nr.

DEFINE VARIABLE ptr    AS INTEGER NO-UNDO.
DEFINE VARIABLE offset AS INTEGER NO-UNDO.
DEFINE VARIABLE instr  AS INTEGER NO-UNDO.

INPUT FROM "d:\Data\Dropbox\AdventOfCode\2016-12-input.txt".
REPEAT ptr = 1 TO 23:
  CREATE ttCmd. 
  ttCmd.nr = ptr. 
  IMPORT ttCmd.cmd ttCmd.op1 ttCmd.op2.
END.
INPUT CLOSE.

DEFINE VARIABLE iReg AS INTEGER NO-UNDO EXTENT 4 INITIAL [0,0,1,0].

PAUSE 0 BEFORE-HIDE. 
ptr = 1.

REPEAT :
  instr = instr + 1.
  IF ETIME > 1000 THEN DO:
    DISPLAY instr WITH FRAME f.
    PROCESS EVENTS. 
    ETIME(YES).
  END.

  FIND ttCmd WHERE ttCmd.nr = ptr NO-ERROR.
  IF NOT AVAILABLE ttCmd THEN LEAVE.

  offset = 1.

  CASE ttCmd.cmd:
    WHEN 'cpy' THEN RUN cmdCpy(ttCmd.op1,ttCmd.op2).
    WHEN 'inc' THEN RUN cmdInc(ttCmd.op1).
    WHEN 'dec' THEN RUN cmdDec(ttCmd.op1).
    WHEN 'jnz' THEN RUN cmdJnz(ttCmd.op1,ttCmd.op2, INPUT-OUTPUT offset).
  END CASE.

  ptr = ptr + offset.
END.

MESSAGE iReg[1] VIEW-AS ALERT-BOX INFO BUTTONS OK.

PROCEDURE cmdCpy:
  DEFINE INPUT  PARAMETER pcReg AS CHARACTER NO-UNDO.
  DEFINE INPUT  PARAMETER pcOp2 AS CHARACTER NO-UNDO.

  DEFINE VARIABLE iVal AS INTEGER NO-UNDO.
  CASE pcReg:
    WHEN 'a' THEN iVal = iReg[1].
    WHEN 'b' THEN iVal = iReg[2].
    WHEN 'c' THEN iVal = iReg[3].
    WHEN 'd' THEN iVal = iReg[4].
    OTHERWISE iVal = INTEGER(pcReg).
  END CASE.

  CASE pcOp2:
    WHEN 'a' THEN iReg[1] = iVal. 
    WHEN 'b' THEN iReg[2] = iVal. 
    WHEN 'c' THEN iReg[3] = iVal. 
    WHEN 'd' THEN iReg[4] = iVal. 
  END CASE.
END. 

PROCEDURE cmdInc:
  DEFINE INPUT PARAMETER pcReg AS CHARACTER NO-UNDO.
  CASE pcReg:
    WHEN 'a' THEN iReg[1] = iReg[1] + 1.
    WHEN 'b' THEN iReg[2] = iReg[2] + 1.
    WHEN 'c' THEN iReg[3] = iReg[3] + 1.
    WHEN 'd' THEN iReg[4] = iReg[4] + 1.
  END CASE.
END. 

PROCEDURE cmdDec:
  DEFINE INPUT PARAMETER pcReg AS CHARACTER NO-UNDO.
  CASE pcReg:
    WHEN 'a' THEN iReg[1] = iReg[1] - 1.
    WHEN 'b' THEN iReg[2] = iReg[2] - 1.
    WHEN 'c' THEN iReg[3] = iReg[3] - 1.
    WHEN 'd' THEN iReg[4] = iReg[4] - 1.
  END CASE.
END. 

PROCEDURE cmdJnz:
  DEFINE INPUT PARAMETER pcReg AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcOp2 AS CHARACTER NO-UNDO.
  DEFINE INPUT-OUTPUT PARAMETER piOffset AS INTEGER NO-UNDO.
  DEFINE VARIABLE iVal AS INTEGER NO-UNDO.

  CASE pcReg:
    WHEN 'a' THEN iVal = iReg[1].
    WHEN 'b' THEN iVal = iReg[2].
    WHEN 'c' THEN iVal = iReg[3].
    WHEN 'd' THEN iVal = iReg[4].
    OTHERWISE iVal = INTEGER(pcReg).
  END CASE.

  IF iVal <> 0 THEN piOffset = INTEGER(pcOp2).
END. 


/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 318117                      */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 9227771                     */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
/*                             */
