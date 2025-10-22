/* BubbleSort.p
*/
FUNCTION isAsc RETURNS LOGICAL(pcOne AS CHARACTER, pcTwo AS CHARACTER):
  RETURN (INTEGER(pcOne) < INTEGER(pcTwo)).
END FUNCTION. 

FUNCTION swap RETURNS CHARACTER(pcList AS CHARACTER, piOne AS INTEGER, piTwo AS INTEGER):
  DEFINE VARIABLE cTemp AS CHARACTER NO-UNDO.

  cTemp = ENTRY(piOne,pcList).
  ENTRY(piOne,pcList) = ENTRY(piTwo,pcList).
  ENTRY(piTwo,pcList) = cTemp.

  RETURN pcList.
END FUNCTION.

FUNCTION sortList RETURNS CHARACTER (pcList AS CHARACTER):
  /* bubble sort 
  */
  DEFINE VARIABLE i     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cPrev AS CHARACTER NO-UNDO.

  DO i = 1 TO NUM-ENTRIES(pcList) - 1:

    cPrev = pcList.

    DO j = 1 TO NUM-ENTRIES(pcList) - i:
      IF NOT isAsc( ENTRY(j,pcList)
                  , ENTRY(j + 1,pcList)) THEN pcList   = swap(pcList,j,j + 1).
    END.

    IF pcList = cPrev THEN LEAVE.
  END.

  RETURN pcList.
END FUNCTION. /* sortList */


MESSAGE sortList("1,3,2,5,4")
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
