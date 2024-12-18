CLASS LHC_ZR_ASG_TABLE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrAsgTable
        RESULT result,
      checkExpirationDate FOR MODIFY
            IMPORTING keys FOR ACTION ZrAsgTable~checkExpirationDate RESULT result.
ENDCLASS.

CLASS LHC_ZR_ASG_TABLE IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD checkExpirationDate.
    DATA: lt_groceries TYPE TABLE FOR READ RESULT ZR_ASG_TABLE,
          ls_ZrAsgTable TYPE STRUCTURE FOR READ RESULT ZR_ASG_TABLE,
          lv_expiration TYPE d,
          lv_current_date TYPE d,
          lv_expired TYPE abap_boolean,
          lt_update_groceries TYPE TABLE FOR UPDATE ZR_ASG_TABLE.

          READ ENTITIES OF ZR_ASG_TABLE
      IN LOCAL MODE ENTITY ZrAsgTable
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT lt_groceries.

    LOOP AT lt_groceries INTO ls_ZrAsgTable.
      lv_expiration = ls_ZrAsgTable-Expirationdate.
      lv_current_date = cl_abap_context_info=>get_system_date( ).
      IF lv_expiration < lv_current_date.
        lv_expired = abap_true.
      ELSE.
        lv_expired = abap_false.
      ENDIF.

    APPEND VALUE #( id = ls_ZrAsgTable-Id expired = lv_expired )
      TO lt_update_groceries.
    MODIFY ENTITIES OF ZR_ASG_TABLE IN LOCAL MODE
      ENTITY ZrAsgTable
      UPDATE FIELDS ( expired )
      WITH lt_update_groceries.
    ENDLOOP.

    result = VALUE #( FOR groceries IN lt_groceries
      ( id = groceries-id %param = groceries ) ).
  ENDMETHOD.

ENDCLASS.
