Ohlc = require '../'
{assert} = require 'chai'
_ = require 'lodash'
quandlData = require '../quandlSample1570.json'

describe "array test", ->
  it "slice", ->
    arr1 = [1,2,3,4,5]
    arr2 = _.slice(arr1,3)
    assert.deepEqual arr1,[1,2,3,4,5]
    assert.deepEqual arr2,[4,5]
describe "Information test", ->
  it "highPrice()", -> # 全期間の最高値
    data = new Ohlc(quandlData.dataset.data)
    assert.deepEqual data.highPrice(),18830
  it "highPrice(100)", -> # 100日前までの最高値
    data = new Ohlc(quandlData.dataset.data)
    assert.deepEqual data.highPrice(100),12530
  it "lowPrice()", -> # 全期間の最安値
    data = new Ohlc(quandlData.dataset.data)
    assert.deepEqual data.lowPrice(),3440
  it "lowPrice(100)", -> # 100日前までの最安値
    data = new Ohlc(quandlData.dataset.data)
    assert.deepEqual data.lowPrice(100),8760

  # it "objects", ->
  #   data = new Ohlc(quandlData.dataset.data)
  #   assert.deepEqual data.objects[0],{
  #     Date: '2012-08-23'
  #     Open: 3880
  #     High: 3980
  #     Low: 3870
  #     Close: 3965
  #     Volume: 252518
  #   }
