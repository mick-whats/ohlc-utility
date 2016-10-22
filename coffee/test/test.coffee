Ohlc = require '../'
{assert} = require 'chai'
_ = require 'lodash'
quandlData = require '../quandlSample1570.json'

describe "basic test", ->
  it "arrays", ->
    data = new Ohlc(quandlData.dataset.data)
    assert.deepEqual data.arrays[0],
      [ '2012-08-23', 3880, 3980, 3870, 3965, 252518 ]
  it "objects", ->
    data = new Ohlc(quandlData.dataset.data)
    assert.deepEqual data.objects[0],{
      Date: '2012-08-23'
      Open: 3880
      High: 3980
      Low: 3870
      Close: 3965
      Volume: 252518
    }
