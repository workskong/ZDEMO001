CLASS zdemo_cl_amdp001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF lty_s_input,
             customerid TYPE s_customer,
           END OF lty_s_input,
           lty_t_input TYPE TABLE OF lty_s_input.

    TYPES: BEGIN OF lty_s_output,
             carrierid             TYPE s_carr_id,
             connectionid          TYPE s_conn_id,
             flightdate            TYPE s_date,
             bookid                TYPE s_book_id,
             customerid            TYPE s_customer,
             customertype          TYPE s_custtype,
             smoker                TYPE s_smoker,
             luggageweight         TYPE s_lugweigh,
             weightunit            TYPE s_weiunit,
             invoiceid             TYPE s_invflag,
             class                 TYPE s_class,
             foreigncurrencyamount TYPE s_f_cur_pr,
             foreigncurrencycode   TYPE s_curr,
             localcurrencyamount   TYPE s_l_cur_pr,
             localcurrencycode     TYPE s_currcode,
             orderdate             TYPE s_bdate,
             counter               TYPE s_countnum,
             agencynumber          TYPE s_agncynum,
             cancelled             TYPE s_cancel,
             reserved              TYPE s_reserv,
             decimalplaces         TYPE decan,
             customername          TYPE name,
             foreigncurrencyiso    TYPE isocd,
             localcurrencyiso      TYPE isocd,
             foreigncurrencykrw    TYPE s_bookings-foreigncurrencyamount,
           END OF lty_s_output,
           lty_t_output TYPE STANDARD TABLE OF lty_s_output.

    CLASS-METHODS:
      get_data_for_tab_func FOR TABLE FUNCTION zdemo_ddl006,

      get_data IMPORTING VALUE(p_mandt)       TYPE sy-mandt
                         VALUE(it_customerid) TYPE lty_t_input
               EXPORTING VALUE(et_data)       TYPE lty_t_output.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zdemo_cl_amdp001 IMPLEMENTATION.

  METHOD get_data_for_tab_func BY DATABASE FUNCTION FOR HDB
                               LANGUAGE SQLSCRIPT
                               OPTIONS READ-ONLY
                               USING
                               zdemo_v004.

    RETURN
     SELECT
  a.CarrierId,
  a.ConnectionId,
  a.FlightDate,
  a.BookId,
  a.CustomerId,
  a.CustomerType,
  a.Smoker,
  a.LuggageWeight,
  a.WeightUnit,
  a.InvoiceId,
  a.CLASS,
  a.ForeignCurrencyAmount,
  a.ForeignCurrencyCode,
  a.LocalCurrencyAmount,
  a.LocalCurrencyCode,
  a.OrderDate,
  a.Counter,
  a.AgencyNumber,
  a.Cancelled,
  a.Reserved,
  a.DecimalPlaces,
  a.Customername,
  a.foreigncurrencyiso,
  a.localcurrencyiso
      from (
        select distinct
          flightdate,
          customerid,
          bookid
          from zdemo_v004
          order by flightdate, customerid
      ) as s
      inner join zdemo_v004 as a on  s.flightdate = a.FlightDate
                                 and s.customerid = a.CustomerId
                                 and s.BookId     = a.bookid
                    ;

  endmethod.

  METHOD get_data BY DATABASE PROCEDURE FOR HDB
                  LANGUAGE SQLSCRIPT
                  OPTIONS READ-ONLY
                  USING
                  zdemo_v004.

    et_data =
  SELECT
  a.CarrierId,
  a.ConnectionId,
  a.FlightDate,
  a.BookId,
  a.CustomerId,
  a.CustomerType,
  a.Smoker,
  a.LuggageWeight,
  a.WeightUnit,
  a.InvoiceId,
  a.CLASS,
  a.ForeignCurrencyAmount,
  a.ForeignCurrencyCode,
  a.LocalCurrencyAmount,
  a.LocalCurrencyCode,
  a.OrderDate,
  a.Counter,
  a.AgencyNumber,
  a.Cancelled,
  a.Reserved,
  a.DecimalPlaces,
  a.Customername,
  a.foreigncurrencyiso,
  a.localcurrencyiso,
  0 as foreigncurrencykrw
      from (
        select distinct
          z.mandt,
          z.flightdate,
          z.customerid,
          z.bookid
          from :it_customerid as c
          INNER JOIN zdemo_v004 as z on z.customerid = c.customerid
          GROUP BY
          z.mandt,
          z.customerid,
          z.flightdate,
          z.bookid
          order by
          z.mandt,
          z.customerid,
          z.flightdate,
          z.bookid
      ) as s
      inner join zdemo_v004 as a on  s.flightdate = a.FlightDate
                                 and s.customerid = a.CustomerId
                                 and s.BookId     = a.bookid
                                 and s.mandt      = a.mandt
      WHERE s.mandt = :p_mandt
      ;

  ENDMETHOD.

ENDCLASS.
