FROM yexianyi/oracle-jdk:centos7

RUN yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y \
    && yum -y install tigervnc-server \
    && cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/\/home\/<USER>/\/root/g' /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/<USER>/root/g' /etc/systemd/system/vncserver@:1.service \
    && sed -i 's/800x600/1600x900/g' /usr/bin/vncserver \
    && sed -i 's/#$depth = 16/$depth = 32/g' /usr/bin/vncserver \
    && sh -c "yes 123456| vncpasswd" && echo "root:123456" | chpasswd \
    #set locale
    && echo 'LANG="en_US.UTF-8"' >> /etc/environment \
    && echo 'LC_ALL=' >> /etc/environment \
    && source /etc/environment \
    && echo 'LANG="en_US.UTF-8"' >> /etc/sysconfig/i18n \
    && echo 'SYSFONT="latarcyrheb-sun16"' >> /etc/sysconfig/i18n \
    && localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
    
EXPOSE 5901 5902 5903 5904 5905 5906
VOLUME [ "/sys/fs/cgroup" ]
ENTRYPOINT ["/usr/sbin/init"]
CMD systemctl daemon-reload && systemctl stop firewalld && systemctl start vncserver@:1.service
