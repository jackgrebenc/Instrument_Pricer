//Mock Feedhandler -- legacy system
//SampleStart-up -- q 1-Feeds/Feedhandlers/feed1.q 
//LEGACY SYSTEM -- publishes data once every 3 seconds in batches of 5

/- Load in the generic feedhandler code first
system"l 1-Feeds/feedhandler_utils.q";

/- Define global variables specifc to 'Feed1'
BATCH_SIZE:5;
FIXED_WIDTH_STRING_LENGTH:25;

/- Define functions specific to 'Feed1' use case
convertToFixedWidthString:{[col] FIXED_WIDTH_STRING_LENGTH$$[10h~type col;col;string col]};

sendDataAsFixedWidthString:{[table;data]
	data:convertToFixedWidthString each data;
	{h (`.u.upd;x;enlist each value y)}[table;] each data;
	//h (`.u.upd;table;data);
  };


.z.ts:{	
	sendDataAsFixedWidthString[`legacyInstruments;generateInstrumentData[`FFM]];
	updateIDs[];
  };

system "t 3000"; //set timer to once every 3 seconds
