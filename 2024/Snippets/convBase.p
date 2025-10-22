/* convBase.p
*/
FUNCTION int2bin RETURNS CHARACTER(piValue AS INT64):
  RETURN System.Convert:ToString(piValue,2).
END FUNCTION. 

FUNCTION bin2int RETURNS INT64(pcValue AS CHARACTER):
  RETURN System.Convert:ToInt64(pcValue,2).
END FUNCTION. 

FUNCTION int2hex RETURNS CHARACTER(piValue AS INT64):
  RETURN CAPS(System.Convert:ToString(piValue,16)).
END FUNCTION. 

FUNCTION hex2int RETURNS INT64(pcValue AS CHARACTER):
  RETURN System.Convert:ToInt64(pcValue,16).
END FUNCTION. 

FUNCTION bin2hex RETURNS CHARACTER(pcValue AS CHARACTER):
  RETURN int2hex( bin2int(pcValue) ).
END FUNCTION. 

FUNCTION hex2bin RETURNS CHARACTER(pcValue AS CHARACTER):
  RETURN int2bin( hex2int(pcValue) ).
END FUNCTION. 

/* Native solutions in Progress (faster than system.convert) */
FUNCTION int2hex RETURNS CHARACTER
  ( piVal AS INT64 ):

  DEFINE VARIABLE i    AS INT64     NO-UNDO.
  DEFINE VARIABLE cHex AS CHARACTER NO-UNDO.

  DO WHILE TRUE:
    i = piVal MODULO 16.
    cHex = SUBSTRING("0123456789ABCDEF",i + 1, 1) + cHex.
    IF piVal < 16 THEN LEAVE.
    piVal = (piVal - i) / 16.
  END.

  RETURN cHex.
END FUNCTION.

FUNCTION int2bin RETURNS CHARACTER
  ( piVal AS INT64 ):

  DEFINE VARIABLE i    AS INT64     NO-UNDO.
  DEFINE VARIABLE cBin AS CHARACTER NO-UNDO.

  DO WHILE TRUE:
    i = piVal MODULO 2.
    cBin = STRING(i) + cBin.
    IF piVal < 2 THEN LEAVE.
    piVal = (piVal - i) / 2.
  END.

  RETURN cBin.
END FUNCTION.

