#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color



echo "Running as root..."
sleep 2
clear


opkg update

opkg install asterisk asterisk-chan-sip asterisk-bridge-simple asterisk-codec-alaw asterisk-codec-ulaw asterisk-res-rtp-asterisk

rm /etc/asterisk/extensions.conf
>/etc/asterisk/pjsip.conf

cd /etc/asterisk/

wget https://raw.githubusercontent.com/hassan4mz/sip-server-router/main/extensions.conf

echo "[simpletrans]
 transport=tls,tcp,udp
 bindport=5060
 bindaddr=0.0.0.0
 nat=no
 language=en
 allowguest=yes
 srvlookup=no
 disallow=all
 allow=ulaw
 allow=alaw
 allow=gsm
 dateformat=%F %T
 alwaysauthreject=yes
 localnet=192.168.1.1/255.255.255.0 ;; change this according to your LAN configuration
 localnet=127.0.0.0/255.255.255.0
 tcpbindaddr=0.0.0.0
 tcpenable=yes
 jbenable=yes
 jbforce=yes
 jbmaxsize=250
 jbimpl=adaptive
 jbtargetextra=40
 jblog=no

" >> /etc/asterisk/pjsip.conf

uci set asterisk.general.enabled='1'

service asterisk restart

sleep 1

service asterisk restart

sleep 1

service asterisk restart

cd

rm -f gip.sh && wget https://raw.githubusercontent.com/hassan4mz/sip-server-router/sip/gip.sh && chmod 777 gip.sh

cp gip.sh /sbin/gip

echo -e "${GREEN} Made With Love By : Egywrt.EG ${NC}"
