//Start-up
/ q tick/tick.q sym . -p 5001 </dev/null >foo 2>&1 &

"kdb+tick 2.8 2014.03.12"

/q tick.q SRC [DST] [-p 5010] [-o h]
system"l tick/",(src:first .z.x,enlist"sym"),".q"
system"l tick/logging.q";
.log.conns:{}
if[not system"p";system"p 5010"]

\l tick/u.q

.u.start:.z.p;
.u.ticklog:{if["b"$((`minute$.z.p) > `minute$.u.start);.u.start:.z.p;.log.info (`Total_Messages; .u.i); .log.out each {(string x)," -- ","; " sv string raze .u.w[x]} each key .u.w; ]};

\d .u

ld:{if[not type key L::`$(-10_string L),string x;.[L;();:;()]];i::j::-11!(-2;L);if[0<=type i;-2 (string L)," is a corrupt log. Truncate to length ",(string last i)," and restart";exit 1];hopen L};

tick:{init[];d::.z.D;if[l::count y;L::`$":",y,"/",x,10#".";l::ld d]};

endofday:{end d;d+:1;if[l;hclose l;l::0(`.u.ld;d)]};
ts:{if[d<x;if[d<x-1;system"t 0";'"more than one day?"];endofday[]]};

system"t 1000";

.z.ts:{ts .z.D; ticklog[]};

upd:{[t;x]ts"d"$a:.z.P;
 f:key flip value t; pub[t;$[0<>type first x;x;flip f!x]];if[l;l enlist (`upd;t;x);i+:1];};

/----- FEED2 tickerplant modification code
/- upd function for accepting JSON data - special case for Feed2
/- x is a table in JSON format
updJSON:{[t;x]
  upd[t;enlist each value .j.k x];
 };

/- FEED3 tickerplant modification code
/- upd function for accepting csv data - special case for Feed3
/- x is a table in csv format
/- t must be initialized in CSVDict
/- getCSVConversionString uses the schema defined in sym.q to map the data to the correct format in q/kdb
getColumnTypes:{upper exec t from 0!meta x};
getColumnTypesFormatted:{"\"",getColumnTypes[x],"\""};

getCSVConversionString:{"(",getColumnTypesFormatted[x],";enlist \",\")"};

updCSV:{[t;x]
	/data:("SSDSS";enlist ",") 0: x;
	data:(value getCSVConversionString[t]) 0: x;
	upd[t;data];
 };

\d .

.u.tick[src;.z.x 1];

\
 globals used
 .u.w - dictionary of tables->(handle;syms)
 .u.i - msg count in log file
 .u.j - total msg count (log file plus those held in buffer)
 .u.t - table names
 .u.L - tp log filename, e.g. `:./sym2008.09.11
 .u.l - handle to tp log file
 .u.d - date
 .u.start - start time of tick

/test
>q tick.q
>q tick/ssl.q

/run
>q tick.q sym  .  -p 5010	/tick
>q tick/r.q :5010 -p 5011	/rdb
>q sym            -p 5012	/hdb
>q tick/ssl.q sym :5010		/feed
