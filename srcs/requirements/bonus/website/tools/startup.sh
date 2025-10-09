#!/bin/bash

mkdir -p /data

if [ ! -f /data/tiddlywiki.info ]; then
    echo "Initializing new TiddlyWiki in /data..."
    tiddlywiki /data --init server
fi

exec "$@"