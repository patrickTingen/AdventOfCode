/*------------------------------------------------------------------------
    File        : 2017-05a.p
    Purpose     : Day 5 of AoC 2017

    9-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE ii AS INTEGER    NO-UNDO.  
DEFINE VARIABLE moves AS INTEGER NO-UNDO.
DEFINE VARIABLE iList AS INTEGER NO-UNDO EXTENT 2000.
DEFINE VARIABLE iOld AS INTEGER  NO-UNDO.

INPUT FROM d:\Data\DropBox\AdventOfCode\2017\2017-05.dat.
REPEAT TRANSACTION:
  ii = ii + 1.
  IMPORT iList[ii].
END. 
INPUT CLOSE. 

/* Test case */
/* iList[1] = 0.  */
/* iList[2] = 3.  */
/* iList[3] = 0.  */
/* iList[4] = 1.  */
/* iList[5] = -3. */

ii = 1.
moves = 0.
REPEAT:
  iOld = ii.
  ii = ii + iList[ii].
  moves = moves + 1.
  IF ii > 1074 OR ii < 1 THEN LEAVE.
  
  iList[iOld] = iList[iOld] + 1.
END.
MESSAGE moves VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.





