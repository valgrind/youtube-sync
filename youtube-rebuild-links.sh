#!/bin/bash

if [ -z "$1" ]; then
	>&2 echo "Missing sync directory name."
	exit 1
fi

mkdir -p SYNC/$1/LINK

if [ ! -d SYNC/$1/META ]; then
	>&1 echo "Error: /META directory doesn't exist for $1"
	exit 1
fi

rm SYNC/$1/LINK/*.mkv

for titlepath in SYNC/$1/META/*.title; do
	read -r TITLE < $titlepath
	if [[ "$titlepath" =~ /([^/]+)\.title$ ]]; then
		ID=${BASH_REMATCH[1]};
		echo "Creating link: $ID -> $TITLE.$ID.mkv"
		ln -s "../ID/$ID.mkv" "SYNC/$1/LINK/$TITLE.$ID.mkv"
	fi
done
