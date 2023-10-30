*&---------------------------------------------------------------------*
*& Include          ZPTEST001_TOP
*&---------------------------------------------------------------------*
TABLES : sscrfields, s_bookingsv.
*----------------------------------------------------------------------*
* INTERNAL TABLES
*----------------------------------------------------------------------*
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
       END OF lty_s_output.

DATA: gt_data TYPE STANDARD TABLE OF lty_s_output.


*"BDC Tables
*DATA : gt_bdcdata TYPE TABLE OF bdcdata WITH HEADER LINE,    "BDC Data
*       gt_message TYPE TABLE OF bdcmsgcoll WITH HEADER LINE. "Message

*----------------------------------------------------------------------*
* RANGE VARIABLES
*----------------------------------------------------------------------*
*RANGES : gr_bunit FOR bsid-bukrs.

*----------------------------------------------------------------------*
* VARIABLES
*----------------------------------------------------------------------*
DATA : ok_code  TYPE sy-ucomm,
       gv_ucomm TYPE sy-ucomm.

*----------------------------------------------------------------------*
* CONSTANTS
*----------------------------------------------------------------------*
