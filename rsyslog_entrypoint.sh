#!/bin/bash
KEYFILE=/cert/myKey.key
CERTFILE=/cert/myCert.pem
if [ ! -f "$KEYFILE" ] | [ ! -f "$CERTFILE" ] ; then
    echo "Generating self-signed certificate since no cert and/or key are provided."
    echo "Certificate subject: "$CERTSUBJ
    openssl req -x509 \
    -newkey rsa:4096 \
    -keyout /cert/myKey.key \
    -out /cert/myCert.pem \
    -sha256 \
    -days 3650 \
    -batch \
    -nodes \
    -subj $CERTSUBJ
    /sbin/rsyslogd -n
fi