/*------------------------------------------------------------------------
    File        : 2017-10b.p
    Purpose     : Day 10 of AoC 2017 (part 2)

    21-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE i    AS INTEGER  NO-UNDO. /* counter */
DEFINE VARIABLE j    AS INTEGER  NO-UNDO. /* counter */
DEFINE VARIABLE k    AS INTEGER  NO-UNDO. /* counter */
DEFINE VARIABLE pos  AS INTEGER  NO-UNDO. /* pointer */
DEFINE VARIABLE pos2 AS INTEGER  NO-UNDO. /* pointer */
DEFINE VARIABLE skp  AS INTEGER  NO-UNDO. /* skip length */

&GLOBAL-DEFINE mode testx

/* Puzzle */
DEFINE VARIABLE iList   AS INTEGER   NO-UNDO EXTENT 256.
DEFINE VARIABLE iList2  AS INTEGER   NO-UNDO EXTENT 256.
DEFINE VARIABLE cInput  AS CHARACTER NO-UNDO INITIAL '192,69,168,160,78,1,166,28,0,83,198,2,254,255,41,12'.
DEFINE VARIABLE iLength AS INTEGER   NO-UNDO EXTENT 16 INITIAL [192,69,168,160,78,1,166,28,0,83,198,2,254,255,41,12].
DEFINE VARIABLE cc      AS CHARACTER NO-UNDO.
DEFINE VARIABLE sparse  AS INTEGER   NO-UNDO EXTENT 16.

FUNCTION getArray RETURNS INTEGER(cInput AS CHARACTER):
  DEFINE VARIABLE iArray AS INTEGER EXTENT NO-UNDO.
  DEFINE VARIABLE i      AS INTEGER        NO-UNDO.
  EXTENT(iArray) = LENGTH(cInput) + 5.

  DO i = 1 TO LENGTH(cInput):
    iArray[i] = ASC(SUBSTRING(cInput,i,1)).
  END.   
  DO i = 1 TO 5:
    iArray[LENGTH(cInput) + i] = INTEGER(ENTRY(i,'17,31,73,47,23')).
  END.
END FUNCTION.   

FUNCTION getList RETURNS CHARACTER
  ( someList AS INTEGER EXTENT, iPos AS INTEGER):
  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE c AS CHARACTER NO-UNDO.
  DO i = 1 TO EXTENT(someList):
    c = TRIM(SUBSTITUTE('&1,&2',c,someList[i]),',').
  END.
  IF iPos <> 0 THEN ENTRY(iPos,c) = '[' + ENTRY(iPos,c) + ']'.
  RETURN c.
END FUNCTION.

FUNCTION bitXOR RETURNS INTEGER (INPUT X AS INTEGER, INPUT Y AS INTEGER):
   DEFINE VARIABLE b1 AS INTEGER NO-UNDO.
   DEFINE VARIABLE b2 AS INTEGER NO-UNDO.
   DEFINE VARIABLE n  AS INTEGER NO-UNDO.
   DEFINE VARIABLE Z  AS INTEGER NO-UNDO.

   DO n = 1 TO 32:
     ASSIGN
       b1 = GET-BITS(X, n, 1)
       b2 = GET-BITS(Y, n, 1)
       .
       IF b1 + b2 = 1 THEN PUT-BITS(Z, n, 1) = 1.
   END.

   RETURN Z.
END FUNCTION.

FUNCTION hexGet RETURNS CHARACTER (INPUT X AS INTEGER):
   DEFINE VARIABLE b1 AS INTEGER NO-UNDO.
   DEFINE VARIABLE b2 AS INTEGER NO-UNDO.
   DEFINE VARIABLE n  AS INTEGER NO-UNDO.
   DEFINE VARIABLE h  AS CHARACTER NO-UNDO INITIAL "0123456789abcdef".
   DEFINE VARIABLE Z  AS CHARACTER NO-UNDO.

   DO n = 0 TO 0:
     ASSIGN
       b1 = GET-BITS(X, n * 8 + 5, 4)
       b2 = GET-BITS(X, n * 8 + 1, 4)
       .
       Z = Z + SUBSTRING(h, b1 + 1, 1) + SUBSTRING(h, b2 + 1, 1).
   END.

   RETURN Z.
END FUNCTION.

/* Get string as array of ascii values */
iLength = getArray(INPUT cInput).

pos = 1.
skp = 0.

/* Process input */
DO i = 1 TO EXTENT(iLength):

  DO k = 1 TO 64:

    /* Save values in second array */
    pos2 = pos.
    DO j = 1 TO iLength[i]:
      iList2[j] = iList[pos2].
      pos2 = pos2 MOD EXTENT(iList) + 1.
    END.
    
    /* Write back, reversed */
    pos2 = pos.
    DO j = iLength[i] TO 1 BY -1:
      iList[pos2] = iList2[j].
      pos2 = pos2 MOD EXTENT(iList) + 1.
    END.     
    
    /* Move pointer */
    pos = ((pos - 1) + iLength[i] + skp ) MOD EXTENT(iList) + 1.
    skp = skp + 1.
    
  END. /* k */
END. /* i */

/* Handle the sparse hash */
DO i = 0 TO 15:
  k = i * 16 + 1.
  sparse[i + 1] = iList[k].
  DO j = 1 TO 16:
    sparse[i + 1] = bitXor(sparse[i + 1],iList[k + j - 1]).
  END.
END.

/* Turn into one hex string */
DO i = 1 TO 16:
  cc = cc + hexGet(sparse[i]).
END.

MESSAGE cc
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

  
/* outcome is not good, but I am sick of this one 
 * have fun if you want to struggle and let me know 
 * what I did wrong if you can find it.
*/
