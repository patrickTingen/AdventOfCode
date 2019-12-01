/* Advent of code 2018
** day 5 (stack)
*/
DEFINE VARIABLE s AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE s2 AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE a AS CHARACTER NO-UNDO CASE-SENSITIVE.
DEFINE VARIABLE b AS CHARACTER NO-UNDO CASE-SENSITIVE.
DEFINE VARIABLE i AS INTEGER   NO-UNDO.

COPY-LOB FILE "2018-05.dat" TO s.
/* test: dabAcCaCBAcCcaDA */

DO i = 1 TO LENGTH(s):
  a = (IF s2 > '' THEN SUBSTRING(s2,LENGTH(s2),1) ELSE '').
  b = SUBSTRING(s,i,1).
  IF a <> b AND CAPS(a) = CAPS(b) THEN
  CASE LENGTH(s2):
    WHEN 0 THEN s2 = ''.
    WHEN 1 THEN s2 = ''.
    OTHERWISE s2 = SUBSTRING(s2,1,LENGTH(s2) - 1).
  END CASE. 
  ELSE
    s2 = s2 + b.  
END.   
         
MESSAGE LENGTH(s2) 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  