//Logging Script
//Start-up q

.log.out:{-1 x};
.log.err:{-2 x};
.log.info:{.log.out[raze " -- " sv {$[10=abs type x;x;string x]} each x]};
.log.query:{@[.log.out;[raze "Query Sent: ",x];.log.out raze "N/A"]};
.log.Qw:{.log.out[raze ".Q.w[] output:","," sv string value x]};

.z.po:{
    .log.info (`Connection_Opened ;.z.w;.z.u;.z.p);
 };

.z.pc:{
    .log.info (`Connection_Closed;.z.w;.z.p);
    1b
 };

.z.pg:{ ip:(`$raze "."  sv string "i"$0x0 vs .z.a); .log.info ("INFO";.z.p;`Sync_Query;.z.u;ip); .log.Qw .Q.w[]; .log.query x;value x};

.z.ps:{ip:(`$raze "."  sv string "i"$0x0 vs .z.a); .log.info ("INFO";.z.p;`ASync_Query;.z.u;ip); .log.Qw .Q.w[]; .log.query x;value x};

 