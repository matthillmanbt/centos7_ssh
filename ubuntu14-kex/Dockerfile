FROM ubuntu:trusty

ARG username=mhillman

RUN apt update
RUN apt install -y openssh-server

RUN useradd -m $username

USER $username
RUN mkdir /home/$username/.ssh && chmod 700 /home/$username/.ssh
COPY authorized_keys /home/$username/.ssh

USER root

# the builtin "tail" is too old to work in docker… so… download and build a coreutils version that will work
RUN apt install -y build-essential
RUN wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.gz && tar -xf coreutils-8.32.tar.gz -C /root
ENV FORCE_UNSAFE_CONFIGURE 1
RUN cd /root/coreutils-8.32/ && ./configure --prefix=/root/coreutils --libexecdir=/root/coreutils/lib --enable-no-install-program=kill,uptime && make && make install
RUN mkdir -p /var/run/sshd && chmod 0755 /var/run/sshd

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /coreutils-8.32.tar.gz

RUN echo "" >> /etc/ssh/sshd_config
RUN echo "MACs hmac-md5" >> /etc/ssh/sshd_config
RUN echo "KexAlgorithms diffie-hellman-group14-sha1" >> /etc/ssh/sshd_config
RUN echo "" >> /etc/ssh/sshd_config

RUN tail -n 5 /etc/ssh/sshd_config

CMD [ "sh", "-c", "ssh-keygen -A && /usr/sbin/sshd -E /tmp/sshd.log && /root/coreutils/bin/tail -F /tmp/sshd.log" ]
