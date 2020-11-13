!/bin/bash

# https://github.com/odarriba/docker-timemachine

#The Docker command, i’m restarting the docker container always unless explicitly stopped and /mnt/exthdd is my USB Drive mapped in CentOS.
#Using image from Docker Hub odarriba/timemachine
docker run -h time-machine \
  —name time-machine \
  —restart=unless-stopped \
  -d -it \
  -v //mnt/exthdd/timemachine:/timemachine \
  -p 548:548 \
  -p 636:636 \
  odarriba/timemachine

#Setup the firewall on CentOS7 to allow the required ports through to the Docker image.
firewall-cmd — add-port=548/tcp — permanent
firewall-cmd — zone=public — permanent — add-port=548/udp
firewall-cmd — zone=public — permanent — add-port=5353/tcp
firewall-cmd — zone=public — permanent — add-port=5353/udp
firewall-cmd — zone=public — permanent — add-port=49152/tcp
firewall-cmd — zone=public — permanent — add-port=49152/udp
firewall-cmd — zone=public — permanent — add-port=52883/tcp
firewall-cmd — zone=public — permanent — add-port=52883/udp
firewall-cmd — add-port=636/tcp — permanent
firewall-cmd — reload
firewall-cmd — list-all

#Enter the USERNAME and PASSWORD used to access the SHARENAME
#USERNAME, PASSWORD and SHARENAME are to che changed by you.

#If you look at the Docker line above we have mapped /mnt/exthdd to /timemachine in the Docker container, so the path below must contain /timemachine
docker exec timemachine add-account USERNAME PASSWORD SHARENAME /timemachine/macbookpro

#This section will setup the underlying AFP service on CentOS
cat >> /etc/avahi/services/afpd.service << EOF
<?xml version=”1.0" standalone=’no’?>
<!DOCTYPE service-group SYSTEM “avahi-service.dtd”>
<service-group>
<name replace-wildcards=”yes”>%h</name>
<service>
<type>_afpovertcp._tcp</type>
<port>548</port>
</service>
<service>
<type>_device-info._tcp</type>
<port>0</port>
<txt-record>model=Xserve</txt-record>
</service>
</service-group>
EOF

#Suggest just copy and replace the existing host entry
change /etc/nsswitch.conf to
hosts: files mdns4_minimal dns mdns mdns4

#restart the listening service
systemctl enable avahi-daemon
systemctl restart avahi-daemon