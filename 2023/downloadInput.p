/*------------------------------------------------------------------------
    File        : downloadInputFile.p
    Description : Download input file accordingly to day, year and session cookie of AdventOfCode
    Author(s)   : Wim van der Ham
    Created     : Mon Mar 06 13:02:40 BRT 2023
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
USING Progress.Lang.*.
USING OpenEdge.Core.*.
USING OpenEdge.Net.HTTP.*.
USING Progress.Json.ObjectModel.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */
DEFINE VARIABLE oRequest          AS IHttpRequest     NO-UNDO.
DEFINE VARIABLE oResponse         AS IHttpResponse    NO-UNDO.
DEFINE VARIABLE oCookie           AS Cookie           NO-UNDO.
DEFINE VARIABLE lcInput           AS LONGCHAR         NO-UNDO.
DEFINE VARIABLE cSession          AS CHARACTER        NO-UNDO.
DEFINE VARIABLE iYear             AS INTEGER          NO-UNDO.
DEFINE VARIABLE iDay              AS INTEGER          NO-UNDO.
DEFINE VARIABLE cURL              AS CHARACTER        NO-UNDO.
DEFINE VARIABLE cDir              AS CHARACTER        NO-UNDO.
DEFINE VARIABLE cFileName         AS CHARACTER        NO-UNDO.


/* ***************************  Main Block  *************************** */

ASSIGN 
  iYear    = YEAR (TODAY)
  iDay     = DAY (TODAY)
  cDir     = "c:\Data\DropBox\AdventOfCode\".
  cSession = "53616c7465645f5f7f3d6a51bcd05d0b2aa3a40c25c5f6ceca18b212b5bd6042f8c2bc5c070052fc5fd37580ca764c9de8dd6698bf91c5dfd48e5dd65e19415f".

IF MONTH (TODAY) LT 12 THEN 
DO:
  ASSIGN 
    iYear = iYear - 1
    iDay  = 1.
END.

REPEAT:
   UPDATE
     cDir     LABEL "Dir"        COLON 8 FORMAT "X(256)" VIEW-AS FILL-IN SIZE-CHARS 60 BY 1 SKIP
     cSession LABEL "Session"    COLON 8 FORMAT "X(256)" VIEW-AS FILL-IN SIZE-CHARS 60 BY 1 SKIP  
     iYear    LABEL "Year"       COLON 8 FORMAT "9999" SKIP 
     iDay     LABEL "Day "       COLON 8 FORMAT "z9"   SKIP (1)
     WITH SIDE-LABELS 1 DOWN FRAME fr-Parameters TITLE " Enter your Session, Output Dir and Select Year & Day " CENTERED ROW 3.
   
   cURL = SUBSTITUTE ("https://adventofcode.com/&1/day/&2/input", iYear, iDay).
   /* c:\Data\DropBox\AdventOfCode\2022\Day-01\data.txt  */
   cFileName = SUBSTITUTE ("&1\&2\Day-&3\data.txt", cDir, iYear, STRING(iDay, "99")).
   oCookie = Cookie:Parse(SUBSTITUTE ("session=&1", cSession)).
      
   oRequest = RequestBuilder:Get(cURL):AddCookie(oCookie):Request. 
   oResponse = ClientBuilder:Build():Client:Execute(oRequest).

   DISPLAY
     oResponse:StatusCode   LABEL "Reason" COLON 8 SKIP 
     oResponse:StatusReason LABEL "OK?"    FORMAT "X(40)" COLON 8 SKIP 
     WITH FRAME fr-Parameters.

   lcInput = CAST (oResponse:Entity, String):VALUE.
   
   COPY-LOB FROM lcInput TO FILE cFileName.
   
   /*
   OUTPUT TO VALUE(cFileName).
   PUT UNFORMATTED 
   RIGHT-TRIM (STRING (oResponse:Entity)) SKIP.
   OUTPUT CLOSE.
   */
   
   FILE-INFO:FILE-NAME = cFileName.
   IF FILE-INFO:FILE-TYPE EQ ? THEN 
   DO:
     MESSAGE SUBSTITUTE ("Couldn't find '&1' file.", cFileName) VIEW-AS ALERT-BOX.    
     RETURN.
   END. 
   
   IF iYear NE YEAR (TODAY) THEN 
     iDay = iDay + 1.   
END.

/* ---------------------------
Error (Press HELP to view stack trace)
---------------------------
Secure Socket Layer (SSL) failure. error code -54:  unable to get local issuer certificate: for f387163d.0 in c:\dlc12.2\certs (9318)
Connection failure for host adventofcode.com port 443 transport TCP. (9407)
---------------------------
OK   Help   
---------------------------

*/
