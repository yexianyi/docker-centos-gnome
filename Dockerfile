FROM yexianyi/oracle-jdk:centos7
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#RUN yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y \
RUN yum -y install tigervnc-server \
    && cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/\/home\/<USER>/\/root/g' /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/<USER>/root/g' /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/800x600/1600x900/g' /usr/bin/vncserver \
    && sed -i 's/#$depth = 16/$depth = 32/g' /usr/bin/vncserver \
    && sh -c "yes 123456| vncpasswd" && echo "root:123456" | chpasswd
    
    && systemctl daemon-reload \
    && systemctl stop firewalld 
    #&& systemctl start vncserver@:1.service

EXPOSE 5901 5902 5903 5904 5905 5906
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
