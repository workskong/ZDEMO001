*&---------------------------------------------------------------------*
*& Include          ZPTEST001_SCR
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*  SELECTION-SCREEN
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-b01.

  SELECT-OPTIONS : s_carri FOR s_bookingsv-carrierid,
                   s_conne FOR s_bookingsv-connectionid,
                   s_fdate FOR s_bookingsv-flightdate,
                   s_booki FOR s_bookingsv-bookid,
                   s_custo FOR s_bookingsv-customerid.

  PARAMETERS     : p_custo TYPE s_bookingsv-customerid  MODIF ID gr2,
                   p_smoke TYPE s_bookingsv-smoker  MODIF ID gr2.

SELECTION-SCREEN END OF BLOCK b1.
