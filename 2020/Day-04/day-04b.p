/* Advent of code 2020 - day 4b
*/
DEFINE VARIABLE cLine  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iValid AS INTEGER   NO-UNDO.
DEFINE VARIABLE iFld   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE j      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cFld   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cVal   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iVal   AS INTEGER   NO-UNDO.

DEFINE TEMP-TABLE ttPass NO-UNDO 
  FIELD cData AS CHARACTER FORMAT 'x(200)'.

INPUT FROM day-04.dat.
REPEAT:
  IMPORT UNFORMATTED cLine.
  IF cLine = '' OR NOT AVAILABLE ttPass THEN CREATE ttPass.
  ttPass.cData = TRIM(ttPass.cData + ' ' + cLine).
  ttPass.cData = REPLACE(ttPass.cData, ' ', ',').
END.
INPUT CLOSE. 

/* DEBUG: save as TXT */
OUTPUT TO c:\temp\ttPass.txt.
FOR EACH ttPass NO-LOCK:
  PUT UNFORMATTED ttPass.cData SKIP.
END.
OUTPUT CLOSE. 

#Pass:
FOR EACH ttPass:
  iFld = 0.
  DO i = 1 TO NUM-ENTRIES(ttPass.cData):
    IF LOOKUP(ENTRY(1, ENTRY(i,ttPass.cData), ':'), 'byr,iyr,eyr,hgt,hcl,ecl,pid') > 0 THEN iFld = iFld + 1.
  END.
  IF iFld <> 7 THEN NEXT #Pass.

  DO i = 1 TO NUM-ENTRIES(ttPass.cData):
    cFld = ENTRY(1, ENTRY(i,ttPass.cData), ':').
    cVal = ENTRY(2, ENTRY(i,ttPass.cData) + ':', ':').
    iVal = 0.

    CASE cFld:
      WHEN 'byr' THEN IF cVal < '1920' OR cVal > '2002' THEN NEXT #Pass. 
      WHEN 'iyr' THEN IF cVal < '2010' OR cVal > '2020' THEN NEXT #Pass. 
      WHEN 'eyr' THEN IF cVal < '2020' OR cVal > '2030' THEN NEXT #Pass. 
      WHEN 'hgt' THEN DO:
        IF NOT cVal MATCHES "*in" AND NOT cVal MATCHES "*cm" THEN NEXT #Pass. 
        IF cVal MATCHES "*in" THEN DO:
          iVal = INTEGER(REPLACE(cVal,'in','')) NO-ERROR.
          IF iVal < 59 OR iVal > 76 THEN NEXT #Pass. 
        END.
        IF cVal MATCHES "*cm" THEN DO:
          iVal = INTEGER(REPLACE(cVal,'cm','')) NO-ERROR.
          IF iVal < 150 OR iVal > 193 THEN NEXT #Pass. 
        END.
      END.
      WHEN 'hcl' THEN DO:
        IF NOT cVal BEGINS '#' THEN NEXT #Pass. 
        IF LENGTH(cVal) <> 7 THEN NEXT #Pass. 
        DO j = 2 TO 7:
          IF LOOKUP(SUBSTRING(cVal,j,1), '0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f') = 0 THEN NEXT #Pass. 
        END.
      END.
      WHEN 'ecl' THEN IF LOOKUP(cVal,'amb,blu,brn,gry,grn,hzl,oth') = 0 THEN NEXT #Pass. 
      WHEN 'pid' THEN DO:
        IF LENGTH(cVal) <> 9 THEN NEXT #Pass. 
        iVal = INTEGER(cVal) NO-ERROR. 
        IF ERROR-STATUS:ERROR THEN NEXT #Pass. 
      END.
    END CASE.
  END.

  iValid = iValid + 1.
END.

MESSAGE iValid VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. /* 224 */



