/- Common code shared by all feedhandlers

system"l tick/logging.q";
system"l 1-Feeds/AccountGroupMapping.q";

/- Define global variables
BATCH_SIZE:1; /- defaults to 1; can be overriden by each feedhandler to a higher value
BATCH_NUM:1;
UNIQUE_ID_COUNTER:0;


/- Utility functions
getBatchId:{raze string .z.d,".",string BATCH_NUM};
rh:{0.01*floor 0.5+x*100};
updateIDs:{BATCH_NUM::BATCH_NUM+1; UNIQUE_ID_COUNTER::UNIQUE_ID_COUNTER+BATCH_SIZE;};



/- Connect to TickerPlant
h:@[hopen;`::5001;{-2"Failed to open connection to tickerplant  port 5001: "; exit 1}];


generateInstrumentData:{[region]
	([]executionTime:BATCH_SIZE#.z.N;marketName:BATCH_SIZE#region;batchId:BATCH_SIZE#`$getBatchId[];accountRef:{`$rand AccountGroupTable[`accountRef]} each til BATCH_SIZE;uniqueId: {[region;num]`$raze (string region),"_",string num}[region;]each UNIQUE_ID_COUNTER   + til BATCH_SIZE; instrumentType:BATCH_SIZE?`AA`BB`CC`DD; RA:rh 0.01*(BATCH_SIZE?10.0); R:rh 0.01*(BATCH_SIZE?10.0); NP:rh 1000000+(BATCH_SIZE?249000000.0);P:BATCH_SIZE?365;Y:BATCH_SIZE?365)
 };