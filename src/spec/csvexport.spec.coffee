CsvMapping = require '../lib/csvmapping'
exampleorders = require './exampleorders'

describe '#mapOrders', ->
  beforeEach ->
    @csvMapping = new CsvMapping()

  it 'export base attributes', (done) ->
    template =
      """
      id,orderNumber
      """

    expectedCSV =
      """
      id,orderNumber
      abc,10001
      xyz,10002
      """

    @csvMapping.mapOrders(template, exampleorders.orders)
    .then (result) ->
      expect(result).toBe expectedCSV
      done()
    .fail (err) ->
      done(err)
    .done()

xdescribe 'disabled', ->
  it 'export prices', ->
    template =
      """
      id,orderNumber,totalPrice,totalNet,totalGross
      """

    expectedCSV =
      """
      id,orderNumber,totalPrice,totalNet,totalGross
      abc,10001,USD 5950,USD 5000,USD 950
      xyz,10002,USD 2380,USD 2000,USD 380
      """

    csv = @orderExport.toCSV template, exampleorders
    expect(csv).toBe expectedCSV

  it 'export addresses', ->
    template =
      """
      id,orderNumber,billingAddress.firstName,billingAddress.lastName,billingAddress.streetName,billingAddress.streetNumber,billingAddress.postalCode,billingAddress.city,billingAddress.country,shippingAddress.firstName,shippingAddress.lastName,shippingAddress.streetName,shippingAddress.streetNumber,shippingAddress.postalCode,shippingAddress.city,shippingAddress.country
      """

    expectedCSV =
      """
      id,orderNumber,billingAddress.firstName,billingAddress.lastName,billingAddress.streetName,billingAddress.streetNumber,billingAddress.postalCode,billingAddress.city,billingAddress.country,shippingAddress.firstName,shippingAddress.lastName,shippingAddress.streetName,shippingAddress.streetNumber,shippingAddress.postalCode,shippingAddress.city,shippingAddress.country
      abc,10001,John,Doe,"Some Street",11,11111,"Some City",US,John,Doe,"Some Street",11,11111,"Some City",US
      xyz,10002,Jane,Doe,"Some Other Street",22,22222,"Some Other City",US,Jane,Doe,"Some Other Street",22,22222,"Some Other City",US
      """

    csv = @orderExport.toCSV template, exampleorders
    expect(csv).toBe expectedCSV

  it 'export lineItems', ->
    template =
      """
      id,orderNumber,lineItems.id,lineItems.productId,lineItems.name.en,lineItems.variant.variantId,lineItems.variant.sku,lineItems.quantity,price
      """

    expectedCSV =
      """
      id,orderNumber,lineItems.id,lineItems.productId,lineItems.name.en,lineItems.variant.variantId,lineItems.variant.sku,lineItems.quantity,price
      abc,10001,,,,,,,
      abc,10001,LineItemId-1-1,ProductId-1-1,Product-1-1,1,SKU-1-1,2,"US USD 1190"
      abc,10001,LineItemId-1-2,ProductId-1-2,Product-1-2,2,SKU-1-2,3,"US USD 1190"
      xyz,10002,,,,,,,
      zyz,10002,LineItemId-2-1,ProductId-2-1,Product-2-1,1,SKU-2-1,1,"US USD 2380"
      """

    csv = @orderExport.toCSV template, exampleorders
    expect(csv).toBe expectedCSV