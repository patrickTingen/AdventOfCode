/* AoC 2021 day 22b
 */ 
&GLOBAL-DEFINE path c:\Data\DropBox\AdventOfCode\2021\Day-22\

DEFINE VARIABLE giCubeId AS INT64 NO-UNDO.

DEFINE TEMP-TABLE ttCube NO-UNDO
  FIELD id  AS INT64 FORMAT '->>,>>9'
  FIELD x1  AS INT64 FORMAT '->>,>>9'
  FIELD y1  AS INT64 FORMAT '->>,>>9'
  FIELD z1  AS INT64 FORMAT '->>,>>9'
  FIELD x2  AS INT64 FORMAT '->>,>>9'
  FIELD y2  AS INT64 FORMAT '->>,>>9'
  FIELD z2  AS INT64 FORMAT '->>,>>9'
  FIELD Pwr AS LOGICAL FORMAT 'on/off'
  INDEX iPrim id
  INDEX iLoc x1 x2 y1 y2 z1 z2.

FUNCTION CubeId RETURNS INT64():
  giCubeId = giCubeId + 1.
  RETURN giCubeId.
END FUNCTION. /* CubeId */ 


FUNCTION numCubes RETURNS INT64():
  DEFINE VARIABLE iNum AS INT64 NO-UNDO.
  DEFINE BUFFER bCube FOR ttCube.
  FOR EACH bCube WHERE bCube.pwr = TRUE:
    iNum = iNum + ((bCube.x2 - bCube.x1) + 1) 
                * ((bCube.y2 - bCube.y1) + 1) 
                * ((bCube.z2 - bCube.z1) + 1).
  END.
  RETURN iNum.
END FUNCTION. /* numCubes */


FUNCTION newCube RETURNS INT64
  ( pPwr AS LOGICAL 
  , px1 AS INT64, py1 AS INT64, pz1 AS INT64
  , px2 AS INT64, py2 AS INT64, pz2 AS INT64 ):

  DEFINE BUFFER bCube FOR ttCube. 

  /* Check validity of coordinates (for part 1) */
  /*   IF px1 < -50 OR px1 > 50 OR px2 < -50 OR px2 > 50                */
  /*   OR py1 < -50 OR py1 > 50 OR py2 < -50 OR py2 > 50                */
  /*   OR pz1 < -50 OR pz1 > 50 OR pz2 < -50 OR pz2 > 50 THEN RETURN 0. */
  
  CREATE bCube.
  ASSIGN 
    bCube.id = CubeId()
    bCube.x1  = px1
    bCube.x2  = px2
    bCube.y1  = py1
    bCube.y2  = py2
    bCube.z1  = pz1
    bCube.z2  = pz2
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

  DEFINE BUFFER bOld FOR ttCube.
  DEFINE BUFFER bNew FOR ttCube.

  FIND bOld WHERE bOld.id = piOld.
  FIND bNew WHERE bNew.id = piNew. 
  
  /* Does the new cube fully enclose the old one? */
  IF    bNew.x1 <= bOld.x1 AND bNew.x2 >= bOld.x2
    AND bNew.y1 <= bOld.y1 AND bNew.y2 >= bOld.y2 
    AND bNew.z1 <= bOld.z1 AND bNew.z2 >= bOld.z2 THEN 
  DO:
    /* Then the old one is fully obsolete */
    DELETE bOld.
    RETURN.
  END.

  /* Do the cubes overlap partially? */
  IF NOT(    bOld.x1 <= bNew.x2 AND bOld.x2 >= bNew.x1 
         AND bOld.y1 <= bNew.y2 AND bOld.y2 >= bNew.y1 
         AND bOld.z1 <= bNew.z2 AND bOld.z2 >= bNew.z1) THEN RETURN.

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
  IF bOld.x1 < bNew.x1 THEN 
  DO:
    newCube(bOld.pwr, bOld.x1, bOld.y1, bOld.z1, bNew.x1 - 1, bOld.y2, bOld.z2). 
    bOld.x1 = bNew.x1.
  END.
  IF bOld.x2 > bNew.x2 THEN 
  DO:
    newCube(bOld.pwr, bNew.x2 + 1, bOld.y1, bOld.z1, bOld.x2, bOld.y2, bOld.z2).
    bOld.x2 = bNew.x2.
  END.
  
  /* Y-part */
  IF bOld.y1 < bNew.y1 THEN 
  DO:
    newCube(bOld.pwr, bOld.x1, bOld.y1, bOld.z1, bOld.x2, bNew.y1 - 1, bOld.z2).
    bOld.y1 = bNew.y1.
  END.
  IF bOld.y2 > bNew.y2 THEN 
  DO:
    newCube(bOld.pwr, bOld.x1, bNew.y2 + 1, bOld.z1, bOld.x2, bOld.y2, bOld.z2).
    bOld.y2 = bNew.y2.
  END.
  
  /* Z-part */
  IF bOld.z1 < bNew.z1 THEN 
  DO:
    newCube(bOld.pwr, bOld.x1, bOld.y1, bOld.z1, bOld.x2, bOld.y2, bNew.z1 - 1).
    bOld.z1 = bNew.z1.
  END.
  IF bOld.z2 > bNew.z2 THEN 
  DO:
    newCube(bOld.pwr, bOld.x1, bOld.y1, bNew.z2 + 1, bOld.x2, bOld.y2, bOld.z2).
    bOld.z2 = bNew.z2.
  END.
  
  /* Old is now the overlapping part and is obsolete */
  DELETE bOld.
  
END PROCEDURE. /* splitCube */


PROCEDURE readData:
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iNew  AS INT64     NO-UNDO.
  DEFINE BUFFER bCube FOR ttCube.

  /* on x=10..12,y=10..12,z=10..12 */
  INPUT FROM "{&path}data.txt".
  REPEAT:
    IMPORT UNFORMATTED cLine. 
    IF cLine = "" THEN LEAVE.
    
    cLine = REPLACE(cLine,'..',','). /* on x=10,12,y=10,12,z=10,12 */ 
    cLine = REPLACE(cLine,'=',',').  /* on x,10,12,y,10,12,z,10,12 */ 

    iNew = newCube( (cLine BEGINS 'on') /* power */
                  , INT64(ENTRY(2,cLine)), INT64(ENTRY(5,cLine)), INT64(ENTRY(8,cLine)) /* x y z */
                  , INT64(ENTRY(3,cLine)), INT64(ENTRY(6,cLine)), INT64(ENTRY(9,cLine)) /* x y z */
                  ).
    IF iNew = 0 THEN NEXT.

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

  EMPTY TEMP-TABLE ttCube.

  iCube[1] = newCube(FALSE, 1,1,1, 1,1,2).
  iCube[2] = newCube(TRUE , 1,1,2, 1,1,3).
  RUN showCubes.

  RUN splitCube(iCube[1], iCube[2]).
  RUN showCubes.

END PROCEDURE. /* testSplit */ 


PROCEDURE showCubes:

  CURRENT-WINDOW:WIDTH = 80.
  FOR EACH ttCube:
    DISPLAY ttCube WITH WIDTH 80.
    DISPLAY ((ttCube.x2 - ttCube.x1) + 1) 
          * ((ttCube.y2 - ttCube.y1) + 1) 
          * ((ttCube.z2 - ttCube.z1) + 1) FORMAT '->>,>>9' COLUMN-LABEL "Num".
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
  i = i + ((ttCube.x2 - ttCube.x1) + 1) * ((ttCube.y2 - ttCube.y1) + 1) * ((ttCube.z2 - ttCube.z1) + 1).
END.

MESSAGE j "Cuboids" SKIP 
        i "Cubes" SKIP 
        ETIME "ms" VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

.RUN testSplit.
.RUN showCubes.

/* --------------------------- */
/* Information                 */
/* --------------------------- */
/* 3924 Cuboids                */
/* 1268313839428137 Cubes      */
/* 11183 ms                    */
/* --------------------------- */
/* OK                          */
/* --------------------------- */
