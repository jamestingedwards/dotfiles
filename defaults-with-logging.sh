#!/bin/bash
# Defaults - a script to record important changes to the system

lf=${HOME}/Library/Logs/com.defaults.log
function log() { echo "$(date "+%Y-%m-%d %H:%M:%S") bash $@" &gt;&gt; ${lf}; }

if [[ ! ${1} ]]; then
    echo "This is the script version of defaults.  Run /usr/bin/defaults to see help"
    exit 1
fi
if [[ (${1} == write) || (${1} == delete) ]]; then
    op=${1}; dom=${2}; key=${3}; shift; shift; shift; args="${@}"
    [[ (${op} == write) &amp;&amp; ("${args}" == "") ]]  &amp;&amp; args='""'
    log "${USER} executed defaults ${op} ${dom} ${key} ${args}"
    logger "${USER} executed defaults ${op} ${dom} ${key} ${args}"
    log "existing value: \"$(/usr/bin/defaults read ${dom} ${key})\""
    logger "existing value: \"$(/usr/bin/defaults read ${dom} ${key})\""
    /usr/bin/defaults ${op} ${dom} ${key} ${args}
    log "new value: \"$(/usr/bin/defaults read ${dom} ${key})\""
    logger "new value: \"$(/usr/bin/defaults read ${dom} ${key})\""
else
    /usr/bin/defaults $@
fi
