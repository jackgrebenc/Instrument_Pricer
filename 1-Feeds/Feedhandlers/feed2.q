//Mock Feedhandler -- Modern system
//Start-up -- q 1-Feeds/Feedhandlers/feed2.q 
//publish data once every 500ms in batches of BATCH_SIZE

/- Load in the generic feedhandler code first
system"l 1-Feeds/feedhandler_utils.q";

/- Define global variables specifc to 'Feed2'
BATCH_SIZE:10;


sendDataAsJSON:{[table;data]
	data:.j.j each data;
	{h (`.u.updJSON;x;y)}[table;] each data;
	//h (`.u.updJSON;table;data);
  };



.z.ts:{	
	sendDataAsJSON[`modernInstruments;generateInstrumentData[`LDN]];
	updateIDs[];
  };

system "t 500"; //set timer to once every 500 ms