*&---------------------------------------------------------------------*
*& Include ZPTEST001_COM
*&---------------------------------------------------------------------*
TYPE-POOLS:slis.

************************************************************************
* Constants
************************************************************************
CONSTANTS:gc_status_set       TYPE slis_formname VALUE 'PF_STATUS_SET',
          gc_user_command     TYPE slis_formname VALUE 'USER_COMMAND',
          gc_top_of_page      TYPE slis_formname VALUE 'TOP_OF_PAGE',
          gc_top_of_list      TYPE slis_formname VALUE 'TOP_OF_LIST',
          gc_end_of_list      TYPE slis_formname VALUE 'END_OF_LIST',
          gc_data_changed     TYPE slis_formname VALUE 'DATA_CHANGED',
          gc_html_top_of_page
                          TYPE slis_formname VALUE 'HTML_TOP_OF_PAGE',
          gc_prt_top_of_page
                          TYPE slis_formname VALUE 'PRT_TOP_OF_PAGE',
          gc_false            TYPE c LENGTH 1 VALUE space, "false value
          gc_true             TYPE c LENGTH 1 VALUE 'X',   "true value
          gc_square           TYPE c LENGTH 2 VALUE '[]',  "square bracket
          gc_disp_mode        TYPE c LENGTH 4 VALUE 'DISP', "display mode
          gc_chan_mode        TYPE c LENGTH 4 VALUE 'CHAN', "change mode
          gc_crea_mode        TYPE c LENGTH 4 VALUE 'CREA', "create mode
          gc_edit_mode        TYPE c LENGTH 4 VALUE 'EDIT', "edit mode
          gc_report           TYPE c LENGTH 6 VALUE 'REPORT', "ALV value
          gc_f_col            TYPE c LENGTH 5 VALUE 'F_COL',  "ALV value
          gc_celltab          TYPE c LENGTH 7 VALUE 'CELLTAB', "ALV Value
          gc_gs_lvc_sort      TYPE c LENGTH 12 VALUE 'GS_LVC_SORT-',
          gc_gt_ui_functions
                           TYPE c LENGTH 15 VALUE 'GT_UI_FUNCTIONS',
          gc_gt_ui_functions1
                           TYPE c LENGTH 16 VALUE 'GT_UI_FUNCTIONS1',
          gc_gt_ui_functions2
                           TYPE c LENGTH 16 VALUE 'GT_UI_FUNCTIONS2',
          gc_rfsh             TYPE sy-ucomm VALUE 'RFSH', "Refresh
          gc_crea             TYPE sy-ucomm VALUE 'CREA', "Create
          gc_chan             TYPE sy-ucomm VALUE 'CHAN', "Change
          gc_disp             TYPE sy-ucomm VALUE 'DISP', "Display
          gc_dele             TYPE sy-ucomm VALUE 'DELE', "Delete
          gc_canc             TYPE sy-ucomm VALUE 'CANC', "Cancle
          gc_back             TYPE sy-ucomm VALUE 'BACK', "Back
          gc_exit             TYPE sy-ucomm VALUE 'EXIT', "Exit
          gc_save             TYPE sy-ucomm VALUE 'SAVE', "Save
          gc_post             TYPE sy-ucomm VALUE 'POST', "Posting
          gc_reve             TYPE sy-ucomm VALUE 'REVE', "Reversed
          gc_simu             TYPE sy-ucomm VALUE 'SIMU', "Simulate
          gc_prnt             TYPE sy-ucomm VALUE 'PRNT', "Print
          gc_prev             TYPE sy-ucomm VALUE 'PREV', "Preview
          gc_prin             TYPE sy-ucomm VALUE 'PRIN', "Print
          gc_hist             TYPE sy-ucomm VALUE 'HIST', "History
          gc_cancel           TYPE sy-ucomm VALUE 'CANCEL', "cancel
          gc_edit             TYPE sy-ucomm VALUE 'EDIT',  "edit

          gc_box_fieldname
                  TYPE slis_layout_alv-box_fieldname VALUE 'CHECK',
          gc_selx             TYPE c LENGTH 4 VALUE 'SELX'.

CONSTANTS : gc_sel_mode_a TYPE c VALUE 'A'.
CONSTANTS : gc_dyndos_for_alv TYPE c LENGTH 14 VALUE 'DYNDOS_FOR_ALV'.

************************************************************************
* Global Variable
************************************************************************
DATA:gv_save                  TYPE c,
     gv_fld_name(30),
     gv_exit_caused_by_caller,
     gv_repid                 TYPE sy-repid,
     gv_program_name          LIKE sy-repid,
     gv_inclname              LIKE trdir-name,
     gv_okcode                TYPE sy-ucomm,
     gv_tabix                 TYPE sy-tabix,
     gv_save_okcode           TYPE sy-ucomm,
     gv_result                TYPE c,
     gv_changed               TYPE c,
     gv_init_flag             TYPE c.

*Structures
DATA:gs_layout              TYPE slis_layout_alv,
     gs_exit_caused_by_user TYPE slis_exit_by_user,
     gs_fieldcat            TYPE slis_fieldcat_alv,
     gs_sort                TYPE slis_sortinfo_alv,
     gs_keyinfo             TYPE slis_keyinfo_alv,
     gs_variant             TYPE disvariant, "variant
     gs_variant2            TYPE disvariant, "variant
     gs_variant3            TYPE disvariant, "variant
     gs_variant4th          TYPE disvariant, "variant
     gs_scroll              TYPE slis_list_scroll,
     gs_detail_func         LIKE dd02l-tabname.

DATA:gs_lvc_layo  TYPE lvc_s_layo, "Layout
     gs_lvc_layo1 TYPE lvc_s_layo,
     gs_lvc_layo2 TYPE lvc_s_layo,
     gs_lvc_layo3 TYPE lvc_s_layo,
     gs_lvc_layo4 TYPE lvc_s_layo.

DATA:gs_lvc_fcat  TYPE lvc_s_fcat, " Fieldcatalog
     gs_lvc_fcat2 TYPE lvc_s_fcat,
     gs_lvc_fcat3 TYPE lvc_s_fcat,
     gs_lvc_fcat4 TYPE lvc_s_fcat.

*Internal tables
DATA:gt_events      TYPE slis_t_event,
     gt_listheader  TYPE slis_t_listheader,
     gt_fieldcat    TYPE slis_t_fieldcat_alv,
     gt_slis_seltab TYPE slis_selfield,
     gt_sort        TYPE slis_t_sortinfo_alv,
     gt_exit        TYPE slis_event_exit OCCURS 0,
     gt_print       TYPE slis_print_alv.

DATA:gt_ui_functions  TYPE ui_functions, "ToolBar
     gt_ui_functions1 TYPE ui_functions,
     gt_ui_functions2 TYPE ui_functions,
     gt_ui_functions3 TYPE ui_functions,
     gt_ui_functions4 TYPE ui_functions.

DATA:gt_lvc_sort  TYPE lvc_t_sort WITH HEADER LINE, "Sort
     gt_lvc_sort1 TYPE lvc_t_sort WITH HEADER LINE,
     gt_lvc_sort2 TYPE lvc_t_sort WITH HEADER LINE,
     gt_lvc_sort3 TYPE lvc_t_sort WITH HEADER LINE,
     gt_lvc_sort4 TYPE lvc_t_sort WITH HEADER LINE.

DATA:gs_lvc_sort        TYPE lvc_s_sort.

DATA:gt_lvc_fcat  TYPE lvc_t_fcat, "Fieldcatalog
     gt_lvc_fcat1 TYPE lvc_t_fcat,
     gt_lvc_fcat2 TYPE lvc_t_fcat,
     gt_lvc_fcat3 TYPE lvc_t_fcat,
     gt_lvc_fcat4 TYPE lvc_t_fcat.

************************************************************************
* Field Symbols
************************************************************************
FIELD-SYMBOLS:<gv_field>.
FIELD-SYMBOLS:<gt_table> TYPE ANY TABLE.

************************************************************************
* Refresh 관련
************************************************************************
DATA:gs_stab         TYPE lvc_s_stbl.

************************************************************************
* Drop-Down List Box 관련
************************************************************************
DATA:gt_lvc_drop TYPE lvc_t_drop,
     gs_lvc_drop TYPE lvc_s_drop.

************************************************************************
* Column Color 관련
************************************************************************
DATA:gt_color TYPE lvc_t_scol WITH HEADER LINE,
     gs_color TYPE lvc_s_colo.

************************************************************************
* 선택된 ROW 관련
************************************************************************
DATA:gt_rows   TYPE lvc_t_row,
     gs_rows   TYPE lvc_s_row,
     gt_row_id TYPE lvc_t_roid,
     gs_row_id TYPE lvc_s_roid.

CONSTANTS:gc_fun TYPE c LENGTH 1 VALUE 'D'.

************************************************************************
* TREE 관련
************************************************************************
*Types
TYPES:gty_mtreeitm LIKE STANDARD TABLE OF mtreeitm WITH DEFAULT KEY.

*Global Variable
DATA:gv_return_code TYPE i,
     gv_handle_tree TYPE i.

DATA:gv_node_key(12) TYPE n.

CONSTANTS:gc_root    TYPE c LENGTH 12 VALUE '000000000000',
          gc_node_id TYPE tv_nodekey VALUE '1'.

DATA:gv_syntax.

*Internal tables
DATA:gt_node  TYPE treev_ntab,
     gt_item  TYPE gty_mtreeitm,
     gt_node2 TYPE treev_ntab,
     gt_item2 TYPE gty_mtreeitm,
     gt_node3 TYPE treev_ntab,
     gt_item3 TYPE gty_mtreeitm,
     gt_node4 TYPE treev_ntab,
     gt_item4 TYPE gty_mtreeitm.

DATA:gt_code        TYPE TABLE OF rssource-line,
     gt_tree_button TYPE ttb_button,
     gt_text(6000)  OCCURS 1 WITH HEADER LINE,
     gt_tab(72)     OCCURS 0 WITH HEADER LINE.

************************************************************************
* F4 Possible Entry
************************************************************************
*Structures
DATA:gs_f4_value TYPE seahlpres,
     gs_f4_field TYPE dfies,
     gs_f4       TYPE ddshretval,
     gs_lvc_modi TYPE lvc_s_modi,
     gs_lvc_f4   TYPE lvc_s_f4,
     gs_lvc_f4_2 TYPE lvc_s_f4.

*Internal tables
DATA:gt_f4_values TYPE TABLE OF seahlpres,
     gt_f4_fields TYPE TABLE OF dfies,
     gt_lvc_f4    TYPE lvc_t_f4,
     gt_lvc_f4_2  TYPE lvc_t_f4.

*Possible Entry Header TEXT
DATA:gt_field_tab LIKE dfies OCCURS 0 WITH HEADER LINE.

*Field Symbols
FIELD-SYMBOLS:<gv_f4tab> TYPE lvc_t_modi.
FIELD-SYMBOLS:<gv_row1> TYPE lvc_s_roid,
              <gv_row2> TYPE lvc_s_roid.

************************************************************************
* The Declaration of Variables
************************************************************************
*Control관련 데이타 선언

*Reference to custom container: neccessary to bind ALV Control
DATA:gv_cc_0100           TYPE scrfname VALUE 'CC_0100',
     gv_cc_0200           TYPE scrfname VALUE 'CC_0200',
     gv_cc_0300           TYPE scrfname VALUE 'CC_0300',
     gv_cc_0400           TYPE scrfname VALUE 'CC_0400',

     go_container_0100    TYPE REF TO cl_gui_custom_container,
     go_container_0200    TYPE REF TO cl_gui_custom_container,
     go_container_0300    TYPE REF TO cl_gui_custom_container,
     go_container_0400    TYPE REF TO cl_gui_custom_container,

     go_grid              TYPE REF TO cl_gui_alv_grid,
     go_grid2             TYPE REF TO cl_gui_alv_grid,
     go_grid3             TYPE REF TO cl_gui_alv_grid,
     go_grid4             TYPE REF TO cl_gui_alv_grid,
     go_grid_0100         TYPE REF TO cl_gui_alv_grid,
     go_grid_0200         TYPE REF TO cl_gui_alv_grid,
     go_grid_0300         TYPE REF TO cl_gui_alv_grid,
     go_grid_0400         TYPE REF TO cl_gui_alv_grid,

     go_splitter0         TYPE REF TO cl_gui_easy_splitter_container,
     go_splitter          TYPE REF TO cl_gui_splitter_container,
     go_splitter1         TYPE REF TO cl_gui_splitter_container,
     go_splitter2         TYPE REF TO cl_gui_splitter_container,
     go_splitter3         TYPE REF TO cl_gui_splitter_container,
     go_splitter4         TYPE REF TO cl_gui_splitter_container,

     go_dialog_container  TYPE REF TO cl_gui_dialogbox_container,
     go_dialog_container1 TYPE REF TO cl_gui_dialogbox_container,
     go_dialog_container3 TYPE REF TO cl_gui_dialogbox_container,
     go_dialog_container4 TYPE REF TO cl_gui_dialogbox_container,

     go_docking_con       TYPE REF TO cl_gui_docking_container,
     go_docking_con1      TYPE REF TO cl_gui_docking_container,
     go_docking_con2      TYPE REF TO cl_gui_docking_container,
     go_docking_con3      TYPE REF TO cl_gui_docking_container,
     go_docking_con4      TYPE REF TO cl_gui_docking_container,

     go_cont              TYPE REF TO cl_gui_container,
     go_cont1             TYPE REF TO cl_gui_container,
     go_cont2             TYPE REF TO cl_gui_container,
     go_cont3             TYPE REF TO cl_gui_container,
     go_cont4             TYPE REF TO cl_gui_container,

     go_column_tree       TYPE REF TO cl_gui_column_tree,
     go_tree              TYPE REF TO cl_gui_alv_tree,
     go_toolbar           TYPE REF TO cl_gui_toolbar,
     go_textedit          TYPE REF TO cl_gui_textedit.

************************************************************************
* TOP OF PAGE of Variables
************************************************************************
DATA: go_html_viewer TYPE REF TO cl_gui_html_viewer,
      go_dd_document TYPE REF TO cl_dd_document.
