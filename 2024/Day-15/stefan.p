DEF VAR iwidth AS INT.
DEF VAR iheight AS INT.
DEF VAR cData AS CHAR. 

define temp-table ttMap no-undo
  field x as int
  field y as int
  field c as char     
  index ix is unique x y
  index iy y x.

FUNCTION readInput RETURNS character ( cfile as char ):

  define buffer bu for ttMap.

  DEF VAR ix AS INT.
  DEF VAR iy AS INT. 
  DEF VAR cLine AS CHAR.
  DEF VAR cMoves AS CHAR. 
  DEF VAR lMoves AS LOG.

  input from value( cfile ).

  repeat:
     import unformatted cline.

     if cline = '' then
        assign
           iheight = iy - 1
           lmoves = true.

     if lmoves then
        cmoves = cmoves + cline.
     else 
     do:
        do ix = 1 to length( cline ):
           do for bu:
              create bu.
              assign
                 bu.x = ix - 1
                 bu.y = iy
                 bu.c = substring( cline, ix, 1 ).
           end.
        end.   
        iy = iy + 1.
     end.
  end.
  input close.
  return cmoves.
END FUNCTION.


FUNCTION findSpace RETURNS logical ( i_x as int, i_y as int, i_dx as int, i_dy as int ):

  define buffer bu for ttMap.

  DEF VAR ix AS INT.
  DEF VAR iy AS INT. 

  ix = i_x + i_dx.
  iy = i_y + i_dy.

  find bu where bu.x = ix and bu.y = iy.

  case bu.c:
     when '.' then return true.
     when '#' then return false.
     when 'O' then return findSpace( ix, iy, i_dx, i_dy ).
  end case.

  RETURN FALSE. 
end FUNCTION.

FUNCTION moveRobot2 RETURNS LOGICAL ( i_x as int, i_y as int, i_dx as int, i_dy as int ):

  define buffer bu1 for ttMap.
  define buffer bu2 for ttMap.

  DEF VAR ix AS INT. 
  DEF VAR iy AS INT. 

  ix = i_x + i_dx.
  iy = i_y + i_dy.

  find bu1 where bu1.x = ix and bu1.y = iy.

  if bu1.c = '#' THEN return false.
  if bu1.c = '.' then return true.

  if findSpace(ix, iy, i_dx, i_dy) then 
  do:
     if      i_dx =  1 THEN find first bu2 where bu2.y = iy and bu2.x > ix and bu2.c = '.'.
     else if i_dx = -1 THEN find LAST  bu2 where bu2.y = iy and bu2.x < ix and bu2.c = '.'.
     else if i_dy =  1 THEN find first bu2 where bu2.x = ix and bu2.y > iy and bu2.c = '.'.
     else if i_dy = -1 THEN find last  bu2 where bu2.x = ix and bu2.y < iy and bu2.c = '.'.

     assign
        bu2.c = bu1.c
        bu1.c = '.'.

     return true.
  end.

  return false.
end FUNCTION.


FUNCTION moveRobot RETURNS LOGICAL ( cmoves as char ):

  define buffer bu for ttMap.

  DEF VAR X AS INT.
  DEF VAR Y AS INT.
  DEF VAR ix AS INT.
  DEF VAR imoves AS INT.
  DEF VAR imove AS INT.
  DEF VAR cmove AS CHAR INIT '<^>v'.
  DEF VAR dx AS INT EXTENT 4 INIT [ -1,  0, 1, 0 ].
  DEF VAR dy AS INT EXTENT 4 INIT [  0, -1, 0, 1 ].

  find bu where bu.c = '@'.
  assign
     x = bu.x
     y = bu.y
     bu.c = '.'.

  imoves = length( cmoves ).
  do ix = 1 to imoves:
     imove = index( cmove, substring( cmoves, ix, 1 ) ).
     IF imove = 0 THEN LEAVE.
     if moveRobot2( x, y, dx[imove], dy[imove] ) then
        assign
           x = x + dx[imove]
           y = y + dy[imove].
  end.

  find bu where bu.x = x and bu.y = y.
  bu.c = '@'.

  RETURN YES.
end FUNCTION.


FUNCTION calcSumGPS RETURNS INT():

  DEF VAR isum AS INT. 
  define buffer bu for ttMap.

  for each bu where bu.c = 'O':
     isum = isum + 100 * bu.y + bu.x.
  end.

  return isum.
end FUNCTION.

ETIME(YES).
moveRobot(readInput("data.txt")).
message calcSumGPS() ETIME.

