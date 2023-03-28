﻿       IDENTIFICATION DIVISION.

       PROGRAM-ID. TSQL001A.


       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
      * SOURCE-COMPUTER. IBM WITH DEBUGGING MODE.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

           EXEC SQL
             INCLUDE EMPREC
           END-EXEC.

           01 DATASRC PIC X(64).
           01 DBUSR  PIC X(64).
           01 DBPWD  PIC X(64).

           01 T1     PIC 9(3) VALUE 0.

           EXEC SQL
             INCLUDE SQLCA
           END-EXEC.

       PROCEDURE DIVISION.

       000-CONNECT.
           ACCEPT DATASRC FROM ENVIRONMENT 'DB1name'.
           ACCEPT DBUSR FROM ENVIRONMENT 'DB1role'.
           ACCEPT DBPWD FROM ENVIRONMENT 'DB1pswd'.

      D     DISPLAY '***************************************'.
      D     DISPLAY " DATASRC  : " DATASRC.
      D     DISPLAY " DBUSR    : " DBUSR.
      D     DISPLAY " DBPWD    : " DBPWD.
      D     DISPLAY '***************************************'.

           EXEC SQL
              CONNECT TO :DATASRC USER :DBUSR USING :DBPWD
           END-EXEC.

           DISPLAY 'CONNECT SQLCODE: ' SQLCODE

           IF SQLCODE <> 0 THEN
              GO TO 100-EXIT
           END-IF.

       100-MAIN.

      *     EXEC SQL
      *        START TRANSACTION
      *     END-EXEC.

           EXEC SQL
               SELECT COUNT(*) INTO :T1 FROM EMPTABLE
           END-EXEC.

           DISPLAY 'SELECT SQLCODE : ' SQLCODE.

           IF SQLCODE <> 0 THEN
              GO TO 100-EXIT
           END-IF.

           DISPLAY 'RES: ' T1.

           EXEC SQL CONNECT RESET END-EXEC.

       100-EXIT.
      *       STOP RUN.