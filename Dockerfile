FROM yexianyi/oracle-jdk:centos7
RUN yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y \
    && yum -y install tigervnc-server \
    && cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
