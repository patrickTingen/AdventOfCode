/* AoC 2019 - 12
*/
DEFINE TEMP-TABLE ttPlanet NO-UNDO
  FIELD Nr AS INTEGER
  FIELD X  AS INTEGER
  FIELD Y  AS INTEGER
  FIELD Z  AS INTEGER
  FIELD vX AS INTEGER
  FIELD vY AS INTEGER
  FIELD vZ AS INTEGER.

DEFINE VARIABLE iPot   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iKin   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iTot   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
DEFINE VARIABLE c      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iData  AS INTEGER   NO-UNDO INITIAL 3.
DEFINE VARIABLE iSteps AS INTEGER   NO-UNDO.

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


DO i = 1 TO iSteps:

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
END.

FOR EACH ttPlanet BY ttPlanet.Nr:
  iPot = ABS(ttPlanet.X)  + ABS(ttPlanet.Y)  + ABS(ttPlanet.Z).
  iKin = ABS(ttPlanet.vX) + ABS(ttPlanet.vY) + ABS(ttPlanet.vZ).
  iTot = iTot + (iPot * iKin).
END.

MESSAGE 'part 1:' iTot VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

/* 
    c = SUBSTITUTE('&1~npos=<x=&2, y=&3, z=&4>, vel=<x=&5, y=&6, z=&7>', c
                 , ttPlanet.X, ttPlanet.Y, ttPlanet.Z
                 , ttPlanet.vX, ttPlanet.vY, ttPlanet.vZ).
*/
