#!/bin/bash
#https://repo.saltstack.com/2016.11.html#ubuntu
#salt_release="2016.11"

package=$1

if [ $# -ne 1 ]; then
	echo "$0 [salt-master|salt-minion]"
	exit 1
fi

masterip="192.168.40.11"
#egrep -q "^([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})(\s)+salt$" /etc/hosts || sudo sh -c 'echo 192.168.40.11 salt >> /etc/hosts'
egrep -q "^${masterip}(\s)+salt$" /etc/hosts || sudo sh -c "echo $masterip salt >> /etc/hosts"


CENTOS_RELEASE="/etc/centos-release"
if test -f ${CENTOS_RELEASE} ; then
    if egrep -q "^CentOS Linux release 7" ${CENTOS_RELEASE} ; then
        OS=Centos7
        package="salt-repo-2016.11-2.el7.noarch.rpm "
        service_restart="systemctl restart salt-minion"
    elif egrep -q "^CentOS release 6" ${CENTOS_RELEASE} ; then
        OS=Centos6
        package="salt-repo-2016.11-2.el6.noarch.rpm"
        service_restart="service salt-minion restart"
    else
        OS='unknonwn'
        echo "non supported CentOS release."
        exit 1
    fi
    if ! rpm -qi salt-minion > /dev/null ; then
        yum install -y  https://repo.saltstack.com/yum/redhat/$package
        yum clean expire-cache
        yum install -y salt-minion
        $service_restart
    fi
else
  dpkg -l | egrep -q "^ii\s+$package" && exit 0

  apt-key list | egrep -iq saltstack || wget -O - https://repo.saltstack.com/apt/ubuntu/$(lsb_release -r -s)/amd64/2016.11/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://repo.saltstack.com/apt/ubuntu/$(lsb_release -r -s)/amd64/2016.11 $(lsb_release -c -s) main" > /etc/apt/sources.list.d/saltstack.list'
  sudo apt-get update
  sudo apt-get install -y $package
fi
