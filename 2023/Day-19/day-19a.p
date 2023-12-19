/* AoC 2023 day 19a 
 */ 
DEFINE TEMP-TABLE ttRule NO-UNDO
  FIELD cName AS CHARACTER FORMAT "x(4)"
  FIELD iLine AS INTEGER   FORMAT "9"
  FIELD cCat  AS CHARACTER FORMAT "x" /* X,M,A,S */
  FIELD cWhen AS CHARACTER FORMAT "x" /* <,> */
  FIELD iVal  AS INTEGER   FORMAT ">>>9"
  FIELD cThen AS CHARACTER FORMAT "x(4)"
  INDEX iPrim cName iLine.

DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cRule   AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChunk  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iRate-X AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRate-M AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRate-A AS INTEGER   NO-UNDO.
DEFINE VARIABLE iRate-S AS INTEGER   NO-UNDO.
DEFINE VARIABLE iAnswer AS INTEGER   NO-UNDO.

INPUT FROM "data.txt".

/* Rules */
REPEAT :
  IMPORT UNFORMATTED cLine.
  IF cLine = "" THEN LEAVE.

  cRule = ENTRY(1,cLine,"~{").
  cLine = ENTRY(1, ENTRY(2,cLine,"~{"), "~}").

  DO i = 1 TO NUM-ENTRIES(cLine):
    cChunk = ENTRY(i,cLine).

    CREATE ttRule.
    ASSIGN ttRule.cName = cRule
           ttRule.iLine = i.

    /* a<2006:qkq */
    IF cChunk MATCHES "*<*:*" THEN 
      ASSIGN ttRule.cCat  = ENTRY(1,cChunk,"<")
             ttRule.cWhen = "<"
             ttRule.iVal  = INTEGER(ENTRY(1,ENTRY(2,cChunk,"<"),":"))
             ttRule.cThen = ENTRY(2,cChunk,":").

    /* m>2090:A */
    ELSE
    IF cChunk MATCHES "*>*:*" THEN 
      ASSIGN ttRule.cCat  = ENTRY(1,cChunk,">")
             ttRule.cWhen = ">"
             ttRule.iVal  = INTEGER(ENTRY(1,ENTRY(2,cChunk,">"),":"))
             ttRule.cThen = ENTRY(2,cChunk,":").

    /* A/R */
    ELSE 
      ASSIGN ttRule.cCat  = ""
             ttRule.cWhen = ""
             ttRule.iVal  = 0
             ttRule.cThen = cChunk.
  END.
END. /* rules */


#Flow:
REPEAT:

  IMPORT UNFORMATTED cLine. 
  cLine = TRIM(cLine,"~{~}").

  cRule = "in". /* Start with "IN" rule */
  iRate-X = INTEGER(ENTRY(2,ENTRY(1,cLine),"=")).
  iRate-M = INTEGER(ENTRY(2,ENTRY(2,cLine),"=")).
  iRate-A = INTEGER(ENTRY(2,ENTRY(3,cLine),"=")).
  iRate-S = INTEGER(ENTRY(2,ENTRY(4,cLine),"=")).

  #NewRule:
  REPEAT:

    #SubRule:
    FOR EACH ttRule WHERE ttRule.cName = cRule BY ttRule.cName BY ttRule.iLine:
  
      CASE ttRule.cCat + ttRule.cWhen:
        WHEN "X>" THEN IF iRate-X > ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "X<" THEN IF iRate-X < ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "M>" THEN IF iRate-M > ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "M<" THEN IF iRate-M < ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "A>" THEN IF iRate-A > ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "A<" THEN IF iRate-A < ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "S>" THEN IF iRate-S > ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "S<" THEN IF iRate-S < ttRule.iVal THEN cRule = ttRule.cThen.
        WHEN "" THEN cRule = ttRule.cThen.
      END CASE.
  
      IF cRule = "R" THEN NEXT #Flow. /* rejected */
  
      IF cRule = "A" THEN /* Accepted */
      DO:
        iAnswer = iAnswer + iRate-X + iRate-M + iRate-A + iRate-S.
        NEXT #flow.
      END.
  
      IF cRule <> ttRule.cName THEN LEAVE #SubRule. /* jump to other rule */
    END. /* f/e ttRule */

  END. /* #SubRule */

END.
INPUT CLOSE. 

MESSAGE iAnswer
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* 432788 */

