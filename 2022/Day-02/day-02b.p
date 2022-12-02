/* AoC 2022 day 02b
 */ 
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTotal AS INTEGER   NO-UNDO.
DEFINE VARIABLE iScore AS INTEGER   NO-UNDO EXTENT 9 INITIAL [3,4,8,1,5,9,2,6,7].

INPUT FROM data.txt.

REPEAT:
  IMPORT UNFORMATTED cLine.
  iTotal = iTotal + iScore[ LOOKUP(cLine,'A X,A Y,A Z,B X,B Y,B Z,C X,C Y,C Z') ].
/*                                        rs  rr  rp  pr  pp  ps  sp  ss  sr */
/*                                        03  31  62  01  32  63  02  33  61 */
END.
INPUT CLOSE. 

MESSAGE iTotal 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* X means you need to lose,     */
/* Y means you need TO draw, and */
/* Z means you need to win.      */
