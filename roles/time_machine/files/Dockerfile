FROM debian:latest

RUN apt-get update -y &&\
 apt-get install -y netatalk &&\ 
 apt-get install -y avahi-daemon

COPY afp.conf /etc/netatalk/afp.conf

ENV TIME_MACHINE_PASSWORD="time-machine"

RUN groupadd time-machine &&\
    useradd -g time-machine time-machine

CMD echo -e "${TIME_MACHINE_PASSWORD}\n${TIME_MACHINE_PASSWORD}\n" | (passwd time-machine)
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]