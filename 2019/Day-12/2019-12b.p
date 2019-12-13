/* AoC 2019 - 12b
*/
DEFINE TEMP-TABLE ttPlanet NO-UNDO
  FIELD Nr AS INTEGER
  FIELD X  AS INTEGER
  FIELD Y  AS INTEGER
  FIELD Z  AS INTEGER
  FIELD vX AS INTEGER
  FIELD vY AS INTEGER
  FIELD vZ AS INTEGER.

DEFINE TEMP-TABLE ttState NO-UNDO
  FIELD iStep    AS INTEGER
  FIELD cState-X AS CHARACTER
  FIELD cState-Y AS CHARACTER
  FIELD cState-Z AS CHARACTER
  INDEX iStateX cState-X
  INDEX iStateY cState-Y
  INDEX iStateZ cState-Z.

function gcd returns int64 (x as int64, y as int64):
  if y = 0 then return x.
  return gcd(y, x mod y).
end function.

function lcm returns int64 (x as int64, y as int64):
  return int64((x * y) / gcd(x, y)).
end function.

DEFINE VARIABLE iPot   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iKin   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTot   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE c      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iData  AS INTEGER   NO-UNDO INITIAL 3.
DEFINE VARIABLE iSteps AS INTEGER   NO-UNDO.
DEFINE VARIABLE cState AS CHARACTER NO-UNDO EXTENT 3.
DEFINE VARIABLE iFinal AS INTEGER   NO-UNDO EXTENT 3.

DEFINE BUFFER bPlanet FOR ttPlanet. 

CASE iData:
  WHEN 1 THEN DO:
    /* Example 1 */
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 1 ttPlanet.X =  -1 ttPlanet.Y =   0 ttPlanet.Z =  2.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 2 ttPlanet.X =   2 ttPlanet.Y = -10 ttPlanet.Z = -7.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 3 ttPlanet.X =   4 ttPlanet.Y =  -8 ttPlanet.Z =  8.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 4 ttPlanet.X =   3 ttPlanet.Y =   5 ttPlanet.Z = -1.
    ASSIGN iSteps = 10.
  END.

  WHEN 2 THEN DO:
    /* Example 2 */
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 1 ttPlanet.X =  -8 ttPlanet.Y = -10 ttPlanet.Z =  0.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 2 ttPlanet.X =   5 ttPlanet.Y =   5 ttPlanet.Z = 10.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 3 ttPlanet.X =   2 ttPlanet.Y =  -7 ttPlanet.Z =  3.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 4 ttPlanet.X =   9 ttPlanet.Y =  -8 ttPlanet.Z = -3.
    ASSIGN iSteps = 100.
  END.

  WHEN 3 THEN DO: 
    /* Real */
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 1 ttPlanet.X =   1 ttPlanet.Y =   4 ttPlanet.Z =  4.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 2 ttPlanet.X =  -4 ttPlanet.Y =  -1 ttPlanet.Z = 19.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 3 ttPlanet.X = -15 ttPlanet.Y = -14 ttPlanet.Z = 12.
    CREATE ttPlanet. ASSIGN ttPlanet.Nr = 4 ttPlanet.X = -17 ttPlanet.Y =   1 ttPlanet.Z = 10.
    ASSIGN iSteps = 1000.
  END.
END CASE.


REPEAT: 
  i = i + 1.

  /* Gravity */
  FOR EACH ttPlanet:
    FOR EACH bPlanet WHERE bPlanet.Nr <> ttPlanet.nr:
      IF ttPlanet.X < bPlanet.X THEN ASSIGN ttPlanet.vX = ttPlanet.vX + 1 bPlanet.vX = bPlanet.vX - 1.
      IF ttPlanet.Y < bPlanet.Y THEN ASSIGN ttPlanet.vY = ttPlanet.vY + 1 bPlanet.vY = bPlanet.vY - 1.
      IF ttPlanet.Z < bPlanet.Z THEN ASSIGN ttPlanet.vZ = ttPlanet.vZ + 1 bPlanet.vZ = bPlanet.vZ - 1.
    END.
  END.

  /* Position */
  FOR EACH ttPlanet BY ttPlanet.Nr:
    ttPlanet.X = ttPlanet.X + ttPlanet.vX.
    ttPlanet.Y = ttPlanet.Y + ttPlanet.vY.
    ttPlanet.Z = ttPlanet.Z + ttPlanet.vZ.
  END.

  /* Save state */
  cState = ''.
  FOR EACH ttPlanet:
    cState[1] = SUBSTITUTE('&1 | &2 @ &3', cState[1], ttPlanet.X, ttPlanet.vX).
    cState[2] = SUBSTITUTE('&1 | &2 @ &3', cState[2], ttPlanet.Y, ttPlanet.vY).
    cState[3] = SUBSTITUTE('&1 | &2 @ &3', cState[3], ttPlanet.Z, ttPlanet.vZ).
  END.

  FIND ttState WHERE ttState.cState-X = cState[1] NO-ERROR.
  IF AVAILABLE ttState AND iFinal[1] = 0 THEN iFinal[1] = i - 1.

  FIND ttState WHERE ttState.cState-Y = cState[2] NO-ERROR.
  IF AVAILABLE ttState AND iFinal[2] = 0 THEN iFinal[2] = i - 1.

  FIND ttState WHERE ttState.cState-Z = cState[3] NO-ERROR.
  IF AVAILABLE ttState AND iFinal[3] = 0 THEN iFinal[3] = i - 1.

  IF iFinal[1] <> 0 AND iFinal[2] <> 0 AND iFinal[3] <> 0 THEN
  DO:
    MESSAGE iFinal[1] iFinal[2] iFinal[3] SKIP 
            lcm(iFinal[1],lcm(iFinal[2],iFinal[3]))
      VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    STOP.
  END.

  CREATE ttState.
  ASSIGN 
    ttState.iStep    = i
    ttState.cState-X = cState[1] 
    ttState.cState-Y = cState[2] 
    ttState.cState-Z = cState[3].

  IF ETIME > 1000 THEN DO:
    HIDE MESSAGE NO-PAUSE.
    MESSAGE i iFinal[1] iFinal[2] iFinal[3].
    ETIME(YES).
    PROCESS EVENTS. 
  END.
END.


/* 
Set 1: 18 28 44
Set 2: 2029 5899 4703

---------------------------
Information 
---------------------------
186028 231614 108344 
583523031727256
---------------------------
OK   Help   
---------------------------
*/
