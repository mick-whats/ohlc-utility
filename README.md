# ohlc-utility

Ohlcとは株や商品先物等の四本値のことです。
> o = Open = 始値
> h = High = 高値
> l = Low  = 安値
> c = Close= 終値

この四本値データからMA(移動平均)等を生成したり、最高値や最安値等を分析するUtilityです。

## data
元のデータは[Quandl](https://www.quandl.com/docs/api)方式の配列を使います。

単一のデータは以下の形式です。
`["Date","Open","High","Low","Close","Volume"]`
使用するデータは上記の配列の配列です。  
```
[
  [ '2012-08-23', 3880, 3980, 3870, 3965, 252518 ],
  [ '2012-08-24', 3890, 3990, 3770, 3900, 212432 ],
  (中略)
]
```
QuandlのDatasetApiで取得した場合は`dataset.data`に入っているものをそのまま使えます。  
他から取ってきたdataでも同じ形式なら作動するはずです。
## Initialize
```
Ohlc = require 'ohlc-utility'
data = new Ohlc(quandlData.dataset.data)

console.log(data.arrays) #元のデータです
console.log(data.objects[0]) #元のデータをobject化したものです。
###
{
  Date: '2012-08-23'
  Open: 3880
  High: 3980
  Low: 3870
  Close: 3965
  Volume: 252518
}
###
```

newする時に第二引数としてオプションを指定できます。
以下の場合はtypeで月足を指定、maで12本と24本の移動平均を追加しています。
```
    opts = {
      type: 'month'
      ma: [12,24]
    }
    data = new Ohlc(quandlData.dataset.data,opts)

    ### sample
    {
      Date: '2016-08-01',
      Open: 10640,
      High: 11370,
      Low: 10040,
      Close: 11310,
      Volume: 195845183
      ma12: 12435.83
      ma24: 13701.67
    }

```
