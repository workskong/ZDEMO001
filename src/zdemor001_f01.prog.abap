*&---------------------------------------------------------------------*
*& INCLUDE          ZFIR0002F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& FORM CREATE_CONTAINER
*&---------------------------------------------------------------------*
FORM create_container .

* CREATE OBJECT.
  CREATE OBJECT go_docking_con
    EXPORTING
      repid                       = sy-repid
      dynnr                       = sy-dynnr
      side                        = go_docking_con->dock_at_left
      extension                   = 5000
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

*  CREATE OBJECT GO_SPLITTER
*    EXPORTING
*      PARENT            = GO_DOCKING_CON
*      ROWS              = 3
*      COLUMNS           = 1
*    EXCEPTIONS
*      CNTL_ERROR        = 1
*      CNTL_SYSTEM_ERROR = 2
*      OTHERS            = 3.
*
*  IF SY-SUBRC <> 0.
*    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*  ENDIF.

*  CALL METHOD GO_SPLITTER->GET_CONTAINER
*    EXPORTING
*      ROW       = 2
*      COLUMN    = 1
*    RECEIVING
*      CONTAINER = GO_CONT2.   "HEADER.
*
*  CREATE OBJECT GO_DD_DOCUMENT.
*
  CREATE OBJECT go_grid
    EXPORTING
      i_parent          = go_docking_con "GO_CONT2
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

*  CALL METHOD GO_SPLITTER->GET_CONTAINER
*    EXPORTING
*      ROW       = 3
*      COLUMN    = 1
*    RECEIVING
*      CONTAINER = GO_CONT3.

*  CREATE OBJECT GO_GRID_0200
*    EXPORTING
*      I_PARENT          = GO_CONT3
*    EXCEPTIONS
*      ERROR_CNTL_CREATE = 1
*      ERROR_CNTL_INIT   = 2
*      ERROR_CNTL_LINK   = 3
*      ERROR_DP_CREATE   = 4
*      OTHERS            = 5.
*
*  IF SY-SUBRC <> 0.
*    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*  ENDIF.

** SET BOARDER
*  CALL METHOD GO_SPLITTER->SET_BORDER
*    EXPORTING
*      BORDER = SPACE.
*
** SET ALV HEIGHT
*  CALL METHOD GO_SPLITTER->SET_ROW_HEIGHT
*    EXPORTING
*      ID     = 1
*      HEIGHT = 5.
*
*  CALL METHOD GO_SPLITTER->SET_ROW_HEIGHT
*    EXPORTING
*      ID     = 2
*      HEIGHT = 95.

*  CALL METHOD GO_SPLITTER->SET_ROW_HEIGHT
*    EXPORTING
*      ID     = 3
*      HEIGHT = 50.

ENDFORM.
*&---------------------------------------------------------------------*
*&      FORM  TOOLBAR_PART_0100
*&---------------------------------------------------------------------*
FORM toolbar_part_0100 USING pv_ui_functions.

  FIELD-SYMBOLS: <lt_table> TYPE ui_functions.
  DATA:lv_table_name        LIKE feld-name.

  CONCATENATE pv_ui_functions gc_square INTO  lv_table_name.
  ASSIGN (lv_table_name) TO <lt_table>.

  PERFORM append_exclude_functions
        TABLES  <lt_table>
         USING : cl_gui_alv_grid=>mc_fc_loc_undo,
                 cl_gui_alv_grid=>mc_fc_detail,
                 cl_gui_alv_grid=>mc_fc_graph,
                 cl_gui_alv_grid=>mc_fc_info,
                 cl_gui_alv_grid=>mc_fc_loc_copy,
                 cl_gui_alv_grid=>mc_fc_loc_copy_row,
                 cl_gui_alv_grid=>mc_fc_loc_cut,
                 cl_gui_alv_grid=>mc_fc_loc_delete_row,
                 cl_gui_alv_grid=>mc_fc_loc_insert_row,
                 cl_gui_alv_grid=>mc_fc_loc_move_row,
                 cl_gui_alv_grid=>mc_fc_loc_append_row,
                 cl_gui_alv_grid=>mc_fc_loc_paste,
                 cl_gui_alv_grid=>mc_fc_loc_paste_new_row,
                 cl_gui_alv_grid=>mc_fc_maximum,
                 cl_gui_alv_grid=>mc_fc_minimum,
                 cl_gui_alv_grid=>mc_fc_print,
                 cl_gui_alv_grid=>mc_fc_print_back,
                 cl_gui_alv_grid=>mc_fc_print_prev,
                 cl_gui_alv_grid=>mc_fc_refresh,
                 cl_gui_alv_grid=>mc_fc_check.

ENDFORM.                    "TOOLBAR_PART_0100
*&---------------------------------------------------------------------*
*&      FORM  APPEND_EXCLUDE_FUNCTIONS
*&---------------------------------------------------------------------*
FORM append_exclude_functions TABLES pt_table
                               USING pv_value.

  DATA:lv_ui_func TYPE ui_func.

  lv_ui_func = pv_value.
  APPEND lv_ui_func TO pt_table.

ENDFORM.                    "APPEND_EXCLUDE_FUNCTIONS
*&---------------------------------------------------------------------*
*&      FORM  SET_LAYOUT_0100
*&---------------------------------------------------------------------*
FORM set_layout_0100 .

  gs_lvc_layo-cwidth_opt  = abap_true.
  gs_lvc_layo-zebra       = abap_true.
  gs_lvc_layo-edit_mode   = abap_true.
  gs_lvc_layo-sel_mode    = 'A'.
  gs_lvc_layo-box_fname   = 'MARK'.
*  GS_LVC_LAYO-GRID_TITLE  = TEXT-T03.

*  IF GV_EDIT = '1'.
*    CALL METHOD GO_GRID->SET_READY_FOR_INPUT
*      EXPORTING
*        I_READY_FOR_INPUT = 1.
*  ELSE.
*    CALL METHOD GO_GRID->SET_READY_FOR_INPUT
*      EXPORTING
*        I_READY_FOR_INPUT = 0.
*  ENDIF.

ENDFORM.                    "SET_LAYOUT_0100
*&---------------------------------------------------------------------*
*&      FORM  SET_FIELDCAT_0100
*&---------------------------------------------------------------------*
FORM set_fieldcat_0100 .

  DATA: lr_data     TYPE REF TO data,
        lr_tabdescr TYPE REF TO cl_abap_structdescr.

  CREATE DATA lr_data LIKE LINE OF gt_data.
  lr_tabdescr ?= cl_abap_structdescr=>describe_by_data_ref( lr_data ).
  DATA(lt_dfies) = cl_salv_data_descr=>read_structdescr( lr_tabdescr ).

  MOVE-CORRESPONDING lt_dfies TO gt_lvc_fcat.

*  LOOP AT GT_LVC_FCAT ASSIGNING <LS_FCAT>.
*    <LS_FCAT>-KEY = SPACE.
*    CASE <LS_FCAT>-FIELDNAME.
*      WHEN 'KTOPL'.
*        <LS_FCAT>-COLTEXT    = TEXT-F02.
*        <LS_FCAT>-COL_POS    = 1.
*
*      WHEN OTHERS.
*        <LS_FCAT>-TECH = ABAP_TRUE.
*    ENDCASE.
*  ENDLOOP.

ENDFORM.                    "SET_FIELDCAT_0100
*&---------------------------------------------------------------------*
*&      FORM  EVENT_REGISTER_0100
*&---------------------------------------------------------------------*
FORM event_register_0100 .

* EVENT HANDLER 등록
  CREATE OBJECT go_event_receiver.

  SET HANDLER :
   go_event_receiver->handle_data_changed  FOR go_grid,
   go_event_receiver->handle_double_click  FOR go_grid,
  "GO_EVENT_RECEIVER->HANDLE_TOOLBAR       FOR GO_GRID,
  "GO_EVENT_RECEIVER->HANDLE_USER_COMMAND  FOR GO_GRID,
   go_event_receiver->handle_help_f4       FOR go_grid,
   go_event_receiver->handle_hotspot_click FOR go_grid.

* 데이터 변경시 DATA CHANGED 이벤트 호출
  CALL METHOD go_grid->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.

* 데이터 변경후 ENTER 입력시 DATA CHANGED 이벤트 호출
  CALL METHOD go_grid->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter.

ENDFORM.                    "EVENT_REGISTER_0100
*&---------------------------------------------------------------------*
*&      FORM  DOUBLE_CLICK
*&---------------------------------------------------------------------*
FORM double_click  USING    p_e_row     TYPE lvc_s_row
                            p_e_column  TYPE lvc_s_col.

*  READ TABLE GT_DATA INDEX P_E_ROW-INDEX.

*  IF SY-SUBRC EQ 0 AND P_E_COLUMN-FIELDNAME = 'ANLN1'.
*    SET PARAMETER ID 'AN1' FIELD GT_DATA-ANLN1.
*    SET PARAMETER ID 'AN2' FIELD GT_DATA-ANLN2.
*    SET PARAMETER ID 'BUK' FIELD P_BUKRS.
*    CALL TRANSACTION 'AS03' AND SKIP FIRST SCREEN.
*  ENDIF.

ENDFORM.                    " DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& FORM DATA_CHANGED
*&---------------------------------------------------------------------*
FORM data_changed   USING po_data_changed
                         TYPE REF TO cl_alv_changed_data_protocol.

*  DATA: LS_MOD_CELLS TYPE LVC_S_MODI,
*        LV_FIELD     TYPE STRING,
*        LV_FIELD2    TYPE STRING.
*
*  FIELD-SYMBOLS: <FS> TYPE ANY.
*
*  LOOP AT PO_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELLS.
*
*    CONCATENATE 'GT_DATA-' LS_MOD_CELLS-FIELDNAME INTO LV_FIELD.
*    LV_FIELD2 = LS_MOD_CELLS-FIELDNAME.
*    ASSIGN (LV_FIELD) TO <FS>.
*    IF SY-SUBRC = 0.
*      <FS> = LS_MOD_CELLS-VALUE.
*    ENDIF.
*
*    MODIFY GT_DATA INDEX LS_MOD_CELLS-ROW_ID TRANSPORTING (LV_FIELD2) .

  "CHECK INPUT VALUE
*    READ TABLE GT_DATA INDEX LS_MOD_CELLS-ROW_ID.
*    PERFORM CHECK_DATA USING ''.
*    MODIFY GT_DATA INDEX LS_MOD_CELLS-ROW_ID.

*    CLEAR GT_DATA.
*
*  ENDLOOP.
*
*  PERFORM REFRESH_TABLE_DISPLAY USING GO_GRID.

ENDFORM.
*&---------------------------------------------------------------------*
*&      FORM  HOTSPOT_CLICK_GRID
*&---------------------------------------------------------------------*
FORM hotspot_click_grid  USING  p_row TYPE lvc_s_row
                                p_col TYPE lvc_s_col
                                p_rowno.

*  DATA : LV_BUKRS TYPE BUKRS.
*
*  READ TABLE GT_DATA INDEX P_ROW-INDEX.
*  CHECK SY-SUBRC = 0.
*
*  LV_BUKRS = P_SBUKRS.
*
*  CHECK P_COL-FIELDNAME EQ 'SAKNR'.
*
*  PERFORM DYNPRO USING:  'X' 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001',
*                         ' ' 'BDC_OKCODE'                     '=ENTER',
*                         ' ' 'GLACCOUNT_SCREEN_KEY-SAKNR'     GT_DATA-SAKNR,
*                         ' ' 'GLACCOUNT_SCREEN_KEY-BUKRS'     LV_BUKRS.
*
*  PERFORM BDC_TRANSACTION USING 'FS03'.

ENDFORM.                    " HOTSPOT_CLICK_GRID
*&---------------------------------------------------------------------*
*& FORM HANDLE_HELP_F4
*&---------------------------------------------------------------------*
*& POSSIBLE ENTRY(F4기능) - CREDIT CONTROL AREA
*----------------------------------------------------------------------*
FORM handle_help_f4 USING p_sender
                              p_fieldname   TYPE lvc_fname
                              p_fieldvalue  TYPE lvc_value
                              ps_row_no     TYPE lvc_s_roid
                              pr_event_data TYPE REF TO cl_alv_event_data
                              pt_bad_cells  TYPE lvc_t_modi
                              p_display     TYPE char01.
*
*  DATA : LS_MODI TYPE LVC_S_MODI.
*  DATA : RETURN_TAB TYPE TABLE OF DDSHRETVAL WITH HEADER LINE.
*
*  FIELD-SYMBOLS <F4TAB> TYPE LVC_T_MODI.
*  ASSIGN PR_EVENT_DATA->M_DATA->* TO <F4TAB>.
*
*  CASE P_FIELDNAME.
*    WHEN 'KKBER'.
*      "MAKE LIST OF VALUES
*      CLEAR: GT_KKBER, GT_KKBER[].
*      READ TABLE GT_PAYMT INDEX PS_ROW_NO-ROW_ID.
*
*      SELECT B~KKBER INTO TABLE GT_KKBER
*        FROM UKMBP_CMS_SGM AS A INNER JOIN T001CM AS B
*          ON A~CREDIT_SGMNT = B~KKBER
*       WHERE A~PARTNER = GT_PAYMT-KUNNR
*         AND B~BUKRS   = P_BUKRS.
*
*      SORT GT_KKBER BY KKBER.
*      DELETE ADJACENT DUPLICATES FROM GT_KKBER COMPARING KKBER.
*
*      "DISPLAY LIST OF VALUES
*      CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*        EXPORTING
*          RETFIELD        = P_FIELDNAME
*          DYNPPROG        = SY-REPID
*          DYNPNR          = SY-DYNNR
*          WINDOW_TITLE    = TEXT-F22
*          VALUE_ORG       = 'S'
*        TABLES
*          VALUE_TAB       = GT_KKBER
*          RETURN_TAB      = RETURN_TAB
*        EXCEPTIONS
*          PARAMETER_ERROR = 1
*          NO_VALUES_FOUND = 2
*          OTHERS          = 3.
*
*      IF SY-SUBRC NE 0.
*        MESSAGE S422.
*        LEAVE LIST-PROCESSING.
*      ENDIF.
*
*      IF P_DISPLAY = '' AND
*         RETURN_TAB-FIELDVAL IS NOT INITIAL.
*        LS_MODI-ROW_ID    = PS_ROW_NO-ROW_ID.
*        LS_MODI-FIELDNAME = P_FIELDNAME.
*        LS_MODI-VALUE     = RETURN_TAB-FIELDVAL.
*        APPEND LS_MODI TO <F4TAB>.
*
**        READ TABLE GT_PERNR WITH KEY PERNR = RETURN_TAB-FIELDVAL
**                            BINARY SEARCH.
**        IF SY-SUBRC = 0.
**          LS_MODI-FIELDNAME = 'ENAME'.
**          LS_MODI-VALUE     = GT_PERNR-ENAME.
**          APPEND LS_MODI TO <F4TAB>.
**        ENDIF.
*      ENDIF.
*
*      PR_EVENT_DATA->M_EVENT_HANDLED = 'X'.
*
*  ENDCASE.
*
** REPORT DATA REFRESH
*  PERFORM REFRESH_TABLE_DISPLAY USING GO_GRID4
*                                      GS_LVC_LAYO3.

ENDFORM.
*&---------------------------------------------------------------------*
*&      FORM  SET_ALV_SORT_0100
*&---------------------------------------------------------------------*
FORM set_alv_sort_0100 .

*  CLEAR GS_LVC_SORT.
*  GS_LVC_SORT-FIELDNAME  = 'BUNIT'.
*  GS_LVC_SORT-SPOS       = 1.
*  GS_LVC_SORT-UP         = ABAP_TRUE.
*  GS_LVC_SORT-SUBTOT     = ABAP_TRUE.
*  APPEND GS_LVC_SORT TO GT_LVC_SORT.

ENDFORM.                    "SET_ALV_SORT_0100
*&---------------------------------------------------------------------*
*&      FORM  TOP_OF_PAGE_0100
*&---------------------------------------------------------------------*
FORM top_of_page_0100 .

  DATA : lt_header TYPE slis_t_listheader WITH HEADER LINE.

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1
      column    = 1
    RECEIVING
      container = go_cont1.

  CREATE OBJECT go_html_viewer
    EXPORTING
      parent = go_cont1.

  CREATE OBJECT go_dd_document.

  CALL METHOD go_dd_document->initialize_document.

  PERFORM make_header TABLES lt_header.

  EXPORT it_list_commentary FROM lt_header
         TO MEMORY ID gc_dyndos_for_alv.

  CALL METHOD go_splitter->set_row_height
    EXPORTING
      id                = 1
      height            = 6
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.

  CALL FUNCTION 'REUSE_ALV_GRID_COMMENTARY_SET'
    EXPORTING
      document = go_dd_document
      bottom   = space.

* GET READY
  CALL METHOD go_dd_document->merge_document.

* CONNECT TOP DOCUMENT TO HTML-CONTROL
  go_dd_document->html_control = go_html_viewer.

  CALL METHOD go_dd_document->display_document
    EXPORTING
      reuse_control      = abap_true
      parent             = go_cont1
    EXCEPTIONS
      html_display_error = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    "TOP_OF_PAGE_0100
*&---------------------------------------------------------------------*
*&      FORM  MAKE_HEADER
*&---------------------------------------------------------------------*
FORM make_header  TABLES pt_header TYPE slis_t_listheader.

  DATA : lv_text  TYPE slis_entry.

** FISCAL YEAR / MONTH
*  CLEAR LV_TEXT.
*  CONCATENATE P_YEAR P_POPER+1(2) INTO LV_TEXT SEPARATED BY '/'.
*  PERFORM HEADER_SETTING TABLES PT_HEADER
*                         USING  'S' TEXT-T01 LV_TEXT.

ENDFORM.                    "MAKE_HEADER
*&---------------------------------------------------------------------*
*&      FORM  HEADER_SETTING
*&---------------------------------------------------------------------*
FORM header_setting  TABLES pt_header TYPE slis_t_listheader
                     USING  pv_typ pv_key pv_info.

  DATA : ls_header TYPE slis_listheader.

  MOVE   pv_typ     TO ls_header-typ.
  MOVE   pv_key     TO ls_header-key.
  MOVE   pv_info    TO ls_header-info.
  APPEND ls_header  TO pt_header.

ENDFORM.                    "HEADER_SETTING
*&---------------------------------------------------------------------*
*&      FORM  ALV_DISPLAY_PART_0100
*&---------------------------------------------------------------------*
FORM alv_display_part_0100 .

  CALL METHOD go_grid->set_table_for_first_display
    EXPORTING
*     I_BUFFER_ACTIVE               =
*     I_BYPASSING_BUFFER            =
*     I_CONSISTENCY_CHECK           =
*     I_STRUCTURE_NAME              =
*     IS_VARIANT                    =
      i_save                        = gv_save
      i_default                     = abap_true
      is_layout                     = gs_lvc_layo
*     IS_PRINT                      =
*     IT_SPECIAL_GROUPS             =
      it_toolbar_excluding          = gt_ui_functions
*     IT_HYPERLINK                  =
*     IT_ALV_GRAPHICS               =
*     IT_EXCEPT_QINFO               =
*     IR_SALV_ADAPTER               =
    CHANGING
      it_outtab                     = gt_data[]
      it_fieldcatalog               = gt_lvc_fcat
      it_sort                       = gt_lvc_sort[]
*     IT_FILTER                     =
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    "ALV_DISPLAY_PART_0100
*&---------------------------------------------------------------------*
*& FORM SET_TOOBAR
*&---------------------------------------------------------------------*
FORM set_toobar  USING  p_object TYPE REF TO cl_alv_event_toolbar_set
                        p_interactive TYPE c.

*  DATA: LS_TOOLBAR TYPE STB_BUTTON.
*
** EDIT BTN
*  PERFORM SET_TOOLBAR1 USING 0 'EDIT' ICON_TOGGLE_DISPLAY_CHANGE
*                             TEXT-T03
*                    CHANGING LS_TOOLBAR.
*
*  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.
*
** SAVE BTN
*  PERFORM SET_TOOLBAR1 USING 0 'SAVE' ICON_SYSTEM_SAVE TEXT-T04
*                    CHANGING LS_TOOLBAR.
*
*  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.
*
** |
*  PERFORM SET_TOOLBAR1 USING 3 '' '' ''
*                    CHANGING LS_TOOLBAR.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM SET_TOOLBAR1
*&---------------------------------------------------------------------*
FORM set_toolbar1   USING p_btype p_func p_icon p_text
                 CHANGING ps_toolbar   TYPE stb_button.

  CLEAR ps_toolbar.
  MOVE p_btype TO ps_toolbar-butn_type.
  MOVE p_func  TO ps_toolbar-function.

  IF p_btype = 0.
    MOVE p_icon TO ps_toolbar-icon.
    MOVE p_text TO ps_toolbar-text.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM USER_COMMAND_PART
*&---------------------------------------------------------------------*
FORM user_command_part  USING p_ucomm.

*  CASE SY-DYNNR.
*    WHEN '0100'.
*      PERFORM SELECT_DESELECT_ROWS USING P_UCOMM 'GT_DATA[]' GO_GRID.
*
*    WHEN '0200'.
*      PERFORM SELECT_DESELECT_ROWS USING P_UCOMM 'GT_CLEAR[]' GO_GRID2.
*
*    WHEN '0220'.
*      CASE P_UCOMM.
*        WHEN 'DELR' OR 'INSR'.
*          CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE
*            EXPORTING
*              NEW_CODE = P_UCOMM.
*      ENDCASE.
*
*    WHEN '0300'.
*      CASE P_UCOMM.
*        WHEN 'INSR'.
*          PERFORM INSERT_LINE_0300.
*        WHEN 'DELR'.
*          PERFORM DELETE_LINE_0300.
*      ENDCASE.
*
*      PERFORM REFRESH_TABLE_DISPLAY USING GO_GRID4
*                                          GS_LVC_LAYO3.
*  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM REFRESH_TABLE_DISPLAY
*&---------------------------------------------------------------------*
FORM refresh_table_display USING p_grid TYPE REF TO cl_gui_alv_grid.

* REFRESH GRID
  gs_stab-row = abap_true.
  gs_stab-col = abap_true.

  CALL METHOD p_grid->refresh_table_display
    EXPORTING
      i_soft_refresh = abap_true
      is_stable      = gs_stab
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.

ENDFORM.
*&---------------------------------------------------------------------*
*&      FORM  CONVERSION_INPUT
*&---------------------------------------------------------------------*
FORM conversion_input  CHANGING p_value.

  IF p_value NE space.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = p_value
      IMPORTING
        output = p_value.
  ENDIF.

ENDFORM.                    "CONVERSION_INPUT
*&---------------------------------------------------------------------*
*& FORM DYNPRO
*&---------------------------------------------------------------------*
FORM dynpro USING p_dynbegin
                       p_name
                       p_value.

*  DATA: LS_BDCDATA TYPE BDCDATA.
*
*  IF P_DYNBEGIN = ABAP_TRUE.
*    MOVE: P_NAME  TO LS_BDCDATA-PROGRAM,
*          P_VALUE TO LS_BDCDATA-DYNPRO,
*          ABAP_TRUE     TO LS_BDCDATA-DYNBEGIN.
*    APPEND LS_BDCDATA TO GT_BDCDATA.
*
*  ELSE.
*    MOVE: P_NAME  TO LS_BDCDATA-FNAM,
*          P_VALUE TO LS_BDCDATA-FVAL.
*    APPEND LS_BDCDATA TO GT_BDCDATA.
*  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM BDC_TRANSACTION
*&---------------------------------------------------------------------*
FORM bdc_transaction  USING lp_tcode.

*  DATA : L_OPTION  TYPE CTU_PARAMS.
*
*  L_OPTION-DISMODE  = 'E'.
*  L_OPTION-UPDMODE  = 'S'.
*  L_OPTION-CATTMODE = SPACE.
*  L_OPTION-DEFSIZE  = SPACE.
**  L_OPTION-RACOMMIT = ABAP_TRUE.
*  L_OPTION-NOBINPT  = ABAP_TRUE.
**  L_OPTION-NOBIEND  = SPACE.
*
*  CALL TRANSACTION LP_TCODE USING GT_BDCDATA
*                     OPTIONS FROM L_OPTION
*                    MESSAGES INTO GT_MESSAGE.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM CHECK_AUTHORITY
*&---------------------------------------------------------------------*
FORM check_authority.


ENDFORM.
*&---------------------------------------------------------------------*
*& FORM CHECK_INPUT_DATA
*&---------------------------------------------------------------------*
FORM check_input_data .

*   IF P_SBUKRS IS INITIAL.
*     MESSAGE S008 WITH TEXT-F03 DISPLAY LIKE 'E'.
*     LEAVE LIST-PROCESSING.
*   ENDIF.
*   IF P_TBUKRS IS INITIAL.
*     MESSAGE S008 WITH TEXT-F04 DISPLAY LIKE 'E'.
*     LEAVE LIST-PROCESSING.
*   ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_A1
*&---------------------------------------------------------------------*
FORM get_data_a1.

  SELECT
      f~carrid     AS carrierid,
      f~connid     AS connectionid,
      b~fldate     AS flightdate,
      b~bookid     AS bookid,
      b~customid   AS customerid,
      b~custtype   AS customertype,
      b~smoker     AS smoker,
      b~luggweight AS luggageweight,
      b~wunit      AS weightunit,
      b~invoice    AS invoiceid,
      b~class      AS class,
      b~forcuram   AS foreigncurrencyamount,
      b~forcurkey  AS foreigncurrencycode ,
      b~loccuram   AS localcurrencyamount,
      b~loccurkey  AS localcurrencycode ,
      b~order_date AS orderdate,
      b~counter    AS counter,
      b~agencynum  AS agencynumber,
      b~cancelled  AS cancelled,
      b~reserved   AS reserved,
      t~decan      AS decimalplaces,
      c~name       AS customername
      FROM sflight AS f
      LEFT OUTER JOIN sbook AS b ON b~carrid = f~carrid AND b~connid = f~connid AND b~fldate = f~fldate
      LEFT OUTER JOIN t006 AS t ON t~msehi = b~wunit
      LEFT OUTER JOIN scustom AS c ON c~id = b~customid "AND C~LANGU = @SY-LANGU
      WHERE f~carrid   IN @s_carri
        AND f~connid   IN @s_conne
        AND b~fldate   IN @s_fdate
        AND b~bookid   IN @s_booki
        AND b~customid IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  IF gt_data[] IS NOT INITIAL.
    SELECT DISTINCT
      waers,
      isocd
      FROM tcurc
      FOR ALL ENTRIES IN @gt_data
      WHERE waers = @gt_data-foreigncurrencycode
      INTO TABLE @DATA(lt_waers).

    SELECT DISTINCT
      waers,
      isocd
      FROM tcurc
      FOR ALL ENTRIES IN @gt_data
      WHERE waers = @gt_data-localcurrencycode
      APPENDING TABLE @lt_waers.

    SORT lt_waers BY waers.
    DELETE ADJACENT DUPLICATES FROM lt_waers COMPARING waers.
  ENDIF.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

    READ TABLE lt_waers INTO DATA(ls_waers) WITH KEY waers = <ls_data>-foreigncurrencycode BINARY SEARCH.
    IF sy-subrc = 0.
      <ls_data>-foreigncurrencyiso = ls_waers-isocd.
    ENDIF.
    READ TABLE lt_waers INTO ls_waers WITH KEY waers = <ls_data>-foreigncurrencycode BINARY SEARCH.
    IF sy-subrc = 0.
      <ls_data>-localcurrencyiso = ls_waers-isocd.
    ENDIF.

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_A1
*&---------------------------------------------------------------------*
FORM get_data_a2.

  SELECT
      *
      FROM zdemo_v004
     WHERE carrierid    IN @s_carri
       AND connectionid IN @s_conne
       AND flightdate   IN @s_fdate
       AND bookid       IN @s_booki
       AND customerid   IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_A1
*&---------------------------------------------------------------------*
FORM get_data_a3.

  SELECT
      *
      FROM zdemo_v003
     WHERE carrierid    IN @s_carri
       AND connectionid IN @s_conne
       AND flightdate   IN @s_fdate
       AND bookid       IN @s_booki
       AND customerid   IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  IF gt_data[] IS NOT INITIAL.
    SELECT DISTINCT
      waers,
      isocd
      FROM tcurc
      FOR ALL ENTRIES IN @gt_data
      WHERE waers = @gt_data-foreigncurrencycode
      INTO TABLE @DATA(lt_waers).

    SELECT DISTINCT
      waers,
      isocd
      FROM tcurc
      FOR ALL ENTRIES IN @gt_data
      WHERE waers = @gt_data-localcurrencycode
      APPENDING TABLE @lt_waers.

    SORT lt_waers BY waers.
    DELETE ADJACENT DUPLICATES FROM lt_waers COMPARING waers.
  ENDIF.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

    READ TABLE lt_waers INTO DATA(ls_waers) WITH KEY waers = <ls_data>-foreigncurrencycode BINARY SEARCH.
    IF sy-subrc = 0.
      <ls_data>-foreigncurrencyiso = ls_waers-isocd.
    ENDIF.
    READ TABLE lt_waers INTO ls_waers WITH KEY waers = <ls_data>-foreigncurrencycode BINARY SEARCH.
    IF sy-subrc = 0.
      <ls_data>-localcurrencyiso = ls_waers-isocd.
    ENDIF.

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_A4
*&---------------------------------------------------------------------*
FORM get_data_a4.

  SELECT
      carrierid,
      connectionid,
      flightdate,
      bookid,
      customerid,
      customertype,
      smoker,
      luggageweight,
      weightunit,
      invoiceid,
      class,
      foreigncurrencyamount,
      foreigncurrencycode,
      localcurrencyamount,
      localcurrencycode,
      orderdate,
      counter,
      agencynumber,
      cancelled,
      reserved,
      \_foreigncurrency[ (1) ]-isocd AS foreigncurrencyiso,
      \_localcurrency[ (1) ]-isocd AS localcurrencyiso,
      \_weightunit[ (1) ]-decan AS decimalplaces,
      \_customer[ (1) ]-name AS customername
      FROM s_bookings
     WHERE carrierid    IN @s_carri
       AND connectionid IN @s_conne
       AND flightdate   IN @s_fdate
       AND bookid       IN @s_booki
       AND customerid   IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_B1
*&---------------------------------------------------------------------*
FORM get_data_b1.

  SELECT
      carrierid,
      connectionid,
      flightdate,
      bookid,
      customerid,
      customertype,
      smoker,
      luggageweight,
      weightunit,
      invoiceid,
      class,
      foreigncurrencyamount,
      foreigncurrencycode ,
      foreigncurrencyiso ,
      localcurrencyamount,
      localcurrencycode ,
      localcurrencyiso ,
      orderdate,
      counter,
      agencynumber,
      cancelled,
      reserved,
      decimalplaces,
      customername
      FROM zdemo_ddl002
     WHERE carrierid    IN @s_carri
       AND connectionid IN @s_conne
       AND flightdate   IN @s_fdate
       AND bookid       IN @s_booki
       AND customerid   IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_B2
*&---------------------------------------------------------------------*
FORM get_data_b2.

  IF p_custo IS INITIAL.
    p_custo = '00002345'.
  ENDIF.

  SELECT
      carrierid,
      connectionid,
      flightdate,
      bookid,
      customerid,
      customertype,
      smoker,
      luggageweight,
      weightunit,
      invoiceid,
      class,
      foreigncurrencyamount,
      foreigncurrencycode ,
      foreigncurrencyiso ,
      localcurrencyamount,
      localcurrencycode ,
      localcurrencyiso ,
      orderdate,
      counter,
      agencynumber,
      cancelled,
      reserved,
      decimalplaces,
      customername
      FROM zdemo_ddl005( p_customerid = @p_custo )
     WHERE carrierid    IN @s_carri
       AND connectionid IN @s_conne
       AND flightdate   IN @s_fdate
       AND bookid       IN @s_booki
*       AND customerid   IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_B3
*&---------------------------------------------------------------------*
FORM get_data_b3.

  SELECT
      *
      FROM zdemo_ddl007
     WHERE carrierid    IN @s_carri
       AND connectionid IN @s_conne
       AND flightdate   IN @s_fdate
       AND bookid       IN @s_booki
       AND customerid   IN @s_custo
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM GET_DATA_B4
*&---------------------------------------------------------------------*
FORM get_data_b4.

  TYPES: BEGIN OF lty_s_input,
           customerid TYPE s_customer,
         END OF lty_s_input,
         lty_t_input TYPE TABLE OF lty_s_input.

  DATA(lt_customerid) = CORRESPONDING lty_t_input( gt_data MAPPING customerid = customerid ).

  zdemo_cl_amdp001=>get_data(
    EXPORTING
      p_mandt       = sy-mandt
      it_customerid = lt_customerid
    IMPORTING
      et_data       = gt_data
  ).

  LOOP AT gt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

*    CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
*      EXPORTING
*        DATE             = SY-DATUM
*        FOREIGN_CURRENCY = <LS_DATA>-FOREIGNCURRENCYCODE
*        FOREIGN_AMOUNT   = <LS_DATA>-FOREIGNCURRENCYAMOUNT
*        LOCAL_CURRENCY   = 'KRW'
*      IMPORTING
*        LOCAL_AMOUNT     = <LS_DATA>-FOREIGNCURRENCYKRW
*      EXCEPTIONS
*        OTHERS           = 9.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM READ_DATA
*&---------------------------------------------------------------------*
FORM get_data .

  PERFORM get_data_a1.
  PERFORM get_data_a2.
  PERFORM get_data_a3.
  PERFORM get_data_a4.

  PERFORM get_data_b1.
  PERFORM get_data_b2.
  PERFORM get_data_b3.
  PERFORM get_data_b4.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM SET_SCREEN
*&---------------------------------------------------------------------*
FORM set_screen .

*  IF RB_3 = ABAP_TRUE.
*    SCREEN-ACTIVE = '1'.
*  ELSE.
*    SCREEN-ACTIVE = '0'.
*  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& FORM CHECK_COMPANY
*&---------------------------------------------------------------------*
FORM check_company  USING    p_value
                             VALUE(p_field)
                    CHANGING p_text.


ENDFORM.
