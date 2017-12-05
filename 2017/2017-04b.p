/*------------------------------------------------------------------------
    File        : 2017-04b.p
    Purpose     : Day 4 of AoC 2017

    5-12-2017 Patrick Tingen
  ----------------------------------------------------------------------*/

DEFINE VARIABLE cPass     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNumValid AS INTEGER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE tt NO-UNDO RCODE-INFORMATION
  FIELD nr    AS INTEGER
  FIELD cWord AS CHARACTER.

DEFINE BUFFER t2 FOR tt.

FUNCTION anagram RETURNS LOGICAL (w1 AS CHARACTER, w2 AS CHARACTER):
  DEFINE VARIABLE i AS INTEGER NO-UNDO.
  DEFINE VARIABLE j AS INTEGER NO-UNDO.
  IF LENGTH(w1) <> LENGTH(w2) THEN RETURN FALSE.
  DO i = 1 TO LENGTH(w1):
    j = INDEX(w2, SUBSTRING(w1,i,1)).
    IF j = 0 THEN RETURN FALSE.
    SUBSTRING(w2,j,1) = '.'.
  END.
  RETURN TRUE.
END FUNCTION.

INPUT FROM c:\Data\DropBox\AdventOfCode\2017\2017-04.dat.

#pass:
REPEAT:
  IMPORT UNFORMATTED cPass.

  EMPTY TEMP-TABLE tt.
  DO i = 1 TO NUM-ENTRIES(cPass,' '):
    CREATE tt.
    ASSIGN tt.nr = i tt.cWord = ENTRY(i,cPass,' ').
  END.

  FOR EACH tt:
    FOR EACH t2 WHERE t2.nr > tt.nr:
      IF anagram(tt.cWord,t2.cWord) THEN NEXT #pass.
    END.
  END.
  iNumValid = iNumValid + 1.
END.

MESSAGE iNumValid VIEW-AS ALERT-BOX INFORMATION.

/*---------------------------                 */
/*Information (Press HELP to view stack trace)*/
/*---------------------------                 */
/*251                                         */
/*---------------------------                 */
/*OK   Help                                   */
/*---------------------------                 */





