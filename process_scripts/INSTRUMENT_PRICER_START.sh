#!/bin/bash

JOB_NAME=INSTRUMENT_PRICER
LOG_DIR=$(pwd)/LOGS/


STDOUTFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").log
STDERRFILE=$LOG_DIR/$JOB_NAME.$(date +"%F").error

q 2-Pricer/InstrumentPricer.q :5001 -p 5013 </dev/null > "${STDOUTFILE}" 2> "${STDERRFILE}" &

