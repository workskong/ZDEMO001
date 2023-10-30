*&---------------------------------------------------------------------*
*& Include          ZPTEST001_C01
*&---------------------------------------------------------------------*
CLASS lcl_def_receiver DEFINITION DEFERRED.

DATA : go_event_receiver TYPE REF TO lcl_def_receiver.

*----------------------------------------------------------------------*
* LOCAL CLASSES: DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_def_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS : handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row
                e_column.

    METHODS : handle_toolbar
      FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING e_object
                e_interactive.

    METHODS : handle_user_command
      FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING e_ucomm.

    METHODS : handle_data_changed
      FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING er_data_changed  e_ucomm sender.

    METHODS : handle_hotspot_click
      FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING e_row_id e_column_id es_row_no.

    METHODS : handle_help_f4
      FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING sender e_fieldname e_fieldvalue es_row_no
                er_event_data et_bad_cells e_display.

ENDCLASS.                    "LCL_DEF_RECEIVER IMPLEMENTATION
*----------------------------------------------------------------------*
* LOCAL CLASSES: IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_def_receiver IMPLEMENTATION.

  METHOD handle_double_click.
    PERFORM double_click USING e_row e_column.
  ENDMETHOD.

  METHOD handle_toolbar.
    PERFORM set_toobar USING e_object e_interactive.
  ENDMETHOD.

  METHOD handle_user_command.
    PERFORM user_command_part USING e_ucomm.
  ENDMETHOD.

  METHOD handle_data_changed.
    PERFORM data_changed USING er_data_changed.
  ENDMETHOD.

  METHOD handle_hotspot_click.
    PERFORM hotspot_click_grid USING e_row_id
                                     e_column_id es_row_no.
  ENDMETHOD.

  METHOD handle_help_f4.
    PERFORM handle_help_f4 USING sender e_fieldname e_fieldvalue
                                     es_row_no er_event_data
                                     et_bad_cells e_display.
  ENDMETHOD.

ENDCLASS.  " LCL_DEF_RECEIVER
