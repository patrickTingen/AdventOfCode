/* AoC 2019 day 2 (better) */
DEFINE VARIABLE p     AS INTEGER NO-UNDO INITIAL 1.
DEFINE VARIABLE iOrg  AS INTEGER EXTENT NO-UNDO INITIAL [{2019-02.dat}].
DEFINE VARIABLE iNum  AS INTEGER EXTENT NO-UNDO INITIAL [{2019-02.dat}].
DEFINE VARIABLE iVerb AS INTEGER NO-UNDO.
DEFINE VARIABLE iNoun AS INTEGER NO-UNDO.

DO iNoun = 0 TO 99:
  DO iVerb = 0 TO 99:

    p = 1.
    iNum = iOrg.
    iNum[2] = iNoun.
    iNum[3] = iVerb.

    REPEAT WHILE iNum[p] <> 99:
      IF iNum[p] = 1 THEN iNum[ iNum[p + 3] + 1] = iNum[ iNum[p + 1] + 1] + iNum[ iNum[p + 2] + 1].
      IF iNum[p] = 2 THEN iNum[ iNum[p + 3] + 1] = iNum[ iNum[p + 1] + 1] * iNum[ iNum[p + 2] + 1].
      p = p + 4.
    END.

    IF iNoun = 12 AND iVerb = 2 THEN MESSAGE iNum[1] VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    IF iNum[1] = 19690720 THEN MESSAGE iNoun * 100 + iVerb ETIME VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
  END.
END.

