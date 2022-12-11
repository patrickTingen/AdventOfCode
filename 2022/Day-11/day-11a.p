/* AoC 2022 day 11a 
 */ 
DEFINE TEMP-TABLE ttMonkey NO-UNDO
  FIELD iNr        AS INT64
  FIELD cItems     AS CHARACTER FORMAT 'x(40)'
  FIELD cOperation AS CHARACTER
  FIELD cParameter AS CHARACTER
  FIELD iDivisable AS INT64
  FIELD iTrue      AS INT64
  FIELD iFalse     AS INT64
  FIELD iInspects  AS INT64
  INDEX idxPrim IS PRIMARY iNr
  INDEX idxInspects iInspects DESCENDING
  .
  
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO. 
DEFINE VARIABLE iMonkey AS INT64     NO-UNDO.
DEFINE VARIABLE iRound  AS INT64     NO-UNDO.
DEFINE VARIABLE iItem   AS INT64     NO-UNDO.
DEFINE VARIABLE iWorry  AS INT64     NO-UNDO.
DEFINE VARIABLE iParam  AS INT64     NO-UNDO.
DEFINE VARIABLE iPartA  AS INT64     NO-UNDO.

DEFINE BUFFER otherMonkey FOR ttMonkey.

INPUT FROM data.txt.

#data:
REPEAT:
  IMPORT UNFORMATTED cLine.
  cLine = TRIM(cLine).
  
  IF cLine BEGINS 'Monkey' THEN
  DO:
    iMonkey = INT64(ENTRY(2,TRIM(cLine,':'),' ')).
    
    CREATE ttMonkey.    
    ASSIGN ttMonkey.iNr = iMonkey.
    NEXT #data.
  END.
  
  FIND ttMonkey WHERE ttMonkey.iNr = iMonkey.
  
  CASE ENTRY(1,cLine,':'):
    WHEN 'Starting Items' THEN ttMonkey.cItems = REPLACE(TRIM(ENTRY(2,cLine,':')),' ','').
    WHEN 'Operation'      THEN 
    DO:
      ttMonkey.cOperation = ENTRY(5,cLine,' ').
      ttMonkey.cParameter = ENTRY(6,cLine,' ').
    END.
    WHEN 'Test'     THEN ttMonkey.iDivisable = INT64(ENTRY(4,cLine,' ')).
    WHEN 'If true'  THEN ttMonkey.iTrue  = INT64(ENTRY(6,cLine,' ')).
    WHEN 'If false' THEN ttMonkey.iFalse = INT64(ENTRY(6,cLine,' ')).
  END CASE.

END.
INPUT CLOSE.


DO iRound = 1 TO 20:

  FOR EACH ttMonkey:
  
    DO iItem = 1 TO NUM-ENTRIES(ttMonkey.cItems):
    
      /* Monkey inspects an item */
      ttMonkey.iInspects = ttMonkey.iInspects + 1.      
      iWorry = INT64(ENTRY(iItem,ttMonkey.cItems)).      
      
      /* Worry level is multiplied */
      iParam = (IF ttMonkey.cParameter = 'old' THEN iWorry ELSE INT64(ttMonkey.cParameter)).
      CASE ttMonkey.cOperation: 
        WHEN '*' THEN iWorry = iWorry * iParam.
        WHEN '+' THEN iWorry = iWorry + iParam.
      END CASE.
      
      /* Worry level is divided by 3 */
      iWorry = TRUNC(iWorry / 3,0).

      /* Current worry level divisible?*/
      FIND otherMonkey WHERE otherMonkey.iNr = (IF iWorry MOD ttMonkey.iDivisable = 0 THEN ttMonkey.iTrue ELSE ttMonkey.iFalse).
      otherMonkey.cItems = TRIM(SUBSTITUTE('&1,&2',otherMonkey.cItems, iWorry), ',').
        
      /* Mark item for removal from list */
      ENTRY(iItem,ttMonkey.cItems) = 'x'.        
    END.

    /* Clean up list of items */ 
    ttMonkey.cItems = ''.    
  END.
END.

FIND FIRST ttMonkey USE-INDEX idxInspects.
iPartA = ttMonkey.iInspects.

FIND NEXT ttMonkey USE-INDEX idxInspects.
iPartA = iPartA * ttMonkey.iInspects.

MESSAGE iPartA VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
CLIPBOARD:VALUE = STRING(iPartA).

