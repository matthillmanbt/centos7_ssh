FROM centos:centos7

ARG username=mhillman

RUN yum install -y openssh-server

RUN useradd $username

USER $username
RUN mkdir /home/$username/.ssh && chmod 700 /home/$username/.ssh
COPY authorized_keys /home/$username/.ssh

USER root

CMD [ "sh", "-c", "ssh-keygen -A && /usr/sbin/sshd -E /tmp/sshd.log && tail -F /tmp/sshd.log" ]
