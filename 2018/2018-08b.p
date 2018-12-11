/* Advent of code 2018
** day 8
*/
DEFINE VARIABLE iNumNodes AS INTEGER  NO-UNDO.
DEFINE VARIABLE iPointer  AS INTEGER  NO-UNDO INITIAL 1.
DEFINE VARIABLE cData     AS LONGCHAR NO-UNDO.

DEFINE TEMP-TABLE ttNode NO-UNDO
 FIELD iNr    AS INTEGER  
 FIELD iValue AS INTEGER  
 INDEX iPrim IS PRIMARY UNIQUE iNr.

DEFINE TEMP-TABLE ttTree NO-UNDO
 FIELD iParentNr AS INTEGER  
 FIELD iSeq      AS INTEGER  
 FIELD iChildNr  AS INTEGER  
 INDEX iPrim IS PRIMARY UNIQUE iParentNr iSeq.

COPY-LOB FILE "2018-08.dat" TO cData.
cData = TRIM(cData,CHR(10) + CHR(13)).

FUNCTION getValue RETURNS INTEGER (INPUT piNr AS INTEGER ):
  DEFINE VARIABLE i            AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iChild       AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMetaEntries AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iMetaTotal   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE iNumChildren AS INTEGER   NO-UNDO.

  DEFINE BUFFER bTree FOR ttTree.
  DEFINE BUFFER bNode FOR ttNode.

  ASSIGN
    iNumChildren = INTEGER(ENTRY(iPointer, cData, " "))
    iMetaEntries = INTEGER(ENTRY(iPointer + 1, cData, " "))
    iPointer     = iPointer + 2.

  IF iNumChildren > 0 THEN 
  DO i = 1 TO iNumChildren:
    iNumNodes = iNumNodes + 1. 

    CREATE bNode.
    ASSIGN bNode.iNr    = iNumNodes
           bNode.iValue = bNode.iValue + getValue(bNode.iNr).

    CREATE bTree.
    ASSIGN bTree.iParentNr = piNr
           bTree.iSeq    = i
           bTree.iChildNr  = bNode.iNr.
  END.

  IF iMetaEntries > 0 THEN 
  DO:
    IF iNumChildren = 0 THEN 
    DO i = 0 TO iMetaEntries - 1:
      iMetaTotal = iMetaTotal + INTEGER(ENTRY(iPointer + i, cData, " ")).
    END.

    ELSE 
    DO i = 0 TO iMetaEntries - 1:
      iChild = INTEGER(ENTRY(iPointer + i, cData, " ")).
      FOR FIRST bTree WHERE bTree.iParentNr = piNr AND bTree.iSeq = iChild
         ,FIRST bNode WHERE bNode.iNr = bTree.iChildNr:
          iMetaTotal = iMetaTotal + bNode.iValue.
      END.
    END.
    iPointer = iPointer + iMetaEntries.
  END.

  RETURN iMetaTotal.
END FUNCTION.

MESSAGE 
  getValue(0) 
  VIEW-AS ALERT-BOX INFO BUTTONS OK.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 13935                       */
/* --------------------------- */
/* OK                          */
/* --------------------------- */

