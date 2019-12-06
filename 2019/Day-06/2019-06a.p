/* AoC 2019 day 6
*/
DEFINE TEMP-TABLE ttOrbit NO-UNDO
  FIELD cInner  AS CHARACTER 
  FIELD cOuter  AS CHARACTER
  FIELD iOrbits AS INTEGER
  INDEX iPrim cOuter.

DEFINE VARIABLE cData   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iOrbits AS INTEGER   NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.
DEFINE VARIABLE j       AS INTEGER   NO-UNDO.
DEFINE VARIABLE c       AS CHARACTER NO-UNDO EXTENT 2.

FUNCTION numOrbits RETURNS INTEGER (pcObj AS CHARACTER):
  DEFINE BUFFER bOrbit FOR ttOrbit. 
  DEFINE VARIABLE iOrbits AS INTEGER   NO-UNDO.

  FOR EACH bOrbit WHERE bOrbit.cOuter = pcObj:
    IF bOrbit.iOrbits = 0 THEN bOrbit.iOrbits = numOrbits(bOrbit.cInner).
    iOrbits = iOrbits + 1 + bOrbit.iOrbits.
  END.
  RETURN iOrbits.
END FUNCTION. 

FUNCTION getPath RETURNS CHARACTER (pcObj AS CHARACTER):
  DEFINE BUFFER bOrbit FOR ttOrbit. 

  FIND bOrbit WHERE bOrbit.cOuter = pcObj NO-ERROR.
  RETURN (IF AVAILABLE bOrbit THEN bOrbit.cInner + ',' + getPath(bOrbit.cInner) ELSE ''). 
END FUNCTION. 

/* Read data */
INPUT FROM 2019-06.dat.
REPEAT:
  IMPORT cData.
  CREATE ttOrbit.
  ASSIGN 
    ttOrbit.cInner = ENTRY(1,cData,')')
    ttOrbit.cOuter = ENTRY(2,cData,')').
END.
INPUT CLOSE. 

/* Part 1: Calc num orbits for all objects */
FOR EACH ttOrbit:
  iOrbits = iOrbits + numOrbits(ttOrbit.cOuter).
END.

/* Part 1: Find shortes path to Santa */
c[1] = getPath('SAN').
c[2] = getPath('YOU').
j = MINIMUM( NUM-ENTRIES(c[1]), NUM-ENTRIES(c[2]) ).

DO i = 1 TO MINIMUM( NUM-ENTRIES(c[1]), NUM-ENTRIES(c[2]) ):
  IF LOOKUP(ENTRY(i,c[1]), c[2]) > 0 THEN DO:
    MESSAGE "Part 1:" iOrbits SKIP 
            "Part 2:" i + LOOKUP(ENTRY(i,c[1]), c[2]) - 2 VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.
  END.   
END.


