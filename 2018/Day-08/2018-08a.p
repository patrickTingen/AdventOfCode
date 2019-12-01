/* Advent of code 2018
** day 8
*/
DEFINE VARIABLE cData    AS LONGCHAR NO-UNDO.
DEFINE VARIABLE iPointer AS INTEGER  NO-UNDO INITIAL 1.
DEFINE VARIABLE iMeta    AS INTEGER  NO-UNDO.

COPY-LOB FILE '2018-08.dat' TO cData.
cData = TRIM(cData,CHR(10) + CHR(13)).

PROCEDURE readNode:
  DEFINE VARIABLE iChildNodes  AS INTEGER NO-UNDO.
  DEFINE VARIABLE iMetaEntries AS INTEGER NO-UNDO.
  DEFINE VARIABLE i            AS INTEGER NO-UNDO.

  iChildNodes  = INTEGER(ENTRY(iPointer,cData,' ') ).
  iMetaEntries = INTEGER(ENTRY(iPointer + 1,cData,' ') ).
  iPointer = iPointer + 2.

  DO i = 1 TO iChildNodes:
    RUN readNode.
  END.
  DO i = 1 TO iMetaEntries:
    iMeta = iMeta + INTEGER(ENTRY(iPointer,cData,' ') ).
    iPointer = iPointer + 1.
  END.
END PROCEDURE. 

RUN readNode.
MESSAGE iMeta VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 38722                       */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

