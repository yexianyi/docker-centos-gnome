FROM yexianyi/oracle-jdk:centos7

RUN yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y \
    && yum -y install tigervnc-server \
    && cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/\/home\/<USER>/\/root/g' /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/<USER>/root/g' /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/800x600/1600x900/g' /usr/bin/vncserver \
    && sed -i 's/#$depth = 16/$depth = 32/g' /usr/bin/vncserver \
    && sh -c "yes 123456| vncpasswd" && echo "root:123456" | chpasswd \
    
EXPOSE 5901 5902 5903 5904 5905 5906
VOLUME [ "/sys/fs/cgroup" ]
CMD systemctl daemon-reload && systemctl stop firewalld && systemctl start vncserver@:1.service
