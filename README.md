# Intro
rsyslog base image for lab and ad-hoc use absed on rockylinux 8.6

# Standard config


# Building and running

## k8s

## docker 

In order to build with self-signed cert support ```CERTSUBJ``` should be specified with preferred parameters.
```sh
docker build . -t rsyslog:latest
```
Running with default listener configuration on port 1514/tcp (TLS) and 1514/udp and self-signed ceritificate.
```sh
docker run -p 1514:1514/udp -p 1514:1514/tcp -e CERTSUBJ='/=IT/ST=Lombardy/L=Vimercate/O=Nokia/OU=NI/CN=bootstrap/emailAddress=anton.zyablov@nokia.com' --name rsyslogd -d rsyslog:latest
```

