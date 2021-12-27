/* AoC 2021 day 22b
 */ 
&GLOBAL-DEFINE path c:\Data\DropBox\AdventOfCode\2021\Day-22\

DEFINE VARIABLE giCubeId AS INT64 NO-UNDO.

DEFINE TEMP-TABLE ttCube NO-UNDO
  FIELD id AS INT64 FORMAT '->>,>>9'
  FIELD lo AS INT64 FORMAT '->>,>>9' EXTENT 3
  FIELD hi AS INT64 FORMAT '->>,>>9' EXTENT 3
  FIELD Pwr AS LOGICAL FORMAT 'on/off'
  INDEX iPrim id.

FUNCTION CubeId RETURNS INT64():
  giCubeId = giCubeId + 1.
  RETURN giCubeId.
END FUNCTION. /* CubeId */ 


FUNCTION numCubes RETURNS INT64():
  DEFINE VARIABLE iNum   AS INT64   NO-UNDO.
  DEFINE VARIABLE iCubes AS INTEGER NO-UNDO.
  DEFINE BUFFER bCube FOR ttCube.
  FOR EACH bCube WHERE bCube.pwr = TRUE:
    iCubes = 1.
    DO i = 1 TO 3:
      iCubes = iCubes * ((bCube.hi[i] - bCube.lo[i]) + 1).      
    END.
    iNum = iNum + iCubes.
  END.
  RETURN iNum.
END FUNCTION. /* numCubes */


FUNCTION newCube RETURNS INT64
  ( pPwr AS LOGICAL 
  , pLo  AS INT64 EXTENT
  , pHi  AS INT64 EXTENT ):

  DEFINE BUFFER bCube FOR ttCube. 
  DEFINE VARIABLE i AS INTEGER NO-UNDO.

  /* Check validity of coordinates (for part 1) */
  DO i = 1 TO 3:
    IF pLo[i] < -50 OR pHi[i] > 50 THEN RETURN 0.
  END.
  
  CREATE bCube.
  ASSIGN 
    bCube.id = CubeId()
    bCube.lo  = pLo
    bCube.hi  = pHi
    bCube.pwr = pPwr.

  RETURN bCube.id.
END FUNCTION. /* newCube */


PROCEDURE splitCube:
  /* Cut pieces off from old cube that do not overlap with the new one.
  ** Finally the old one is nothing more than the overlapping part 
  ** of the two cubes. All original parts of the old cube that were
  ** cut off, are now new cubes. The old cube can now be deleted. 
  */
  DEFINE INPUT PARAMETER piOld AS INT64 NO-UNDO.
  DEFINE INPUT PARAMETER piNew AS INT64 NO-UNDO.
  
  DEFINE VARIABLE lOverlap AS LOGICAL NO-UNDO.
  DEFINE VARIABLE lPartial AS LOGICAL NO-UNDO.
  DEFINE VARIABLE i        AS INTEGER NO-UNDO.
  DEFINE VARIABLE iCube    AS INTEGER NO-UNDO.
  
  DEFINE BUFFER bOld  FOR ttCube.
  DEFINE BUFFER bNew  FOR ttCube.
  DEFINE BUFFER bCube FOR ttCube.

  FIND bOld WHERE bOld.id = piOld.
  FIND bNew WHERE bNew.id = piNew. 
  
  /* Does the new cube fully enclose the old one? */
  lOverlap = TRUE.
  DO i = 1 TO 3:
    IF bNew.lo[i] > bOld.lo[i] OR bNew.hi[i] < bOld.hi[i] THEN lOverlap = FALSE.
  END.  
  IF lOverlap THEN /* old one is fully obsolete */
  DO:      
    DELETE bOld.
    RETURN.
  END.   

  /* Do the cubes overlap partially? */
  lPartial = FALSE.
  DO i = 1 TO 3:
    IF bOld.lo[i] <= bNew.hi[i] AND bOld.hi[i] >= bNew.lo[i] THEN lOverlap = TRUE.
  END.   
  IF NOT lOverlap THEN RETURN.

  /* Cut off pieces until we can delete the overlapping part
  ** Cube-A is old, cube-B is new and is placed on top of cube-A
  **
  **    +-------+        +---+---+        +---+---+        +---+---+      
  **    | A     |        | C | A |        | C | D |        | C | D |      
  **    |   +---+---+    |   +---+---+    |   +---+---+    |   +---+---+  
  **    |   |A B|   |    |   |A B|   |    |   |A B|   |    |   |       |  
  **    +---+---+   |    +---+---+   |    +---+---+   |    +---+   B   |  
  **        |     B |        |     B |        |     B |        |       |  
  **        +-------+        +-------+        +-------+        +-------+  
  **       step 0           step 1           step 2           step 3                               
  */ 
  DO i = 1 TO 3:
    IF bOld.lo[i] < bNew.lo[i] THEN 
    DO:
      iCube = newCube(bOld.pwr, bOld.lo, bOld.hi).
      FIND bCube WHERE bCube.id = iCube.
      bCube.hi[i] = bNew.lo[i] - 1.
      bOld.lo[i] = bNew.lo[i].
    END.
    IF bOld.hi[i] > bNew.hi[i] THEN 
    DO:
      iCube = newCube(bOld.pwr, bOld.lo, bOld.hi).
      FIND bCube WHERE bCube.id = iCube.
      bCube.lo[i] = bNew.hi[i] + 1.
      bOld.hi[i] = bNew.hi[i].
    END.
  END.
    
  /* Old is now the overlapping part and is obsolete */
  DELETE bOld.
  
END PROCEDURE. /* splitCube */


PROCEDURE readData:
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iNew  AS INT64     NO-UNDO.
  DEFINE VARIABLE iLo   AS INT64     NO-UNDO EXTENT 3.
  DEFINE VARIABLE iHi   AS INT64     NO-UNDO EXTENT 3.
  DEFINE BUFFER bCube FOR ttCube.

  /* on x=10..12,y=10..12,z=10..12 */
  INPUT FROM "{&path}test-1.txt".
  REPEAT:
    IMPORT UNFORMATTED cLine. 
    IF cLine = "" THEN LEAVE.
    
    cLine = REPLACE(cLine,'..',','). /* on x=10,12,y=10,12,z=10,12 */ 
    cLine = REPLACE(cLine,'=',',').  /* on x,10,12,y,10,12,z,10,12 */        

    iLo[1] = INT64(ENTRY(2,cLine)). /* x1 */
    iHi[1] = INT64(ENTRY(3,cLine)). /* x2 */
    iLo[2] = INT64(ENTRY(5,cLine)). /* y1 */
    iHi[2] = INT64(ENTRY(6,cLine)). /* y2 */
    iLo[3] = INT64(ENTRY(8,cLine)). /* z1 */
    iHi[3] = INT64(ENTRY(9,cLine)). /* z2 */
    
    iNew = newCube( (cLine BEGINS 'on'), iLo, iHi).
    IF iNew = 0 THEN NEXT.
    
    HIDE MESSAGE NO-PAUSE.
    MESSAGE iNew.
    PROCESS EVENTS.

    /* Check against all existing cubes */
    FOR EACH bCube WHERE bCube.id < iNew:
      RUN splitCube(bCube.id, iNew).
    END.

    /* No need to save cubes that are off */
    IF cLine BEGINS 'off' THEN DO:
      FIND bCube WHERE bCube.id = iNew.
      DELETE bCube.
    END.
        
  END.
  INPUT CLOSE. 
  
END PROCEDURE. /* readData */ 


PROCEDURE testSplit:
  DEFINE VARIABLE iCube AS INT64 NO-UNDO EXTENT 2.
  DEFINE VARIABLE iLo   AS INT64 NO-UNDO EXTENT 3.
  DEFINE VARIABLE iHi   AS INT64 NO-UNDO EXTENT 3.

  EMPTY TEMP-TABLE ttCube.

  ASSIGN iLo[1] = 1 iHi[1] = 1
         iLo[2] = 1 iHi[2] = 1
         iLo[3] = 1 iHi[3] = 2.   
  iCube[1] = newCube(FALSE, iLo, iHi).
  
  ASSIGN iLo[1] = 1 iHi[1] = 1
         iLo[2] = 1 iHi[2] = 1
         iLo[3] = 2 iHi[3] = 3.   
  iCube[2] = newCube(TRUE, iLo, iHi).
  
  RUN showCubes.

  RUN splitCube(iCube[1], iCube[2]).
  RUN showCubes.

END PROCEDURE. /* testSplit */ 


PROCEDURE showCubes:

  CURRENT-WINDOW:WIDTH = 120.
  FOR EACH ttCube:
    DISPLAY ttCube WITH WIDTH 120.
    DISPLAY ((ttCube.hi[1] - ttCube.lo[1]) + 1) 
          * ((ttCube.hi[2] - ttCube.lo[2]) + 1) 
          * ((ttCube.hi[3] - ttCube.lo[3]) + 1) FORMAT '->>,>>9' COLUMN-LABEL "Num".
  END. 
END PROCEDURE. /* showCubes */ 



/* Main 
*/
ETIME(YES).
RUN readData.

DEFINE VARIABLE i AS INT64 NO-UNDO.
DEFINE VARIABLE j AS INT64 NO-UNDO.

FOR EACH ttCube WHERE ttCube.pwr = TRUE:
  j = j + 1.
  i = i + ((ttCube.hi[1] - ttCube.lo[1]) + 1) * ((ttCube.hi[2] - ttCube.lo[2]) + 1) * ((ttCube.hi[3] - ttCube.lo[3]) + 1).
END.

MESSAGE j "Cuboids" SKIP 
        i "Cubes" SKIP 
        ETIME "ms" VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

.RUN testSplit.
RUN showCubes.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 3924 Cuboids                */
/* 1268313839428137 Cubes      */
/* 11183 ms                    */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
