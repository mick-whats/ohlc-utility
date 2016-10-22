Ohlc = require '../'
{assert} = require 'chai'
_ = require 'lodash'
quandlData = require '../quandlSample1570.json'

describe "type test", ->
  it "month data", ->
    opts = type: 'month' #alias [Month,m,M]
    data = new Ohlc(quandlData.dataset.data,opts)
    data20160801 = _.find data.objects,(o)-> o.Date is '2016-08'
    assert.deepEqual data20160801, {
      Date: '2016-08',
      Open: 10640,
      High: 11370,
      Low: 10040,
      Close: 11310,
      Volume: 195845183
    }
  it "week data", ->
    opts = type: 'week' #alias [Week,w,W]
    data = new Ohlc(quandlData.dataset.data,opts)
    data20160801 = _.find data.objects,(o)-> o.Date is '2016-08-01'
    assert.deepEqual data20160801, {
      Date: '2016-08-01',
      Open: 10640,
      High: 11040,
      Low: 10040,
      Close: 10470,
      Volume: 61417462
    }
  it "week data add Moveing Average", ->
    opts =
      type: 'week'
      ma: [13,26]
    data = new Ohlc(quandlData.dataset.data,opts)
    data20160801 = _.find data.objects,(o)-> o.Date is '2016-08-01'
    assert.deepEqual data20160801, {
      Date: '2016-08-01',
      Open: 10640,
      High: 11040,
      Low: 10040,
      Close: 10470,
      Volume: 61417462
      ma13: 10508.46
      ma26: 10751.54
    }
  it "month data add Moveing Average", ->
    opts =
      type: 'm'
      ma: [12,24]
    data = new Ohlc(quandlData.dataset.data,opts)
    data20160801 = _.find data.objects,(o)-> o.Date is '2016-08'
    assert.deepEqual data20160801, {
      Date: '2016-08',
      Open: 10640,
      High: 11370,
      Low: 10040,
      Close: 11310,
      Volume: 195845183
      ma12: 12435.83
      ma24: 13701.67
    }
