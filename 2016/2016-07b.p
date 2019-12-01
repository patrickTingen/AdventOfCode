/* Advent Of Code 2016, day 7, part 2 */

FUNCTION hasSSL RETURNS LOGICAL
	( pcSuperNet AS CHARACTER
  , pcHyperNet AS CHARACTER):
	/* pcSuperNet = outside brackets
	 * pcHyperNet = Inside brackets
	 */
	DEFINE VARIABLE ii    AS INTEGER NO-UNDO.
	DEFINE VARIABLE cAba AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cBab AS CHARACTER   NO-UNDO.
	
	DO ii = 1 TO LENGTH(pcSuperNet) - 2:
		cAba = SUBSTRING(pcSuperNet,ii,3).
    cBab = SUBSTRING(cAba,2,1) + SUBSTRING(cAba,1,1) + SUBSTRING(cAba,2,1).

    IF SUBSTRING(cAba,1,1) = SUBSTRING(cAba,2,1) THEN NEXT. 
    IF SUBSTRING(cAba,1,1) <> SUBSTRING(cAba,3,1) THEN NEXT. 
    
    IF pcHyperNet MATCHES '*' + cBab + '*' THEN RETURN TRUE.
	END. 
	RETURN FALSE.
END FUNCTION. /* hasSSL */

DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cChunk    AS CHARACTER NO-UNDO.
DEFINE VARIABLE ii        AS INTEGER   NO-UNDO.
DEFINE VARIABLE cHyper    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSuper    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iCounter  AS INTEGER   NO-UNDO.
DEFINE VARIABLE cTotHyper AS CHARACTER NO-UNDO.
DEFINE VARIABLE cTotSuper AS CHARACTER NO-UNDO.

INPUT FROM 'd:\Data\Progress\AdventOfCode\2016-07-input.txt'.
REPEAT:
  IMPORT cLine.

  /* Super = outside brackets */
  cSuper    = ''. 
  cTotSuper = ''.

  /* Hyper = inside brackets */
  cHyper    = ''.
  cTotHyper = ''.
  
  DO ii = 1 TO NUM-ENTRIES(cLine,'['):
    /* Each entry is separated by ']' except the first */ 
    cChunk = ENTRY(ii,cLine,'[').
  
    IF NUM-ENTRIES(cChunk,']') = 1 THEN
      ASSIGN cSuper = cChunk
             cHyper  = ''.
    ELSE 
      ASSIGN cHyper  = ENTRY(1,cChunk,']')
             cSuper = ENTRY(2,cChunk,']').
  
    cTotHyper = cTotHyper + '|' + cHyper.
    cTotSuper = cTotSuper + '|' + cSuper.
  END.

  IF hasSSL(cTotSuper, cTotHyper) THEN
    iCounter = iCounter + 1.

END. 

MESSAGE iCounter
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

  
  
  
  
  
  
  
  
  
  
  
