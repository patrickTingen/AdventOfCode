/*------------------------------------------------------------------------
    File        : 2017-07a.p
    Purpose     : Day 7 of AoC 2017

    13-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE cLine     AS CHARACTER   NO-UNDO.
DEFINE VARIABLE ii        AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttNode NO-UNDO
  FIELD cName     AS CHARACTER
  FIELD iWeight   AS INTEGER
  FIELD cParent   AS CHARACTER
  FIELD cChildren AS CHARACTER
  .
DEFINE BUFFER bNode FOR ttNode. 

INPUT FROM 'd:\Data\DropBox\AdventOfCode\2017\2017-07-test.dat'.
REPEAT:
  IMPORT UNFORMATTED cLine.
  
  CREATE ttNode.
  ASSIGN 
    ttNode.cName     = ENTRY(1,cLine,' ')
    ttNode.iWeight   = INTEGER(ENTRY(2,ENTRY(1,cLine,')'),'('))
    ttNode.cChildren = (IF NUM-ENTRIES(cLine,'>') > 1 THEN TRIM(ENTRY(2,cLine,'>')) ELSE '')
    .  
END.
INPUT CLOSE. 

FOR EACH ttNode WHERE ttNode.cChildren <> '':
  DO ii = 1 TO NUM-ENTRIES(ttNode.cChildren):
    FIND bNode WHERE bNode.cName = TRIM(ENTRY(ii,ttNode.cChildren)).
    ASSIGN bNode.cParent = ttNode.cName.
  END.
END.


FIND ttNode WHERE ttNode.cParent = ''.
MESSAGE ttNode.cName
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.


  
/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* hlhomy                      */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
