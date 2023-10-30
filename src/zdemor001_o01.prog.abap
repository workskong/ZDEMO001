*&---------------------------------------------------------------------*
*& Include          ZPTEST001_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  DATA : lv_title TYPE string.

  lv_title = TEXT-t02.

  SET PF-STATUS 'S0100'.
  SET TITLEBAR  'T0100' WITH lv_title.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_ALV OUTPUT
*&---------------------------------------------------------------------*
MODULE set_alv OUTPUT.

  IF go_docking_con IS INITIAL.
    PERFORM create_container.

    PERFORM toolbar_part_0100 USING gc_gt_ui_functions.

    PERFORM set_layout_0100.

    PERFORM set_fieldcat_0100.

    PERFORM event_register_0100.

    PERFORM set_alv_sort_0100.

*    PERFORM TOP_OF_PAGE_0100.

    PERFORM alv_display_part_0100.
  ENDIF.

ENDMODULE.
