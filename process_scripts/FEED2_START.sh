JOB_NAME=FEED2
LOG_DIR=$(pwd)/LOGS/


STDOUTFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").log
STDERRFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").error

q 1-Feeds/Feedhandlers/feed2.q -p 8001 </dev/null > "${STDOUTFILE}" 2> "${STDERRFILE}" &