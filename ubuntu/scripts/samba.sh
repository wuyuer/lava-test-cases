#!/bin/bash

#    Authot : xiayanhui
#    E-mail : xiayanhui@aliyun.com
#    Desc   : Auto install samba and deploy samba enviroment
#    Date   : 2015.11.09

sudo apt-get update

sudo apt-get install samba -y

#create a folder that used for samba's share
if [ ! -d /opt/share ]
then
mkdir /opt/share
fi

chmod 777 /opt/share

cat >> /etc/samba/smb.conf << EOM

[share]
   comment = Root Directories
   browseable = yes
   writeable = yes
   path = /opt/share
   valid users = smb 

EOM

sudo useradd -p "TM7puIzyDTKxc" smb
#sudo useradd -p "TM7puIzyDTKxc" smb
#sudo smbpasswd -a smb

#change the password of samba user
{
#sleep 1s
echo  smb
sleep 0s
echo smb
} | smbpasswd -a smb 1>/dev/null 2>&1

sudo /etc/init.d/smbd restart

#Create a text file in share folder to explain samba server had been deploy
if [ ! -f /opt/share/readme.txt ]
then
touch /opt/share/readme.txt
fi

#echo "if you can see this message ,the samba server had deploy at the board" >/opt/share/readme.txt
lava-test-case samba-test  --result pass 


