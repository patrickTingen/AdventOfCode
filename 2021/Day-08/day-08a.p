/* AoC 2021 day 08a 
 */ 
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCount AS INTEGER   NO-UNDO.

INPUT FROM data.txt.

REPEAT :
  IMPORT UNFORMATTED cLine. 
  cLine = ENTRY(2, cLine,'|') NO-ERROR.
  DO i = 1 TO NUM-ENTRIES(cLine,' ').
    CASE LENGTH(ENTRY(i,cLine,' ')):
      WHEN 2 THEN iCount = iCount + 1. /* 1 */
      WHEN 3 THEN iCount = iCount + 1. /* 7 */
      WHEN 4 THEN iCount = iCount + 1. /* 4 */
      WHEN 7 THEN iCount = iCount + 1. /* 8 */
    END CASE.
  END.
END.

INPUT CLOSE. 

MESSAGE iCount VIEW-AS ALERT-BOX INFO BUTTONS OK. /* 367 */

