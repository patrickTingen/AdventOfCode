&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/* Advent of code 2018
** day 10
*/
DEFINE TEMP-TABLE ttStar NO-UNDO
  FIELD iPosX AS INTEGER
  FIELD iPosY AS INTEGER
  FIELD iVelX AS INTEGER
  FIELD iVelY AS INTEGER
  INDEX iPrim IS PRIMARY iPosX iPosY.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btnIterate fiGeneration edStars 
&Scoped-Define DISPLAYED-OBJECTS fiGeneration edStars 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD hasText C-Win 
FUNCTION hasText RETURNS LOGICAL
  ( ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnIterate 
     LABEL "Iterate" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE edStars AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL LARGE
     SIZE 191.6 BY 29.05
     FONT 0 NO-UNDO.

DEFINE VARIABLE fiGeneration AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Generation" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btnIterate AT ROW 1.24 COL 3 WIDGET-ID 4
     fiGeneration AT ROW 1.24 COL 31 COLON-ALIGNED WIDGET-ID 8
     edStars AT ROW 2.67 COL 1.4 NO-LABEL WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 192.8 BY 30.86 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 31.14
         WIDTH              = 193.8
         MAX-HEIGHT         = 40.48
         MAX-WIDTH          = 305
         VIRTUAL-HEIGHT     = 40.48
         VIRTUAL-WIDTH      = 305
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnIterate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnIterate C-Win
ON CHOOSE OF btnIterate IN FRAME DEFAULT-FRAME /* Iterate */
DO:

  REPEAT WITH FRAME {&FRAME-NAME}:
    fiGeneration = fiGeneration + 1.
    RUN iterate.

    IF hasText() THEN 
    DO:
      fiGeneration:SCREEN-VALUE = STRING(fiGeneration).
      RUN showData.
      RETURN.
    END.

    IF ETIME > 1000 THEN DO:
      fiGeneration:SCREEN-VALUE = STRING(fiGeneration).
      ETIME(YES).
      PROCESS EVENTS.
    END.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  RUN enable_UI.
  RUN readData('2018-10.dat').

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fiGeneration edStars 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btnIterate fiGeneration edStars 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE iterate C-Win 
PROCEDURE iterate :
DEFINE BUFFER bStar FOR ttStar.

  FOR EACH bStar TABLE-SCAN:
    ASSIGN 
      bStar.iPosX = bStar.iPosX + bStar.iVelX
      bStar.iPosY = bStar.iPosY + bStar.iVelY.
  END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE readData C-Win 
PROCEDURE readData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER pcFile AS CHARACTER NO-UNDO.

  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  
  /* Data looks like:
  position=<-50310,  10306> velocity=< 5, -1>
  position=<-20029,  -9902> velocity=< 2,  1>
  position=< 10277, -30099> velocity=<-1,  3>
  */
  INPUT FROM value(pcFile).
  REPEAT:
    IMPORT UNFORMATTED cLine. 
    IF cLine = '' THEN LEAVE. 
    CREATE ttStar.
    ASSIGN 
      ttStar.iPosX = INTEGER(ENTRY(2,ENTRY(1,cLine),'<'))
      ttStar.iPosY = INTEGER(ENTRY(1,ENTRY(2,cLine),'>'))
      ttStar.iVelX = INTEGER(ENTRY(2,ENTRY(2,cLine),'<'))
      ttStar.iVelY = INTEGER(ENTRY(1,ENTRY(3,cLine),'>')).
  END.
  INPUT CLOSE. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE showData C-Win 
PROCEDURE showData :
/* show the data in a txt file 
*/
  DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iMinX AS INTEGER   NO-UNDO INITIAL  999999999.
  DEFINE VARIABLE iMaxX AS INTEGER   NO-UNDO INITIAL -999999999.
  DEFINE VARIABLE iMinY AS INTEGER   NO-UNDO INITIAL  999999999.
  DEFINE VARIABLE iMaxY AS INTEGER   NO-UNDO INITIAL -999999999.
  DEFINE VARIABLE xx    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE yy    AS INTEGER   NO-UNDO.

  DEFINE BUFFER bStar FOR ttStar.

  /* get min/max */
  FOR EACH bStar:
    iMinX = MINIMUM(iMinX,bStar.iPosX).
    iMaxX = MAXIMUM(iMaxX,bStar.iPosX).
    iMinY = MINIMUM(iMinY,bStar.iPosY).
    iMaxY = MAXIMUM(iMaxY,bStar.iPosY).
  END. 
  IF iMaxX - iMinX > 200 THEN LEAVE.

  OUTPUT TO "2018-10-visual.txt" APPEND.
  PUT UNFORMATTED 'Iteration: ' fiGeneration SKIP(1).

  DO yy = iMinY TO iMaxY:
    cLine = ''.

    DO xx = iMinX TO iMaxX:
      cLine = cLine + STRING(CAN-FIND(FIRST ttStar WHERE ttStar.iPosX = xx AND ttStar.iPosY = yy), '#/.').
    END.
    PUT UNFORMATTED cLine SKIP.
  END.

  PUT UNFORMATTED SKIP FILL('-',200) SKIP(1).
  OUTPUT CLOSE. 

  DO WITH FRAME {&FRAME-NAME}:
    edStars:READ-FILE('2018-10-visual.txt').
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION hasText C-Win 
FUNCTION hasText RETURNS LOGICAL
  ( ):

  DEFINE BUFFER bStar FOR ttStar.

  /* Assume that text has 4 adjacent positions */
  FOR EACH bStar:

    /* Horizontal or vertical */
    IF    CAN-FIND(ttStar WHERE ttStar.iPosX = bStar.iPosX + 1 AND ttStar.iPosY = bStar.iPosY)
      AND CAN-FIND(ttStar WHERE ttStar.iPosX = bStar.iPosX + 2 AND ttStar.iPosY = bStar.iPosY)
      AND CAN-FIND(ttStar WHERE ttStar.iPosX = bStar.iPosX + 3 AND ttStar.iPosY = bStar.iPosY) OR 
          CAN-FIND(ttStar WHERE ttStar.iPosX = bStar.iPosX     AND ttStar.iPosY = bStar.iPosY + 1)
      AND CAN-FIND(ttStar WHERE ttStar.iPosX = bStar.iPosX     AND ttStar.iPosY = bStar.iPosY + 2)
      AND CAN-FIND(ttStar WHERE ttStar.iPosX = bStar.iPosX     AND ttStar.iPosY = bStar.iPosY + 3) THEN RETURN TRUE. 

  END. 

  RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

