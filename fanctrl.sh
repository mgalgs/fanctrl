#!/bin/bash

set -e

proggie=$(basename $0)

usage()
{
    echo "Usage: $proggie <on|off|status>"
}

[[ "$1" = "-h" || "$1" = "--help" || $# -ne 1 ]] && { usage; exit 1; }

cd /sys/class/gpio
[[ -e gpio23 ]] || echo 23 > export
cd gpio23
[[ $(cat direction) = out ]] || echo out > direction

cmd=$1

case $cmd in
    on)
	echo 1 > value
	echo "turned fan on"
	;;
    off)
	echo 0 > value
	echo "turned fan off"
	;;
    status)
	val=$(cat value)
	case $val in
	    0) echo off ;;
	    1) echo on ;;
	    *) echo "unknown: $val" ;;
	esac
	;;
    *)
	echo "Unkown command"; usage; exit 1;
	;;
esac
