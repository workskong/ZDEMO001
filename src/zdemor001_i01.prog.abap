*&---------------------------------------------------------------------*
*& Include          ZPTEST001_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
MODULE exit INPUT.

  CASE sy-ucomm.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EIXT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  gv_ucomm = sy-ucomm.
  CLEAR sy-ucomm.

  CASE gv_ucomm.
    WHEN ''.

  ENDCASE.

ENDMODULE.
