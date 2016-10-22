Ohlc = require '../'
{assert} = require 'chai'
_ = require 'lodash'
quandlData = require '../quandlSample1570.json'

describe "Moveing Average test", ->
  it "ma constructor", ->
    opts = {ma: [5,25,75]}
    data = new Ohlc(quandlData.dataset.data,opts)
    assert.deepEqual data.objects[0],{
      Date: '2012-08-23'
      Open: 3880
      High: 3980
      Low: 3870
      Close: 3965
      Volume: 252518
      ma5: null
      ma25: null
      ma75: null
    }
    assert.deepEqual _.last(data.objects),{
      Date: '2016-09-23'
      Open: 11130
      High: 11160
      Low: 11050
      Close: 11080
      Volume: 7980857
      ma5: 10878
      ma25: 11060
      ma75: 10650.4
    }
  it "ma addMa", ->
    data = new Ohlc(quandlData.dataset.data)
    assert.isUndefined _.last(data.objects).ma5
    data.addMa(5)
    assert.equal _.last(data.objects).ma5,10878
  it "Volume Moveing Average constructor", ->
    opts = {vma:[5,25,75]}
    data = new Ohlc(quandlData.dataset.data,opts)
    # console.log _.last(data)
    assert.deepEqual _.last(data.objects),{
      Date: '2016-09-23'
      Open: 11130
      High: 11160
      Low: 11050
      Close: 11080
      Volume: 7980857
      vma5:  9936501.6
      vma25: 8149428.32
      vma75: 12852068.39
    }
  it "Volume Moveing Average addVolumeMa", ->
    data = new Ohlc(quandlData.dataset.data)
    assert.isUndefined _.last(data.objects).vma5
    data.addVolumeMa(5)
    assert.equal _.last(data.objects).vma5,9936501.6
  it "Volume And Price Moveing Average constructor", ->
    opts = {vpma:[5,25,75]}
    data = new Ohlc(quandlData.dataset.data,opts)
    # console.log _.last(data)
    assert.deepEqual _.last(data.objects),{
      Date: '2016-09-23'
      Open: 11130
      High: 11160
      Low: 11050
      Close: 11080
      Volume: 7980857
      vpma5:  10920.9
      vpma25: 11034.11
      vpma75: 10406.39
    }
  it "Volume And Price Moveing Average addVolumeMa", ->
    data = new Ohlc(quandlData.dataset.data)
    assert.isUndefined _.last(data.objects).vpma5
    data.addVPMA(5)
    assert.equal _.last(data.objects).vpma5,10920.9
describe "range", ->
  it "addRange()", -> #その日毎の高安幅(%)を加える
    data = new Ohlc(quandlData.dataset.data)
    data.addRange()
    assert.equal data.objects[0].range,2.84 # 2.84%
