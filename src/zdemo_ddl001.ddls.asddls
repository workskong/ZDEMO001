@AbapCatalog.sqlViewName: 'ZDEMO_V001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'demo'
define view zdemo_ddl001
  as select from s_bookingsv
{
  flightdate,
  customerid,
  min(bookid) as bookid
}
group by
  flightdate,
  customerid
