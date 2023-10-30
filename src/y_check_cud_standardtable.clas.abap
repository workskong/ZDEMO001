class Y_CHECK_CUD_STANDARDTABLE definition
  public
  inheriting from Y_CHECK_BASE
  create public .

public section.

  methods CONSTRUCTOR .
  PROTECTED SECTION.
    METHODS inspect_tokens REDEFINITION.

  PRIVATE SECTION.
    DATA branch_counter TYPE i VALUE 0.
    DATA found_statement TYPE abap_bool VALUE abap_false.
    CONSTANTS first_if TYPE i VALUE 1.

    METHODS set_found_statement_to_true.
    METHODS set_found_statement_to_false.

    METHODS begin_of_statement
      IMPORTING statement TYPE sstmnt.

    METHODS branch_search_in_next_stmnt
      IMPORTING index     TYPE i
                statement TYPE sstmnt.

    METHODS get_first_token_from_index
      IMPORTING index         TYPE i
      RETURNING VALUE(result) TYPE stokesx.

    METHODS is_statement_type_excluded
      IMPORTING statement     TYPE sstmnt
      RETURNING VALUE(result) TYPE abap_bool.
ENDCLASS.



CLASS Y_CHECK_CUD_STANDARDTABLE IMPLEMENTATION.


  METHOD BEGIN_OF_STATEMENT.
    CASE get_first_token_from_index( statement-from )-str.
      WHEN 'IF'.
        branch_counter = branch_counter + 1.

      WHEN 'ENDIF'.
        branch_counter = branch_counter - 1.

      WHEN 'ELSEIF' OR 'ELSE'.
        found_statement = abap_false.

      WHEN OTHERS.
        found_statement = abap_true.
    ENDCASE.
  ENDMETHOD.


  METHOD BRANCH_SEARCH_IN_NEXT_STMNT.
    CHECK branch_counter = first_if AND found_statement = abap_false.

    CASE get_first_token_from_index( statement-to + 1 )-str.
      WHEN 'ELSEIF'
        OR 'ELSE'
        OR 'ENDIF'.

        DATA(check_configuration) = detect_check_configuration( statement_wa ).

        raise_error( statement_level = statement_wa-level
                     statement_index = index
                     statement_from = statement_wa-from
                     check_configuration  = check_configuration ).
    ENDCASE.
  ENDMETHOD.


  METHOD CONSTRUCTOR.
    super->constructor( ).

    settings-pseudo_comment = '"#EC EMPTY_IF_BRANCH' ##NO_TEXT.
    settings-disable_threshold_selection = abap_true.
    settings-threshold = 0.
*    settings-documentation = |{ c_docs_path-checks }empty-if-branches.md|.

    relevant_statement_types = VALUE #( ( scan_struc_stmnt_type-if ) ).
    relevant_structure_types = VALUE #( (  ) ).

    set_check_message( 'Do not delete this Table' ).
  ENDMETHOD.


  METHOD GET_FIRST_TOKEN_FROM_INDEX.
    LOOP AT ref_scan->tokens ASSIGNING FIELD-SYMBOL(<token>)
    FROM index
    WHERE type = 'I'.
      IF result IS INITIAL.
        result = <token>.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD INSPECT_TOKENS.
    CHECK is_statement_type_excluded( statement ) = abap_false.
    statement_wa = statement.
    begin_of_statement( statement ).

    set_found_statement_to_true( ).
    branch_search_in_next_stmnt( index = index
                                 statement = statement ).
    set_found_statement_to_false( ).
  ENDMETHOD.


  METHOD IS_STATEMENT_TYPE_EXCLUDED.
    result = xsdbool( statement-type = scan_stmnt_type-empty OR
                      statement-type = scan_stmnt_type-comment OR
                      statement-type = scan_stmnt_type-comment_in_stmnt OR
                      statement-type = scan_stmnt_type-pragma ).
  ENDMETHOD.


  METHOD SET_FOUND_STATEMENT_TO_FALSE.
    IF branch_counter < first_if.
      found_statement = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD SET_FOUND_STATEMENT_TO_TRUE.
    IF branch_counter > first_if.
      found_statement = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
