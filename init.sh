#!/bin/bash

# permission check
touch /root/test || exit

CDIR=$(cd `dirname ${0}` && pwd)
FNAME=tk-github-browse-stars.sh

BIN=/usr/local/bin

cd "${BIN}"

ln -sf "$CDIR/$FNAME"
