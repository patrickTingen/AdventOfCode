/* AoC 2022 day 02a 
 */ 
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iScore AS INTEGER   NO-UNDO.

/* 
The score for a single round is the score for the shape you selected 
(1 for Rock, 2 for Paper, and 3 for Scissors) 

plus the score for the outcome of the round 
(0 if you lost, 3 if the round was a draw, and 6 if you won).
*/
INPUT FROM data.txt.

REPEAT:
  cLine = ''.
  IMPORT UNFORMATTED cLine.
  
  CASE cLine:
    WHEN 'A X' THEN iScore = iScore + 1 + 3. /* r = r */
    WHEN 'A Y' THEN iScore = iScore + 1 + 0. /* r < p */
    WHEN 'A Z' THEN iScore = iScore + 1 + 6. /* r > s */
    
    WHEN 'B X' THEN iScore = iScore + 2 + 6. /* p > r */
    WHEN 'B Y' THEN iScore = iScore + 2 + 3. /* p = p */
    WHEN 'B Z' THEN iScore = iScore + 2 + 0. /* p < s */
    
    WHEN 'C X' THEN iScore = iScore + 3 + 0. /* s < r */
    WHEN 'C Y' THEN iScore = iScore + 3 + 6. /* s > p */
    WHEN 'C Z' THEN iScore = iScore + 3 + 3. /* s = s */
  END CASE.
END.
INPUT CLOSE. 

MESSAGE iScore    
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

