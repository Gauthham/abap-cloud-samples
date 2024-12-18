@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_ASG_TABLE
  as select from zasg_table
{

  key id               as Id,
      @Search.defaultSearchElement: true
      product          as Product,
      @Search.defaultSearchElement: true
      category         as Category,
      @Search.defaultSearchElement: true
      brand            as Brand,
      @Semantics.amount.currencyCode: 'Currency'
      price            as Price,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_CurrencyStdVH',
        entity.element: 'Currency',
        useForValidation: true
      } ]
      currency         as Currency,
      quantity         as Quantity,
      purchasedate     as Purchasedate,
      expirationdate   as Expirationdate,
      expired          as Expired,
      rating           as Rating,
      note             as Note,
      @Semantics.user.createdBy: true
      createdby        as Createdby,
      createdat        as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby    as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat    as Lastchangedat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchanged as Locallastchanged

}
