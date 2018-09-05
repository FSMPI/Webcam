#!/bin/bash

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'WEBCAM_USER'
file_env 'WEBCAM_PASSWORD'

ffmpeg -f mjpeg -i "http://$WEBCAM_USER:$WEBCAM_PASSWORD@olaf.fs.uni-bayreuth.de/video.cgi" -framerate 30 -vcodec libx264 -acodec aac -preset veryfast -tune zerolatency -g 48 -crf 25 -f flv rtmp://rtmpserver/live/stream
