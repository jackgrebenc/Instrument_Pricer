
//Feed1 table
legacyInstruments:([]
	executionTime:();
	marketName:();
	batchId:();
	accountRef:();
	uniqueId:();
	instrumentType:();
	RA:(); 
	R:(); 
	NP:();
	P:();
	Y:()
	);


//Feed2 table
modernInstruments:([]
	executionTime:();
	marketName:();
	batchId:();
	accountRef:();
	uniqueId:();
	instrumentType:();
	RA:`float$(); 
	R:`float$(); 
	NP:`float$();
	P:`float$();
	Y:`float$()
	);

//Feed3 table
AccountReference:([]
	accountRef:`symbol$();
	clientName:`symbol$();
	modifiedDate:`date$();
	billingCurrency:`symbol$();
	accountGroup:`symbol$()
 );

