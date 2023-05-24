//Start up "q 2-Pricer/InstrumentPricer.q :5001 -p 5013 
//OR use start script

system"l tick/r.q";
system"l tick/sym.q";

h:(hopen `$":",.u.x 0);
h".u.sub[`legacyInstruments;`]";
h".u.sub[`modernInstruments;`]";
h".u.sub[`AccountReference;`]";

/- Pricing implementation

mergeDataFromFeeds:{
	update "N"$executionTime,`$marketName,`$accountRef,`$instrumentType from @[{modernInstruments,(update "F"$RA,"F"$R,"F"$NP,"F"$P,"F"$Y from (trim legacyInstruments))}; enlist[::]; modernInstruments]
	};

applyPricingAlgorithm:{[data] update Price:(((data[`R] - data[`RA])*data[`NP]*data[`P])%(1*data[`Y]))*(1%(1+data[`R]*(data[`P]%data[`Y]))) from data};

PricedInstruments:select [0] from applyPricingAlgorithm[mergeDataFromFeeds[]]; /- get schema to prevent upstream errors on start-up

if[not system"t";system"t 1000"]; //default to update Priced table once a second
.z.ts:{ 
	`PricedInstruments insert applyPricingAlgorithm[mergeDataFromFeeds[]];
	/- Clear out data that has already been consumed
	modernInstruments::select [0] from modernInstruments;
	legacyInstruments::select [0] from legacyInstruments;
 	};
