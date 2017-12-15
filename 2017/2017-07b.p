/*------------------------------------------------------------------------
    File        : 2017-07b.p
    Purpose     : Day 7 of AoC 2017

    13-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE ii    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cData AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cWeight AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cList   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cNodes  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iNum    AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttNode NO-UNDO
  FIELD cName     AS CHARACTER
  FIELD iWeight   AS INTEGER
  FIELD cParent   AS CHARACTER
  FIELD cChildren AS CHARACTER
  FIELD iLoad AS INTEGER
  FIELD iTotalWeight AS INTEGER
  .
DEFINE BUFFER bNode FOR ttNode. 

FUNCTION getChildWeight RETURNS INTEGER (pcNode AS CHARACTER):
  DEFINE VARIABLE iChildWeight AS INTEGER NO-UNDO.
  DEFINE BUFFER bNode FOR ttNode. 
  
  FOR EACH bNode WHERE bNode.cParent = pcNode:
    iChildWeight = iChildWeight + bNode.iWeight + getChildWeight(bNode.cName).
  END.
  
  RETURN iChildWeight.
END FUNCTION.

/* Read data */
COPY-LOB FILE 'c:\Data\DropBox\AdventOfCode\2017\2017-07-test.dat' TO cData.
cData = TRIM(cData,'~n').
DO ii = 1 TO NUM-ENTRIES(cData,'~n'):
  cLine = ENTRY(ii,cData,'~n').
  cLine = REPLACE(cLine,' ','').
  
  CREATE ttNode.
  ASSIGN 
    ttNode.cName     = ENTRY(1,cLine,'(')
    ttNode.iWeight   = INTEGER(ENTRY(2,ENTRY(1,cLine,')'),'('))
    ttNode.cChildren = (IF NUM-ENTRIES(cLine,'>') > 1 THEN TRIM(ENTRY(2,cLine,'>')) ELSE '')
    .  
END.

/* Set parents */
FOR EACH ttNode WHERE ttNode.cChildren <> '':
  DO ii = 1 TO NUM-ENTRIES(ttNode.cChildren):
    FIND bNode WHERE bNode.cName = TRIM(ENTRY(ii,ttNode.cChildren)) NO-ERROR.
    ASSIGN bNode.cParent = ttNode.cName.
  END.
  ttNode.cChildren = ''.
END.

/* Calc weights */
FOR EACH ttNode:
  ttNode.iLoad = getChildWeight(ttNode.cName).
  ttNode.iTotalWeight = ttNode.iLoad + ttNode.iWeight.
END.

OUTPUT TO c:\Data\DropBox\AdventOfCode\2017\2017-07-test.txt.
FOR EACH ttNode BY ttNode.cParent: EXPORT ttNode. END.
OUTPUT CLOSE.

/* Find unbalance */
FOR EACH ttNode BREAK BY ttNode.cParent:
  IF FIRST-OF(ttNode.cParent) THEN ASSIGN cList = '' iNum = 0 cNodes = ''.
  cWeight = STRING(ttNode.iLoad + ttNode.iWeight).
  IF LOOKUP(cWeight,cList) = 0 THEN iNum = iNum + 1.
  cList  = TRIM(cList + ',' + STRING(cWeight),',').
  cNodes = TRIM(cNodes + ',' + STRING(ttNode.cName),',').

  IF LAST-OF(ttNode.cParent) AND iNum > 1 THEN
  DO:
    MESSAGE ttNode.cName SKIP cNodes SKIP cList 
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.
  END.
END.


/*
---------------------------
Information (Press HELP to view stack trace)
---------------------------
dxxty 
oylgfzb,teyrfjn,ahayh,hvtvcpz,lqirhg,razvskj,dxxty 
111638,111630,111630,111630,111630,111630,111630
---------------------------
OK   Help   
---------------------------
*/
/* ---------------------------                            */
/* Information (Press HELP to view stack trace)           */
/* ---------------------------                            */
/* dxxty 111638,111630,111630,111630,111630,111630,111630 */
/* 111630 is te hoog */
/* 64876 is te hoog */
/* ---------------------------                            */
/* OK   Help                                              */
/* ---------------------------                            */
