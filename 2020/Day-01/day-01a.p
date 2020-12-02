/* Advent of code 2020
** day 1a
*/
DEFINE TEMP-TABLE ttData
  FIELD iNumber AS INTEGER
  FIELD iValue  AS INTEGER.
  
DEFINE BUFFER bData FOR ttData.
DEFINE VARIABLE iCount AS INTEGER NO-UNDO.  

INPUT FROM day-01.dat.
REPEAT:
  iCount = iCount + 1.
  CREATE ttData.
  ASSIGN ttData.iNumber = iCount.
  IMPORT ttData.iValue.
END.
INPUT CLOSE. 

FOR EACH ttData:
  FOR EACH bData WHERE bData.iNumber > ttData.iNumber:
    IF ttData.iValue + bData.iValue = 2020 THEN
    DO:
      MESSAGE ttData.iValue * bData.iValue VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      STOP.
    END.
  END.
END.

/* ---------------------------                  */
/* Information (Press HELP to view stack trace) */
/* ---------------------------                  */
/* 1015476                                      */
/* ---------------------------                  */
/* OK   Help                                    */
/* ---------------------------                  */
