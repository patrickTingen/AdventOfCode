/* Advent of code 2020
** day 1a
*/
DEFINE TEMP-TABLE ttData
  FIELD iNumber AS INTEGER
  FIELD iValue  AS INTEGER.
  
DEFINE BUFFER bData1 FOR ttData.
DEFINE BUFFER bData2 FOR ttData.
DEFINE BUFFER bData3 FOR ttData.
DEFINE VARIABLE iCount AS INTEGER NO-UNDO.  

INPUT FROM day-01.dat.
REPEAT:
  iCount = iCount + 1.
  CREATE ttData.
  ASSIGN ttData.iNumber = iCount.
  IMPORT ttData.iValue.
END.
INPUT CLOSE. 

FOR EACH bData1:
  FOR EACH bData2 WHERE bData2.iNumber > bData1.iNumber:
    FOR EACH bData3 WHERE bData3.iNumber > bData2.iNumber:
      IF bData1.iValue + bData2.iValue + bData3.iValue = 2020 THEN
      DO:
        MESSAGE bData1.iValue * bData2.iValue * bData3.iValue VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
        STOP.
      END.
    END.
  END.
END.

/* ---------------------------                  */
/* Information (Press HELP to view stack trace) */
/* ---------------------------                  */
/* 200878544                                    */
/* ---------------------------                  */
/* OK   Help                                    */
/* ---------------------------                  */
