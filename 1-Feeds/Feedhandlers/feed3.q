//Mock Feedhandler -- Reference data loader
//Start-up -- q 1-Feeds/Feedhandlers/feed3.q 
//Reference data loader -- does a one time publish of csv data on start up. Sits idle otherwise

/- Load in the generic feedhandler code first
system"l 1-Feeds/feedhandler_utils.q";

/- Use a random seed on restart to create variability in billingCurrency
system"S ",string .z.i;

sendDataAsCSV:{[table;data]
	data:csv 0: data;
	h (`.u.updCSV;table;data);
  };

AccountGroupMapping:AccountGroupTable[`accountRef]!AccountGroupTable[`accountGroup]

generateAccountReferenceData:{
	update accountGroup:AccountGroupMapping[accountRef] from ([]accountRef:AccountGroupTable[`accountRef]; clientName:(count AccountGroupTable)#(`$"John Smith";`$"Jane Doe"); modifiedDate:(count AccountGroupTable)#.z.D; billingCurrency:(count AccountGroupTable)?`EUR`GBP)
 };

publishAccountData:{	
	sendDataAsCSV[`AccountReference;generateAccountReferenceData[]];
  };

/- As soon as process starts up - CSV data gets sent (for simplicity sake)
publishAccountData[];


