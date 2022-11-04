#!/bin/bash
KEYFILE=/log/cert/myKey.key
CERTFILE=/log/cert/myCert.pem
if [ ! -f "$KEYFILE" ] | [ ! -f "$CERTFILE" ] ; then
    echo "Generating self-signed certificate since no cert and/or key are provided."
    echo "Certificate subject: "$CERTSUBJ
    openssl req -x509 \
    -newkey rsa:4096 \
    -keyout $KEYFILE \
    -out $CERTFILE \
    -sha256 \
    -days 3650 \
    -batch \
    -nodes \
    -subj $CERTSUBJ
    /sbin/rsyslogd -n
fi