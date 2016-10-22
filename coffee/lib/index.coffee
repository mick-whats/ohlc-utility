_ = require 'lodash'
util = require('util')
moment = require 'moment'


class OhlcUtil
  mapForMonthOrWeeks = (values)->
    return [
      values[0][0]
      values[0][1]
      _.maxBy(values,(v)-> v[2])[2]
      _.minBy(values,(v)-> v[3])[3]
      _.last(values)[4]
      _.sumBy(values,"5")
    ]
  constructor: (@arrays,opts) ->
    length = opts?.length or null
    # column_names = ["Date","Open","High","Low","Close","Volume"]
    if opts?.type?
      switch opts.type
        when 'month','Month','m','M'
          @arrays = _.chain(@arrays)
          .groupBy (o)->
            y = moment(o[0]).year()
            m = moment(o[0]).month()
            return "#{y}#{m}"
          .map (values)-> mapForMonthOrWeeks(values)
          .each (values)->
            values[0] = values[0].replace(/-\d{2}$/,'')
          .sortBy (o)-> moment(o[0]).unix()
          .value()
        when 'week','Week','w','W'
          @arrays = _.chain(@arrays)
          .groupBy (o)->
            y = moment(o[0]).year()
            w = moment(o[0]).week()
            return "#{y}#{w}"
          .map (values)-> mapForMonthOrWeeks(values)
          .sortBy (o)-> moment(o[0]).unix()
          .value()
    if length
      @arrays = _.slice(@arrays,@arrays.length - length, @arrays.length)
    @objects = _.map @arrays,(o)->
      return {
        Date:   o[0]
        Open:   o[1]
        High:   o[2]
        Low:    o[3]
        Close:  o[4]
        Volume: o[5]
      }
    if ma = opts?.ma or []
      _.each ma,(dayCount)=>
        @addMa(dayCount)
    if vma = opts?.vma or []
      _.each vma,(dayCount)=>
        @addVolumeMa(dayCount)
    if vpma = opts?.vpma or []
      _.each vpma,(dayCount)=>
        @addVPMA(dayCount)
    ###############################################################################
  # ██    ██ ████████ ██ ██
  # ██    ██    ██    ██ ██
  # ██    ██    ██    ██ ██
  # ██    ██    ██    ██ ██
  #  ██████     ██    ██ ███████
  ###############################################################################
  sliceArray: (dayCount)->
    if dayCount
      arr = _.slice @objects,@objects.length - dayCount
    else
      arr = @objects
    return arr
  previousAndCurrentRatio = (be, af)->
    return _.floor((af - be) / Math.abs(be) * 100, 2)

  ###############################################################################
  # ███    ███  █████
  # ████  ████ ██   ██
  # ██ ████ ██ ███████
  # ██  ██  ██ ██   ██
  # ██      ██ ██   ██
  ###############################################################################


  addMa: (dayCount)->
    _.each @objects,(o,i)=>
      name = "ma#{dayCount}"
      if i > dayCount
        sum = _.sumBy @objects[i-dayCount+1..i],(obj)-> obj.Close
        o[name] = _.round(sum / dayCount,2)
      else
        o[name] = null
    return
  addVolumeMa: (dayCount)->
    _.each @objects,(o,i)=>
      name = "vma#{dayCount}"
      if i > dayCount
        sum = _.sumBy @objects[i-dayCount+1..i],(obj)-> obj.Volume
        o[name] = _.round sum / dayCount,2
      else
        o[name] = null
    return
  addVPMA: (dayCount)-># Volume and Price Moveing Average
    _.each @objects,(o,i)=>
      name = "vpma#{dayCount}"
      sumVolume = 0
      if i > dayCount
        sum = _.sumBy @objects[i-dayCount+1..i],(obj)->
          price = obj.Close
          volume = obj.Volume
          sumVolume += volume
          return price * volume
        o[name] = _.round sum / sumVolume,2
      else
        o[name] = null
    return
  addRange:->
    _.each @objects,(o)->
      o.range = previousAndCurrentRatio(o.Low,o.High)
  ###############################################################################
  # ██ ███    ██ ███████  ██████
  # ██ ████   ██ ██      ██    ██
  # ██ ██ ██  ██ █████   ██    ██
  # ██ ██  ██ ██ ██      ██    ██
  # ██ ██   ████ ██       ██████
  ###############################################################################

  highPrice:(dayCount)->
    arr = @sliceArray(dayCount)
    return _.maxBy(arr,(o)->o.High).High
  lowPrice:(dayCount)->
    arr = @sliceArray(dayCount)
    return _.minBy(arr,(o)->o.Low).Low


module.exports = OhlcUtil
