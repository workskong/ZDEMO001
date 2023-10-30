@EndUserText.label: 'ZDEMO_V006'
@ClientHandling.type: #CLIENT_INDEPENDENT
define table function ZDEMO_DDL006
  //  with parameters
  //    p_CustomerId : s_customer
returns
{
  carrierid             : s_carr_id;
  connectionid          : s_conn_id;
  flightdate            : s_date;
  bookid                : s_book_id;
  customerid            : s_customer;
  CustomerType          : s_custtype;
  smoker                : s_smoker;
  luggageweight         : s_lugweigh;
  weightunit            : s_weiunit;
  invoiceid             : s_invflag;
  class                 : s_class;
  foreigncurrencyamount : s_f_cur_pr;
  foreigncurrencycode   : s_curr;
  localcurrencyamount   : s_l_cur_pr;
  localcurrencycode     : s_currcode;
  orderdate             : s_bdate;
  counter               : s_countnum;
  agencynumber          : s_agncynum;
  cancelled             : s_cancel;
  reserved              : s_reserv;
  decimalplaces         : decan;
  customername          : name;
  foreigncurrencyiso    : isocd;
  localcurrencyiso      : isocd;

}
implemented by method
  ZDEMO_CL_AMDP001=>GET_DATA_FOR_TAB_FUNC;
