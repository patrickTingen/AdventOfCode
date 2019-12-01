/*------------------------------------------------------------------------
    File        : 2017-10a.p
    Purpose     : Day 10 of AoC 2017(part 1)

    21-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE i    AS INTEGER  NO-UNDO. /* counter */
DEFINE VARIABLE j    AS INTEGER  NO-UNDO. /* counter */
DEFINE VARIABLE pos  AS INTEGER  NO-UNDO. /* pointer */
DEFINE VARIABLE pos2 AS INTEGER  NO-UNDO. /* pointer */
DEFINE VARIABLE skp  AS INTEGER  NO-UNDO. /* skip length */

&GLOBAL-DEFINE mode testx

&IF "{&mode}" = "test" &THEN
  /* Test */
  DEFINE VARIABLE iList    AS INTEGER NO-UNDO EXTENT 5.
  DEFINE VARIABLE iList2   AS INTEGER NO-UNDO EXTENT 5.
  DEFINE VARIABLE iLength  AS INTEGER NO-UNDO EXTENT 4 INITIAL [3,4,1,5].
&ELSE
  /* Puzzle */
  DEFINE VARIABLE iList   AS INTEGER NO-UNDO EXTENT 256.
  DEFINE VARIABLE iList2  AS INTEGER NO-UNDO EXTENT 256.
  DEFINE VARIABLE iLength AS INTEGER NO-UNDO EXTENT 16 INITIAL [192,69,168,160,78,1,166,28,0,83,198,2,254,255,41,12].
&ENDIF 

FUNCTION getList RETURNS CHARACTER
  ( someList AS INTEGER EXTENT, iPos AS INTEGER):
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DO i = 1 TO EXTENT(someList):
    c = TRIM(SUBSTITUTE('&1,&2',c,someList[i]),',').
  END.
  IF iPos <> 0 THEN ENTRY(iPos,c) = '[' + ENTRY(iPos,c) + ']'.
  RETURN c.
END FUNCTION.

/* Fill array */
DO i = 1 TO EXTENT(iList):
  iList[i] = i - 1.
END.   

pos = 1.
skp = 0.

/* Process input */
DO i = 1 TO EXTENT(iLength):

  /* Debug */
  /* MESSAGE getList(iList,pos) SKIP iLength[i] skp */
  /*   VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.    */
  
  /* Save values in second array */
  pos2 = pos.
  DO j = 1 TO iLength[i]:
    iList2[j] = iList[pos2].
    pos2 = pos2 MOD EXTENT(iList) + 1.
  END.
  
  /* Write back, reversed */
  pos2 = pos.
  DO j = iLength[i] TO 1 BY -1:
    iList[pos2] = iList2[j].
    pos2 = pos2 MOD EXTENT(iList) + 1.
  END.     
  
  /* Move pointer */
  pos = ((pos - 1) + iLength[i] + skp ) MOD EXTENT(iList) + 1.
  skp = skp + 1.
END.

MESSAGE iList[1] * iList[2]
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/*       INFORMATION           */
/* --------------------------- */
/*          48705              */
/* --------------------------- */
/*        OK   Help            */
/* --------------------------- */