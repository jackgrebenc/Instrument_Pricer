JOB_NAME=FEED1
LOG_DIR=$(pwd)/LOGS/


STDOUTFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").log
STDERRFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").error

q 1-Feeds/Feedhandlers/feed1.q -p 8000 </dev/null > "${STDOUTFILE}" 2> "${STDERRFILE}" &