*&---------------------------------------------------------------------*
*& Report ZDEMOR003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemor003.

*PERFORM rule1.
*PERFORM rule2.
PERFORM rule3.
*PERFORM rule4.
*PERFORM rule5.

WRITE: 'Done'.



FORM rule1.
  PERFORM rule1_test1.
  PERFORM rule1_test2.
ENDFORM.
FORM rule2.
  PERFORM rule2_test1.
  PERFORM rule2_test2.
  PERFORM rule2_test2a.
  PERFORM rule2_test2b.
  PERFORM rule2_test2c.
ENDFORM.
FORM rule3.
*  PERFORM rule3_test1.
*  PERFORM rule3_test2.
*  PERFORM rule3_test3.
  PERFORM rule3_test4.
*  PERFORM rule3_test5.
*  PERFORM rule3_test6.
ENDFORM.
FORM rule4.
  PERFORM rule4_test1.
  PERFORM rule4_test2.
ENDFORM.
FORM rule5.
  PERFORM rule5_test1.
  PERFORM rule5_test2.
ENDFORM.
FORM rule1_test1.

  DATA: lt_flight TYPE TABLE OF s_flightsv.

  SELECT *
    INTO @DATA(ls_flight)
    FROM s_flightsv.

    CHECK ls_flight-planetype = '747-400'.

    APPEND ls_flight TO lt_flight.
  ENDSELECT.

ENDFORM.
FORM rule1_test2.

  SELECT *
    INTO TABLE @DATA(lt_flight)
    FROM s_flightsv
   WHERE planetype = '747-400'.

ENDFORM.
FORM rule2_test1.

  TYPES: BEGIN OF lty_s_booking,
           ForeignCurrencyAmount TYPE s_bookingsv-ForeignCurrencyAmount,
           ForeignCurrencyCode   TYPE s_bookingsv-ForeignCurrencyCode,
         END OF lty_s_booking.

  DATA: ls_booking TYPE lty_s_booking,
        lt_booking TYPE TABLE OF lty_s_booking.

  SELECT ForeignCurrencyAmount, ForeignCurrencyCode
    INTO @ls_booking
    FROM s_bookingsv
   WHERE smoker = 'X'
   ORDER BY ForeignCurrencyCode.

    COLLECT ls_booking INTO lt_booking.
  ENDSELECT.

  SELECT ForeignCurrencyAmount, ForeignCurrencyCode
    INTO TABLE @DATA(lt_booking1)
    FROM s_bookingsv
   WHERE smoker = 'X'
   ORDER BY ForeignCurrencyCode.

  DATA(lt_booking2) = lt_booking1.
  CLEAR: lt_booking2.

  LOOP AT lt_booking1 INTO DATA(ls_booking1).

  ENDLOOP.

ENDFORM.
FORM rule2_test2.

  SELECT SUM( ForeignCurrencyAmount ) AS ForeignCurrencyAmount,
         ForeignCurrencyCode
    INTO TABLE @DATA(lt_booking)
    FROM s_bookingsv
   WHERE smoker = 'X'
   GROUP BY ForeignCurrencyCode
   ORDER BY ForeignCurrencyCode.

ENDFORM.
FORM rule2_test2a.

  TYPES: BEGIN OF lty_s_result_grouping,
           carrid       TYPE sflight-carrid,
           connid       TYPE sflight-connid,
           planetype    TYPE sflight-planetype,
           sum_seatsmax TYPE sflight-seatsmax,
         END OF lty_s_result_grouping.

  DATA: result_grouping_sets TYPE TABLE OF lty_s_result_grouping.

  SELECT carrid,
         planetype,
         SUM( seatsmax ) AS sum_seatsmax
    FROM sflight
   WHERE carrid = 'LH'
   GROUP BY carrid, planetype
   INTO CORRESPONDING FIELDS OF TABLE @result_grouping_sets.

  SELECT carrid,
         connid,
         SUM( seatsmax ) AS sum_seatsmax
    FROM sflight
   WHERE carrid = 'LH'
   GROUP BY carrid, connid

  APPENDING CORRESPONDING FIELDS OF TABLE @result_grouping_sets.

  SORT result_grouping_sets BY connid planetype.

ENDFORM.
FORM rule2_test2b.

  SELECT FROM sflight
        FIELDS carrid,
               connid,
               planetype,
               SUM( seatsmax ) AS sum_seatsmax
               WHERE carrid = 'LH'
        GROUP BY GROUPING SETS ( ( carrid, planetype ),
                                 ( carrid, connid ) )
        ORDER BY connid, planetype
        INTO TABLE @DATA(result_grouping_sets).

ENDFORM.
FORM rule2_test2c.

  SELECT SUM( ForeignCurrencyAmount ) AS ForeignCurrencyAmount,
         ForeignCurrencyCode
    INTO TABLE @DATA(lt_booking)
    FROM s_bookingsv
   WHERE smoker = 'X'
   GROUP BY ForeignCurrencyCode
   HAVING SUM( ForeignCurrencyAmount ) > 708113
   ORDER BY ForeignCurrencyCode.

ENDFORM.
FORM rule3_test1.

  SELECT *
    FROM scustom
   WHERE country = 'DE'
    INTO TABLE @DATA(lt_custom).

  LOOP AT lt_custom INTO DATA(ls_custom).

    ls_custom-discount = ls_custom-discount + 1.
    MODIFY scustom FROM ls_custom.

  ENDLOOP.

ENDFORM.
FORM rule3_test2.

  SELECT *
    FROM scustom
   WHERE country = 'DE'
    INTO TABLE @DATA(lt_custom).

  LOOP AT lt_custom ASSIGNING FIELD-SYMBOL(<ls_custom>).
    <ls_custom>-discount = <ls_custom>-discount + 1.
  ENDLOOP.

  MODIFY scustom FROM TABLE lt_custom.

ENDFORM.
FORM rule3_test3.

  SELECT *
    FROM sbook
   WHERE smoker = 'X'
    INTO TABLE @DATA(lt_sbook).

  LOOP AT lt_sbook ASSIGNING FIELD-SYMBOL(<ls_sbook>).

    SELECT SINGLE *
      FROM scustom
     WHERE id = @<ls_sbook>-customid
      INTO @DATA(ls_scustom).

    <ls_sbook>-luggweight = <ls_sbook>-luggweight + 1.

  ENDLOOP.

ENDFORM.
FORM rule3_test4.

  SELECT *
    FROM sbook
   WHERE smoker = 'X'
    INTO TABLE @DATA(lt_sbook).

  IF lt_sbook[] IS NOT INITIAL.
    SELECT *
      FROM scustom
      FOR ALL ENTRIES IN @lt_sbook
     WHERE id = @lt_sbook-customid
     ORDER BY PRIMARY KEY
      INTO TABLE @DATA(lt_scustom).
  ENDIF.

  LOOP AT lt_sbook ASSIGNING FIELD-SYMBOL(<ls_sbook>).

    READ TABLE lt_scustom INTO DATA(ls_scustom) WITH KEY id = <ls_sbook>-customid BINARY SEARCH.
    IF sy-subrc = 0.
      <ls_sbook>-luggweight = <ls_sbook>-luggweight + 1.
    ENDIF.

  ENDLOOP.

ENDFORM.
FORM rule3_test5.

  SELECT *
    FROM sbook
   WHERE smoker = 'X'
    INTO TABLE @DATA(lt_sbook).

  LOOP AT lt_sbook INTO DATA(ls_sbook).

    SELECT SINGLE isocd
      FROM zzztcurc
     WHERE waers = @ls_sbook-forcurkey
      INTO @DATA(lv_isocd).

  ENDLOOP.

ENDFORM.
FORM rule3_test6.

  SELECT *
    FROM sbook
   WHERE smoker = 'X'
    INTO TABLE @DATA(lt_sbook).

  LOOP AT lt_sbook INTO DATA(ls_sbook).

    SELECT SINGLE isocd
      FROM tcurc
     WHERE waers = @ls_sbook-forcurkey
      INTO @DATA(lv_isocd).

  ENDLOOP.

ENDFORM.
FORM rule4_test1.

  SELECT *
    FROM sbook
   WHERE fldate = '20230514'
    INTO TABLE @DATA(lt_sbook).

ENDFORM.
FORM rule4_test2.

  SELECT *
    FROM sbook
   WHERE agencynum = '00000188'
    INTO TABLE @DATA(lt_sbook).

ENDFORM.
FORM rule5_test1.

  SELECT *
    FROM sbook
   WHERE smoker NE 'X'
   ORDER BY PRIMARY KEY
    INTO TABLE @DATA(lt_sbook).

ENDFORM.
FORM rule5_test2.

  DATA: lt_sbook TYPE SORTED TABLE OF sbook
                 WITH UNIQUE KEY carrid connid fldate bookid.

  SELECT *
    FROM sbook
   WHERE smoker NE 'X'
   ORDER BY PRIMARY KEY
    INTO TABLE @lt_sbook.

ENDFORM.
