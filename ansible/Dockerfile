FROM  rockylinux:8
#FROM oraclelinux:8
LABEL maintainer="MTA"


# Systemd install
RUN dnf -y update && dnf clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN dnf -y install \
           git \
           python38 \
           python38-pip \
           python3-jmespath \
           sudo \
           openssh-server \
           openssh-clients \
           unzip \
           tar \
           rsync \
           fuse-libs \
           && dnf clean all

RUN python3.8 -m pip install --upgrade pip 
RUN python3.8 -m pip install ansible-core==2.12
#RUN python3.8 -m pip install ansible
RUN ln -s /usr/local/bin/ansible* /usr/bin/
RUN pip3  install jmespath

RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

RUN mkdir /etc/ansible && echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts


RUN groupadd -g 9999 cdp
RUN useradd -u 9999 cdp -g cdp


RUN su - cdp -c  "ssh-keygen -t rsa -b 1024 -f /home/cdp/.ssh/id_rsa"

RUN echo "%cdp ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers



COPY ./id_rsa /workdir/id_rsa
COPY ./id_rsa.pub /workdir/id_rsa.pub


RUN su - cdp -c  "cat /workdir/id_rsa > /home/cdp/.ssh/id_rsa"
RUN su - cdp -c  "cat /workdir/id_rsa.pub > /home/cdp/.ssh/id_rsa.pub"
RUN su - cdp -c  "cat /workdir/id_rsa.pub > /home/cdp/.ssh/authorized_keys"
RUN sudo su - cdp -c "chmod g-w /home/cdp/.ssh/authorized_keys"

RUN chown cdp:cdp /projects

VOLUME ["/sys/fs/cgroup"]
USER cdp
WORKDIR /projects
CMD ["/usr/sbin/init"]

