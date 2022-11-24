# Intro
rsyslog base image for lab and ad-hoc use absed on rockylinux 8.6

# Standard rsyslog config
Standard config consists out of TCP and UDP listeners. TCP listener assumes connectivity done via TLS and present self-signed certificate by default.
```ruby
# Default TCP config
Input (type="imtcp" port="1514" ruleset="TCPDEFAULT")

Ruleset (name="TCPDEFAULT") {
    Action (type="omfile" file="/log/tcpdefault.log")
}
```
```ruby
# Default UDP config
Input (type="imudp" port="1514" ruleset="UDPDEFAULT")

Ruleset (name="UDPDEFAULT") {
    Action (type="omfile" file="/log/udpdefault.log")
}
```
    In case you would like to use own certificate trust chain, files under ```/log/cert``` should be replaced with new one by mofollowing naming convetion specifies below, otherwise default configuration file must be adjusted as well. Asusming log files under mount point ```/log```. 
```ruby
global(
    DefaultNetstreamDriver="gtls"
    DefaultNetstreamDriverCAFile="/log/cert/myCA.pem"
    DefaultNetstreamDriverCertFile="/log/cert/myCert.pem"
    DefaultNetstreamDriverKeyFile="/log/cert/myKey.key"
)
```
All custom configurations can be mounted under ```/etc/rsyslog.d/``` as usual for rsyslogd.

# Building and running

## k8s

```<TBD>```

## docker 

In order to build with self-signed cert support ```CERTSUBJ``` should be specified with preferred parameters.
```sh
docker build . -t rsyslog:latest
```
Running with default listener configuration on port 1514/tcp (TLS) and 1514/udp and self-signed ceritificate.
```sh
docker run -p 1514:1514/udp -p 1514:1514/tcp -e CERTSUBJ='/C=IT/ST=Lombardy/L=Vimercate/O=Nokia/OU=NI/CN=bootstrap/emailAddress=anton.zyablov@nokia.com' --name rsyslogd -d rsyslog:latest
```

