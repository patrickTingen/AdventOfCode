/* AoC 2020 day 8 
*/
DEFINE TEMP-TABLE ttCode NO-UNDO
  FIELD iLn  AS INTEGER
  FIELD cOpr AS CHARACTER 
  FIELD cPar AS CHARACTER 
  INDEX iPrim iLn.

DEFINE TEMP-TABLE ttHist NO-UNDO
  FIELD iVal AS INTEGER
  INDEX iPrim iVal.

