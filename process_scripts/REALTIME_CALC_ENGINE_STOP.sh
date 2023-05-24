PIDS=`ps -ef | grep RealtimeCalcEngine.q | awk '{print$2}'`
for i in $PIDS; do echo Killing proccess with PID=$i; kill -15 $i; done

sleep 5

PIDS=`ps -ef | grep RealtimeCalcEngine.q | awk '{print$2}'`
for i in $PIDS; do echo Killing proccess with PID=$i; kill -9 $i; done
