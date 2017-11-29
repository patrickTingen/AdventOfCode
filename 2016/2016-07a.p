/* Advent Of Code 2016, day 7, part 1 */

FUNCTION hasAbba RETURNS LOGICAL
	(pcString AS CHARACTER):
	/* Return whether a string contains an 'ABBA' substring
	 * An ABBA is any four-character sequence which consists of a pair of two 
	 * different characters followed by the reverse of that pair, such as xyyx or abba.
	 */
	DEFINE VARIABLE ii    AS INTEGER NO-UNDO.
	DEFINE VARIABLE cPrev AS CHARACTER NO-UNDO.
	DEFINE VARIABLE cCurr AS CHARACTER NO-UNDO.
	DEFINE VARIABLE cAbba AS CHARACTER NO-UNDO.
	
	DO ii = 1 TO LENGTH(pcString) - 2:
		cCurr = SUBSTRING(pcString,ii,1).
		cAbba = cPrev + cCurr + cCurr + cPrev.
    IF ii > 1 
      AND cPrev <> cCurr
      AND pcString MATCHES '*' + cAbba + '*' THEN RETURN TRUE.
		cPrev = cCurr.
	END. 
	RETURN FALSE.
END FUNCTION. /* hasAbba */


DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cChunk   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE ii       AS INTEGER     NO-UNDO.
DEFINE VARIABLE lInside  AS LOGICAL     NO-UNDO.
DEFINE VARIABLE lOutside AS LOGICAL     NO-UNDO.
DEFINE VARIABLE cInside  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cOutside AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iCounter AS INTEGER     NO-UNDO.

INPUT FROM 'd:\Data\Progress\AdventOfCode\2016-07-input.txt'.
REPEAT:
  IMPORT cLine.

  lInside  = FALSE.
  lOutside = FALSE.
  cOutside = ''.
  cInside  = ''.

  /* 
  nojlhdpfkjbhahgqo[lqrkjabuijutlcbq]caszlkvkofxjyqzsttc[isqicyomykudneq]izuzehgtmwnnvfrlrja
  
  nojlhdpfkjbhahgqo
  lqrkjabuijutlcbq]caszlkvkofxjyqzsttc
  isqicyomykudneq]izuzehgtmwnnvfrlrja
  */

  DO ii = 1 TO NUM-ENTRIES(cLine,'['):
    /* Each entry is separated by ']' except the first */ 
    cChunk = ENTRY(ii,cLine,'[').
  
    IF NUM-ENTRIES(cChunk,']') = 1 THEN
      ASSIGN cOutside = cChunk.
    ELSE 
      ASSIGN cInside  = ENTRY(1,cChunk,']')
             cOutside = ENTRY(2,cChunk,']').
  
    IF hasAbba(cInside) THEN lInside = TRUE.
    IF hasAbba(cOutside) THEN lOutside = TRUE.
  
  END.
  
  IF lOutside AND NOT lInside THEN iCounter = iCounter + 1.
END. 

MESSAGE iCounter
  VIEW-AS ALERT-BOX INFO BUTTONS OK.
