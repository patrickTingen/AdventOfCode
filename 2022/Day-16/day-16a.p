/* AoC 2022 day 16a 
 */ 
DEFINE VARIABLE giStart AS INTEGER NO-UNDO.
DEFINE VARIABLE giExit  AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttTunnel NO-UNDO
  FIELD cValve   AS CHARACTER
  FIELD cOther   AS CHARACTER 
  FIELD iFlow    AS INTEGER
  FIELD cStatus  AS CHARACTER
  FIELD iTotal   AS INTEGER
  FIELD iTime    AS INTEGER
  FIELD cRoute   AS CHARACTER 
  INDEX idxPrim cValve
  INDEX idxTodo cStatus
  INDEX idxTotal iTotal DESC.

/* Part A 
*/
RUN readData.
RUN findExit("A").


PROCEDURE findExit:
  DEFINE INPUT PARAMETER pcPart AS CHARACTER NO-UNDO.

  DEFINE VARIABLE iNewFlow AS INTEGER NO-UNDO.

  DEFINE BUFFER bThis  FOR ttTunnel.
  DEFINE BUFFER bRoute FOR ttTunnel.

  #Main:
  REPEAT:        
    
    /* Find the most promising location */
    FIND FIRST bThis WHERE bThis.cStatus = "Todo" NO-ERROR.
    IF NOT AVAILABLE bThis THEN LEAVE #Main.

    /* No time left? */
    IF bThis.iTime <= 2 THEN
    DO:
      FIND FIRST bRoute USE-INDEX idxTotal.
      MESSAGE "Part A" bRoute.iTotal VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. 
      RETURN. 
    END.

    /* Examine the neighbours */
    FOR EACH bRoute 
      WHERE bRoute.cValve = bThis.cOther:

      iNewFlow = bThis.iTotal + (bThis.iTime - 2) * bRoute.iFlow.

      CASE bRoute.cStatus:
        WHEN "Done" THEN NEXT.
        WHEN "Wait" THEN ASSIGN bRoute.iTime   = bThis.iTime - 2
                                bRoute.iTotal  = iNewFlow
                                bRoute.cStatus = "Todo".
        WHEN "Todo" THEN IF iNewFlow > bRoute.iTotal THEN bThis.iTotal = iNewFlow.
      END CASE.
    END.

    bThis.cStatus = "Done".
  END. /* main */

END PROCEDURE. /* findExit */


PROCEDURE readData:
  /* Load data into TT
  */
  DEFINE VARIABLE cValveId AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cFlow    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
  
  DEFINE BUFFER bTunnel FOR ttTunnel. 

  /* Read file and strip nasty characters */
  INPUT FROM test.txt.
  REPEAT:
    IMPORT UNFORMATTED cLine.

    DO i = 1 TO NUM-ENTRIES(cLine, ' ').

      /* Valve AA has flow rate=0; tunnels lead to valves DD, II, BB */
      cValveId = ENTRY(i,cLine,' ').
      cValveId = ENTRY(NUM-ENTRIES(cValveId,' '),NUM-ENTRIES(cValveId,' ')).

      /* rate=0; */
      cFlow = ENTRY(5,cLine,' ').
      cFlow = TRIM(cFlow,';').
      cFlow = ENTRY(2,cFlow,'=').

      CREATE bTunnel.
      ASSIGN 
        bTunnel.cValve  = ENTRY(2,cLine,' ')
        bTunnel.cOther   = cValveId
        bTunnel.iFlow   = INTEGER(cFlow)
        bTunnel.cStatus = (IF bTunnel.cValve = "AA" THEN "Todo" ELSE "Wait")
        bTunnel.iTime   = (IF bTunnel.cValve = "AA" THEN 30 ELSE 0)
        .
    END.
  END.

END PROCEDURE. /* readData */

