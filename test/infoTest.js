// Generated by CoffeeScript 1.10.0
(function() {
  var Ohlc, _, assert, quandlData;

  Ohlc = require('../');

  assert = require('chai').assert;

  _ = require('lodash');

  quandlData = require('../quandlSample1570.json');

  describe("array test", function() {
    return it("slice", function() {
      var arr1, arr2;
      arr1 = [1, 2, 3, 4, 5];
      arr2 = _.slice(arr1, 3);
      assert.deepEqual(arr1, [1, 2, 3, 4, 5]);
      return assert.deepEqual(arr2, [4, 5]);
    });
  });

  describe("Information test", function() {
    it("highPrice()", function() {
      var data;
      data = new Ohlc(quandlData.dataset.data);
      return assert.deepEqual(data.highPrice(), 18830);
    });
    it("highPrice(100)", function() {
      var data;
      data = new Ohlc(quandlData.dataset.data);
      return assert.deepEqual(data.highPrice(100), 12530);
    });
    it("lowPrice()", function() {
      var data;
      data = new Ohlc(quandlData.dataset.data);
      return assert.deepEqual(data.lowPrice(), 3440);
    });
    return it("lowPrice(100)", function() {
      var data;
      data = new Ohlc(quandlData.dataset.data);
      return assert.deepEqual(data.lowPrice(100), 8760);
    });
  });

}).call(this);
