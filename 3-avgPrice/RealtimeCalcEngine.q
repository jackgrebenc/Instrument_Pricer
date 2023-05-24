//RDB1 
//Start up q 3-avgPrice/RealtimeCalcEngine.q :5013 -p 5014
//OR use start script

system"l tick/r.q";
system"l tick/sym.q";

h:(hopen `$":",.u.x 0);



MarketCurrencyMapping:`FFM`LDN!`EUR`GBP; /- static mapping for market/City name to Currency

/- Simulates live FxRate by selecting a random rate within a range of May 24 real FxRate
getLiveFxRateToUSD:{ FxRate:()!(); FxRate[`EUR]:1.08 + rand 0.1;FxRate[`GBP]:1.24 + rand 0.1; FxRate[x]};


getUSDPricedData:{
	prices:h"(select executionTime,accountRef,Price,marketName,instrumentType from PricedInstruments) lj (select last accountGroup by accountRef from AccountReference where modifiedDate=max modifiedDate)";
	update USDPrice:Price*getLiveFxRateToUSD'[MarketCurrencyMapping[marketName]] from prices
 };

/- a) the realtime average price for instruments per accountGroup in US Dollars.
getRealtimeAvgPrice:{
	select AvgPriceUSD:avg USDPrice by accountGroup,instrumentType from getUSDPricedData[]
 };

/- b) rolling average price of 5 min intervals for instruments per accountGroup in US Dollars.
getVwapPrice:{
	select AvgPriceUSD:avg USDPrice by accountGroup,instrumentType, 5 xbar executionTime.minute  from getUSDPricedData[]
 };