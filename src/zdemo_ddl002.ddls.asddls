@AbapCatalog.sqlViewName: 'ZDEMO_V002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo'
define view ZDEMO_DDL002
  as select from S_Bookings as a
    inner join   zdemo_v001 as v on  v.flightdate = a.FlightDate
                                 and v.customerid = a.CustomerId
                                 and a.BookId     = v.bookid
{
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
  a.Class,
  a.ForeignCurrencyAmount,
  a.ForeignCurrencyCode,
  a.LocalCurrencyAmount,
  a.LocalCurrencyCode,
  a.OrderDate,
  a.Counter,
  a.AgencyNumber,
  a.Cancelled,
  a.Reserved,

  a._ForeignCurrency.isocd as ForeignCurrencyIso,
  a._LocalCurrency.isocd   as LocalCurrencyIso,
  a._WeightUnit.decan      as DecimalPlaces,
  a._Customer.name         as Customername
}
