/*------------------------------------------------------------------------
    File        : 2017-09.p
    Purpose     : Day 9 of AoC 2017 

    19-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

/* Group  : ~{} 
 * Garbage: <>
 * Ignore : !
 */
DEFINE VARIABLE str       AS LONGCHAR NO-UNDO.
DEFINE VARIABLE i         AS INTEGER  NO-UNDO.
DEFINE VARIABLE score     AS INTEGER  NO-UNDO.
DEFINE VARIABLE lvl       AS INTEGER  NO-UNDO.
DEFINE VARIABLE ingarbage AS LOGICAL  NO-UNDO.
DEFINE VARIABLE canceled  AS INTEGER  NO-UNDO.

COPY-LOB FILE 'd:\Data\DropBox\AdventOfCode\2017\2017-09-input.dat' TO str.

DO i = 1 TO LENGTH(str):

  IF ingarbage THEN
  DO:
    CASE SUBSTRING(str,i,1):
      WHEN '!' THEN
      DO:
        i = i + 1.  
      END.
      
      WHEN '>' THEN
      DO:
        ingarbage = FALSE.  
      END.
      
      OTHERWISE canceled = canceled + 1.
    END CASE.      
  END.
  
  ELSE 
  DO:
    CASE SUBSTRING(str,i,1):
      WHEN '~{' THEN 
      DO:
        lvl = lvl + 1.
      END.
      
      WHEN '~}' THEN
      DO:
        score = score + lvl.        
        lvl = lvl - 1.  
      END.
      
      WHEN '<' THEN
      DO:
        ingarbage = TRUE.  
      END.
    END CASE.
  END.
END.

MESSAGE 'A:' score 'B:' canceled
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* A:9251 B:4322               */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

