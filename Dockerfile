FROM rockylinux:8.6
LABEL maintainer="anton.zyablov@nokia.com"\
    org.label-schema.name="azyablov/rsyslogd"\
    org.label-schema.description="rsyslogd base image"\
    org.label-schema.vendor="Anton Zyablov, Nokia"\
    org.label-schema.version="0.2"\
    org.label-schema.schema-version="1.0"\
    org.label-schema.docker.cmd="docker run -p 1514:1514/udp -p 1514:1514/tcp --name rsyslogd -d rsyslog:latest" 
# Default subject for development and testpurposes, could replaced with specific one in case self signed cert customisation is needed.
# Normally /cert supposed to be mounted and contain myCert.pem and myKey.key files to enable TLS
ENV CERTSUBJ="/C=IT/ST=Lombardy/L=Monza/O=Nokia/OU=NI/CN=bootstrap/emailAddress=anton.zyablov@nokia.com"
RUN yum install rsyslog openssl rsyslog-gnutls -y
RUN mkdir /cert
COPY rsyslog.conf /etc/rsyslog.conf
COPY conf/udpdefault.conf /etc/rsyslog.d/udpdefault.conf
COPY conf/tcpdefault.conf /etc/rsyslog.d/tcpdefault.conf
COPY rsyslog_entrypoint.sh /
RUN chmod a+x /rsyslog_entrypoint.sh
EXPOSE 1514/tcp
EXPOSE 1514/udp
VOLUME [ "/cert" ]
VOLUME [ "/log" ]
ENTRYPOINT [ "/rsyslog_entrypoint.sh"]
