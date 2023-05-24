JOB_NAME=TICK
LOG_DIR=$(pwd)/LOGS


STDOUTFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").log
STDERRFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").error

q tick/tick.q sym . -p 5001 </dev/null > "${STDOUTFILE}" 2> "${STDERRFILE}" &
