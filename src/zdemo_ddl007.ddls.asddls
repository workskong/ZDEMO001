@AbapCatalog.sqlViewName: 'ZDEMO_V007'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo'
define view ZDEMO_DDL007
  as select from ZDEMO_DDL006
{
  carrierid,
  connectionid,
  flightdate,
  bookid,
  customerid,
  CustomerType,
  smoker,
  @Semantics.quantity.unitOfMeasure: 'weightunit'
  luggageweight,
  weightunit,
  invoiceid,
  class,
  @Semantics.amount.currencyCode: 'foreigncurrencycode'
  foreigncurrencyamount,
  foreigncurrencycode,
  @Semantics.amount.currencyCode: 'localcurrencycode'
  localcurrencyamount,
  localcurrencycode,
  orderdate,
  counter,
  agencynumber,
  cancelled,
  reserved,
  decimalplaces,
  customername,
  foreigncurrencyiso,
  localcurrencyiso
}
