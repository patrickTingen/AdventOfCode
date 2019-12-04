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
DEFINE VARIABLE j AS INTEGER   NO-UNDO.

/*
It is a six-digit number.
The value is within the range given in your puzzle input.
Two adjacent digits are the same (like 22 in 122345).
Going from left to right, the digits never decrease; 
*/
DO a = 1 TO 5:
  DO b = 0 TO 9:
    IF b < a THEN NEXT. 

    DO c = 0 TO 9:
      IF c < b THEN NEXT. 

      DO d = 0 TO 9:
        IF d < c THEN NEXT. 

        DO e = 0 TO 9:
          IF e < d THEN NEXT. 

          DO f = 0 TO 9:
            IF f < e THEN NEXT. 

            i = a * 100000 + b * 10000 + c * 1000 + d * 100 + e * 10 + f.
            IF i < 108457 THEN NEXT. 
  
            IF i > 562041 THEN DO: 
              MESSAGE j VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
              STOP.
            END.

            IF (b >= a) AND (c >= b) AND (d >= c) AND (e >= d) AND (f >= e) 
              AND ( (a = b) OR (b = c) OR (c = d) OR (d = e) OR (e = f) ) THEN j = j + 1.
          END.
        END.
      END.
    END.
  END.
END.



