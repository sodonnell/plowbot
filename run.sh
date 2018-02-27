#!/usr/bin/env bash
#
# Execute this script to launch the x0dbot process and real-time
# logging into the background. You may use the -f flag to follow 
# the log file in real-time using the 'tail' command.
#
# Sean O'Donnell <sean@seanodonnell.com>
# https://github.com/sodonnell
#
SCRIPT=plowbot
SCRIPT_LOG=/var/log/plowbot.log

echo -e "Running the program ($SCRIPT) into the background...\n"

./$SCRIPT $1 2>&1 >> $SCRIPT_LOG &

echo -e "Done.\n"

if [ $2 -e "-f" ]; then
	echo -e "Following log file ($SCRIPT_LOG)...\n\n"
	tail -f $SCRIPT_LOG
fi
