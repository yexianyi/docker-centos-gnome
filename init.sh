#!/bin/bash
/usr/sbin/init
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
systemctl daemon-reload
systemctl stop firewalld
systemctl start vncserver@:1.service
