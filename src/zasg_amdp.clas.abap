CLASS zasg_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  data: out TYPE REF TO if_oo_adt_classrun_out.
types: lt_data type STANDARD TABLE OF ZWB_TRAVEL_M.
    INTERFACES: if_amdp_marker_hdb,
    if_oo_adt_classrun.
    methods: amdp_meth
    importing value(num) type i
    EXPORTING value(itab) type lt_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zasg_amdp IMPLEMENTATION.
  METHOD amdp_meth
  by DATABASE PROCEDURE
  FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING ZWB_TRAVEL_M.
      itab = select * from ZWB_TRAVEL_M limit 10;

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
   amdp_meth( EXPORTING num = 2
           IMPORTING itab = data(lt_data) ).
out->write( lt_data ).
  ENDMETHOD.

ENDCLASS.
