#!/bin/sh

function debian(){
    apt update
    apt upgrade -y
    apt install -y screen sudo cron-apt rsyslog git
    apt remove sshd
    ssh-keygen -t ecdsa
    git clone git@github.com:it-bgk/central-log-container.git
}

function ubuntu(){
    debian()
}

### MAIN ###
case $(cat /etc/os-release|grep NAME|cut -d = -f 2)
    "Ubuntu":
        echo "OS: Ubuntu, detected."
        ubuntu()
        break;
        ;;
    "Debian":
        echo "OS: Debian, detected."
        debian()
        break;
        ;;
    *):
        echo "Sorry I cannot detect your OS. Please make the steps manual."
esac