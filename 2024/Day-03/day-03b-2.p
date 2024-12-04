/* Alternative solution 2024-03
**
** based on https://gathering.tweakers.net/forum/list_message/80917954#80917954
** Github:  https://github.com/maksverver/AdventOfCode/blob/master/2024/day03/solve2.c
*/
DEFINE VARIABLE iAnswer1 AS INTEGER     NO-UNDO.
DEFINE VARIABLE iAnswer2 AS INTEGER     NO-UNDO.
DEFINE VARIABLE lEnabled AS LOGICAL     NO-UNDO INITIAL YES.
DEFINE VARIABLE iX       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iY       AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMax     AS INTEGER     NO-UNDO.

FUNCTION getChar RETURNS CHARACTER ():
  READKEY.
  IF LASTKEY < 0 
    THEN RETURN ?. 
    ELSE RETURN CHR(LASTKEY).
END FUNCTION.

ETIME(YES).
INPUT FROM "data.txt".

REPEAT:
  CASE getChar():
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
    WHEN ? THEN LEAVE.
  END CASE.      
END.

MESSAGE iAnswer1 ' / ' iAnswer2 'in' ETIME 'ms' 
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

PROCEDURE d:
  CASE getChar():
    WHEN 'o' THEN RUN _do.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE _do:
  CASE getChar():
    WHEN '(' THEN RUN dop.
    WHEN 'n' THEN RUN don.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE dop:
  CASE getChar():
    WHEN ')' THEN lEnabled = true.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE don:
  CASE getChar():
    WHEN "'" THEN RUN dono.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE dono:
  CASE getChar():
    WHEN 't' THEN RUN donot.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE donot:
  CASE getChar():
    WHEN '(' THEN RUN donotp.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE donotp:
  CASE getChar():
    WHEN ')' THEN lEnabled = false.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE m:
  CASE getChar():
    WHEN 'u' THEN RUN mu.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mu:
  CASE getChar():
    WHEN 'l' THEN RUN mul.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mul:
  CASE getChar():
    WHEN '(' THEN RUN mulp.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulp:
  DEFINE VARIABLE c AS CHARACTER   NO-UNDO.
  c = getChar().
  CASE c:
    WHEN '0' OR WHEN '1' OR WHEN '2' OR WHEN '3' OR WHEN '4' OR
    WHEN '5' OR WHEN '6' OR WHEN '7' OR WHEN '8' OR WHEN '9' THEN 
    DO:
      iX = INT(c).
      RUN mulpd.
    END.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpd:
  DEFINE VARIABLE c AS CHARACTER   NO-UNDO.
  c = getChar().
  CASE c:
    WHEN '0' OR WHEN '1' OR WHEN '2' OR WHEN '3' OR WHEN '4' OR
    WHEN '5' OR WHEN '6' OR WHEN '7' OR WHEN '8' OR WHEN '9' THEN 
    DO:
      iX = (10 * iX) + INT(c).
      RUN mulpdd.
    END.
    WHEN ',' THEN RUN mulpc.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpdd:
  DEFINE VARIABLE c AS CHARACTER   NO-UNDO.
  c = getChar().
  CASE c:
    WHEN '0' OR WHEN '1' OR WHEN '2' OR WHEN '3' OR WHEN '4' OR
    WHEN '5' OR WHEN '6' OR WHEN '7' OR WHEN '8' OR WHEN '9' THEN 
    DO:
      iX = (10 * iX) + INT(c).
      RUN mulpddd.
    END.
    WHEN ',' THEN RUN mulpc.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpddd:
  CASE getChar():
    WHEN ',' THEN RUN mulpc.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpc:
  DEFINE VARIABLE c AS CHARACTER   NO-UNDO.
  c = getChar().
  CASE c:
    WHEN '0' OR WHEN '1' OR WHEN '2' OR WHEN '3' OR WHEN '4' OR
    WHEN '5' OR WHEN '6' OR WHEN '7' OR WHEN '8' OR WHEN '9' THEN 
    DO:
      iY = INT(c).
      RUN mulpcd.
    END.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpcd:
  DEFINE VARIABLE c AS CHARACTER   NO-UNDO.
  c = getChar().
  CASE c:
    WHEN '0' OR WHEN '1' OR WHEN '2' OR WHEN '3' OR WHEN '4' OR
    WHEN '5' OR WHEN '6' OR WHEN '7' OR WHEN '8' OR WHEN '9' THEN 
    DO:
      iY = (10 * iY) + INT(c).
      RUN mulpcdd.
    END.
    WHEN ')' THEN RUN matched_mul.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpcdd:
  DEFINE VARIABLE c AS CHARACTER   NO-UNDO.
  c = getChar().
  CASE c:
    WHEN '0' OR WHEN '1' OR WHEN '2' OR WHEN '3' OR WHEN '4' OR
    WHEN '5' OR WHEN '6' OR WHEN '7' OR WHEN '8' OR WHEN '9' THEN 
    DO:
      iY = (iY * 10) + INT(c).
      RUN mulpcddd.
    END.
    WHEN ')' THEN RUN matched_mul.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE mulpcddd:
  CASE getChar():
    WHEN ')' THEN RUN matched_mul.
    WHEN 'd' THEN RUN d.
    WHEN 'm' THEN RUN m.
  END CASE.      
END PROCEDURE.

PROCEDURE matched_mul:
  iAnswer1 = iAnswer1 + (iX * iY).
  IF lEnabled THEN iAnswer2 = iAnswer2 + (iX * iY).
END PROCEDURE. 
