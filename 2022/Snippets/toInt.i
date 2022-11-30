/* AoC snippet for bin conversion
 */ 
FUNCTION toInt RETURNS INT64(pcBin AS CHARACTER):
  DEFINE VARIABLE iValue AS INT64 NO-UNDO.
  iValue = System.Convert:ToInt64(pcBin,2) NO-ERROR.
  RETURN iValue.
END FUNCTION.

