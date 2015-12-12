FROM ubuntu
MAINTAINER Joshua Griffith <j.griffith@facilitrak.com>

RUN apt-get update \
    && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config

COPY bootstrap /bin/

ENV AUTHORIZED_KEYS ""
EXPOSE 22
CMD ["/bin/bootstrap"]
