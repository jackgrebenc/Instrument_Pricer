JOB_NAME=REALTIME_CALC_ENGINE
LOG_DIR=$(pwd)/LOGS/


STDOUTFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").log
STDERRFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").error

q 3-avgPrice/RealtimeCalcEngine.q :5013 -p 5014 </dev/null > "${STDOUTFILE}" 2> "${STDERRFILE}" &
