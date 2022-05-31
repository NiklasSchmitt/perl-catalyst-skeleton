#!/bin/bash

# don't start as daemon so that docker knows that processes are running
CATALYST_DEBUG=1 /opt/pollenflug/script/pollenflug_fastcgi.pl -l :3000 -n $1 & 
apachectl -D FOREGROUND & 
wait -n
exit $?
