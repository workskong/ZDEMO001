*&---------------------------------------------------------------------*
* Program ID  : ZDEMOR001                                              *
* T-code      :                                                        *
* Title       : Flight Bookings                                        *
* Created By  :                                                        *
* Created On  :                                                        *
* Description :                                                        *
*&---------------------------------------------------------------------*
* Change History                                                       *
*&---------------------------------------------------------------------*
*  #No   |Date      |Developer|Description (Reason)                    *
*&---------------------------------------------------------------------*
*  #1                                                                  *
*&---------------------------------------------------------------------*
*  #2                                                                  *
*&---------------------------------------------------------------------*
REPORT zdemor001 MESSAGE-ID ztestmsg NO STANDARD PAGE HEADING.

INCLUDE zdemor001_com.
INCLUDE zdemor001_top.
INCLUDE zdemor001_scr.
INCLUDE zdemor001_c01.
INCLUDE zdemor001_o01.
INCLUDE zdemor001_i01.
INCLUDE zdemor001_f01.

*----------------------------------------------------------------------*
* AT SELECTION-SCREEN OUTPUT
*----------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.
*  PERFORM set_screen.

*----------------------------------------------------------------------*
* AT SELECTION-SCREEN ON
*----------------------------------------------------------------------*
AT SELECTION-SCREEN ON p_smoke.
*  PERFORM check_company USING p_smoke  'P_SMOKE'  CHANGING p_butxt.

*----------------------------------------------------------------------*
* START-OF-SELECTION
*----------------------------------------------------------------------*
START-OF-SELECTION.
*  PERFORM check_input_data.
  PERFORM get_data.

*----------------------------------------------------------------------*
* END-OF-SELECTION
*----------------------------------------------------------------------*
END-OF-SELECTION.
  IF gt_data[] IS INITIAL.
    MESSAGE s000 WITH TEXT-m01 DISPLAY LIKE 'E'.
  ELSE.
    CALL SCREEN 0100.
  ENDIF.
