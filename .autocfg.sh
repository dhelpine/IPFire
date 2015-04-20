#!/usr/bin/bash
OPENSSL=/usr/bin/openssl
SSLDIR=/tmp/generatedCA
echo
echo -e "\e[95m~ SSL Bump autoconfig script ~\e[0m"
echo
echo -e "\e[32mStopping web proxy service if running...\e[0m"
squidctrl stop
echo -e "\e[32mDownloading extra configurations...\e[0m"
wget -q http://pastebin.com/raw.php?i=PN6KQDVJ -O /etc/squid/squid.conf.pre.local
wget -q http://pastebin.com/raw.php?i=0WqjpwXN -O /etc/squid/storeid
chmod +x /etc/squid/storeid
echo -e "Initializing certificates database...\e[0m"
/usr/lib/squid/ssl_crtd -c -s /var/ipfire/ssl_db
chown -R squid:squid /var/ipfire/ssl_db
echo -e "\e[32mCreating self-signed certificate, please provide correct information on next step...\e[0m"
mkdir -p $SSLDIR || exit 1
rm -rf $SSLDIR/*
[ -e $SSLDIR/squid.key ] || $OPENSSL genrsa 4096 > $SSLDIR/squid.key
[ -e $SSLDIR/squid.pem ] || $OPENSSL req -new -x509 -days 3650 -key $SSLDIR/squid.key -out $SSLDIR/squid.pem
[ -e $SSLDIR/client.crt ] || $OPENSSL x509 -in $SSLDIR/squid.pem -outform DER -out $SSLDIR/client.crt
mkdir -p  /etc/squid/certs || exit 1
cp $SSLDIR/squid.key /etc/squid/certs
cp $SSLDIR/squid.pem /etc/squid/certs
cp $SSLDIR/client.crt /srv/web/ipfire/html/
echo -e "\e[31mDone! Do NOT forget to set iptables to support HTTPS interception!\e[0m"
echo -e "\e[31mDouble- or triple- check your web proxy configuration before you start web proxy service!\e[0m"
