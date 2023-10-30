@AbapCatalog.sqlViewName: 'ZDEMO_V003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo'
define view ZDEMO_DDL003
  as select from    sflight as f
    left outer join sbook   as b on  b.carrid = f.carrid
                                 and b.connid = f.connid
                                 and b.fldate = f.fldate
    left outer join t006    as t on t.msehi = b.wunit
    left outer join scustom as c on c.id = b.customid
{
  f.carrid     as CarrierId,
  f.connid     as ConnectionId,
  b.fldate     as FlightDate,
  b.bookid     as BookId,
  b.customid   as CustomerId,
  b.custtype   as CustomerType,
  b.smoker     as Smoker,
  b.luggweight as LuggageWeight,
  b.wunit      as WeightUnit,
  b.invoice    as InvoiceId,
  b.class      as Class,
  b.forcuram   as ForeignCurrencyAmount,
  b.forcurkey  as ForeignCurrencyCode,
  b.loccuram   as LocalCurrencyAmount,
  b.loccurkey  as LocalCurrencyCode,
  b.order_date as OrderDate,
  b.counter    as Counter,
  b.agencynum  as AgencyNumber,
  b.cancelled  as Cancelled,
  b.reserved   as Reserved,
  t.decan      as DecimalPlaces,
  c.name       as Customername


}
