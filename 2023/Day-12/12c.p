DEFINE TEMP-TABLE tt NO-UNDO
  FIELD a AS INTEGER
  FIELD b AS INTEGER
  FIELD v AS INTEGER
  INDEX iPrim a b.

FUNCTION setDp RETURNS LOGICAL (a AS INT, b AS INT, v AS INT):
  FIND tt WHERE tt.a = a AND tt.b = b NO-ERROR.
  IF NOT AVAILABLE tt THEN DO:
    CREATE tt.
    ASSIGN tt.a = a tt.b = b.
  END.
  ASSIGN tt.v = v.
END FUNCTION. 

FUNCTION dp RETURNS INTEGER (a AS INT, b AS INT):
  FIND tt WHERE tt.a = a AND tt.b = b NO-ERROR.
  RETURN (IF AVAILABLE tt THEN tt.v ELSE 0).
END FUNCTION. 

DEFINE VARIABLE max-hashes AS INTEGER EXTENT 100 NO-UNDO.

FUNCTION CountCombinations RETURNS INTEGER 
  ( s AS CHARACTER
  , runs AS CHARACTER ):

  DEFINE VARIABLE i AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j AS INTEGER   NO-UNDO.
  DEFINE VARIABLE v AS INTEGER   NO-UNDO.
  DEFINE VARIABLE r AS INTEGER   NO-UNDO.

  /* Returns the number of ways question marks in `s` can be filled in
     consistent with `runs`. `s` must have an extra '.' appended. */

  /* One way to view the problem is that we must construct a solution string by
     concatenating several strings of the form "###." (where the number of hashes
     in each string matches the values of `runs`); however we are also allowed to
     insert extra filler characters ('.'). This interpretation requires that s
     ends with a '.'. */
  IF SUBSTRING(s,LENGTH(s),1) <> "." THEN s = s + ".".

  /* max-hashes[j] is the maximum number of hashes at the end of prefix s[:j].
     For example, for s = "?#?.#", max-hashes = [0, 1, 2, 3, 0, 1] because we can
     change the question marks to hashes, but not the fixed '.'. */
  DO j = 1 TO LENGTH(s):
    IF SUBSTRING(s,j,1) <> "." THEN max-hashes[j + 1] = max-hashes[j] + 1.
  END.

  /* dp[i][j] is the number of ways the prefix of s of length i (s[:i]) can be
     filled to match the prefix of runs of length j (runs[:j]). */
  DO i = 1 TO NUM-ENTRIES(runs):
    r = INTEGER(ENTRY(i,runs)).
    DO j = 1 TO LENGTH(s):
      IF SUBSTRING(s,j,1) <> "#" THEN
      DO:
        v = dp(i + 1,j) + ( IF r <= max-hashes[j] AND dp(i,j - r) <> 0 THEN 1 ELSE 0).
        setDp(i + 1, j + 1, v).
        /*
          for i, n in enumerate(runs):
            for j in range(len(s)):
              if s[j] != '#':
                dp[i + 1][j + 1] = dp[i + 1][j] + (n <= max_hashes[j] and dp[i][j - n])
        */        


      END.
    END.
  END.

  RETURN dp(NUM-ENTRIES(runs),LENGTH(s)).
END FUNCTION.

MESSAGE countCombinations(".??..??...?##.", "1,1,3")
  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

