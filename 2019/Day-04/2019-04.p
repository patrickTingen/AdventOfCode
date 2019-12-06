/* Advent of code 2019
** day 4a
*/
/* 108457 - 562041 */
DEFINE VARIABLE a AS INTEGER   NO-UNDO.
DEFINE VARIABLE b AS INTEGER   NO-UNDO.
DEFINE VARIABLE c AS INTEGER   NO-UNDO.
DEFINE VARIABLE d AS INTEGER   NO-UNDO.
DEFINE VARIABLE e AS INTEGER   NO-UNDO.
DEFINE VARIABLE f AS INTEGER   NO-UNDO.
DEFINE VARIABLE i AS INTEGER   NO-UNDO.
DEFINE VARIABLE j AS INTEGER   NO-UNDO EXTENT 2.
DEFINE VARIABLE iLimit AS INTEGER   NO-UNDO EXTENT 2 INITIAL [108457, 562041].

/*
It is a six-digit number.
The value is within the range given in your puzzle input.
Two adjacent digits are the same (like 22 in 122345).
Going from left to right, the digits never decrease; 
*/
DO a = 0 TO 9:
  DO b = a TO 9:
    DO c = b TO 9:
      DO d = c TO 9:
        DO e = d TO 9:
          DO f = e TO 9:

            i = a * 100000 + b * 10000 + c * 1000 + d * 100 + e * 10 + f.
            IF i < iLimit[1] THEN NEXT. 
  
            IF i > iLimit[2] THEN DO: 
              MESSAGE j[1] j[2] VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
              STOP.
            END.

            /* part 1 */
            IF (a = b) OR (b = c) OR (c = d) OR (d = e) OR (e = f) THEN j[1] = j[1] + 1.

            /* part 2 */
            IF (    (a = b AND b <> c) 
                 OR (b = c AND c <> d AND b <> a) 
                 OR (c = d AND d <> e AND c <> b) 
                 OR (d = e AND e <> f AND d <> c)
                 OR (e = f            AND e <> d) ) THEN j[2] = j[2] + 1.
          END.
        END.
      END.
    END.
  END.
END.



