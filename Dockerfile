FROM yexianyi/systemd:latest
ENV container docker
RUN yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y \
    && yum -y install tigervnc-server

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
