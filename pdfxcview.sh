#!/bin/bash

IFS=""
let monitor=0

while getopts 'm' OPTION
do
	case $OPTION in
		m)
			monitor=1
			;;
	esac
done

shift $(($OPTIND - 1))

env WINEPREFIX="$HOME/.wine" wine start /ProgIDOpen PDF-XChangeViewer.1 "/mnt/${1#*$H}"

if [ $monitor -eq 1 ]
then
	while (( 1 ))
	do
		if pgrep -f PDFXCview.exe &>/dev/null
		then
			sleep 2
		else
			exit 0	
		fi
	done
else
	exit 0
fi
