JOB_NAME=FEED3
LOG_DIR=$(pwd)/LOGS/


STDOUTFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").log
STDERRFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").error

q 1-Feeds/Feedhandlers/feed3.q -p 8002 </dev/null > "${STDOUTFILE}" 2> "${STDERRFILE}" &