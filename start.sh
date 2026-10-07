#!/bin/sh

set -eu

rsyslogd
cron

tail -f /var/log/syslog /var/log/cron.log
