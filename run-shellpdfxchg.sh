#!/bin/bash

CONTNAME="pdfxchg-wine"

docker rm pdfxchg-wine &>/dev/null; \
docker run --name pdfxchg-wine \
--rm -ti \
-v $HOME:/mnt \
--net="none" \
-e H="$HOME" \
-e DISPLAY="$DISPLAY" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
pdfxchg-wine /bin/bash
