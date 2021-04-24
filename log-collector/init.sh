#!/bin/sh
[ "$1" = "-debug" ] && set -x

BASE="/opt/central-log-container"
DATA_STORE="/data"

func_debian(){
    echo "Update System" && sleep 2 && apt update 
    echo "Upgrade System" && sleep 2 && apt upgrade -y
    echo "Install Dependencies" && sleep 2 && apt install -y screen sudo cron-apt rsyslog git wget apt-transport-https gnupg2
    # Beats for own system monitoring:
    echo "Install [File|Audit]beat for system monitoring "
    sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    [ ! -f /etc/apt/sources.list.d/elastic-7.x.list ] && echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
    sudo apt update
    echo "Install Auditbeat"
    sudo apt install auditbeat
    sudo systemctl enable auditbeat
    echo "Install Filebeat"
    sudo apt install filebeat
    sudo systemctl enable filebeat


    func_for_all
}

func_ubuntu(){
    func_debian
}

func_centos(){
    echo "Not implemented at the moment, please do it manually."
}

func_for_all() {
    [ ! -f ~/.ssh/id_ecdsa ] && echo "Create SSH-Keygen for Git" && sleep 2 && ssh-keygen -t ecdsa
    [ ! -d "$BASE" ] && echo "Clone Git repo" && sleep 2 && git clone https://github.com/it-bgk/central-log-container.git "$BASE"
    echo "Copy rsyslog config" && sleep 2 && cp "$BASE/log-collector/rsyslog.conf" "/etc/rsyslog.d/central-log-container.conf"
    echo "Copy Filebeat config" && sleep 2 && cp "$BASE/filebeat/filebeat_config_file.yml" "/etc/filebeat/filebeat.conf"
    echo "Copy Auditbeat config" && sleep 2 && cp "$BASE/auditbeat/auditbeat_config_file.yml" "/etc/auditbeat/auditbeat.conf"
    [ ! -e /var/log/filebeat ] && echo "Make symbolic link for filebeat" && sleep 2 && mkdir "$DATA_STORE/filebeat" && ln -s "$DATA_STORE/filebeat" /var/log/filebeat
    [ ! -e /var/log/auditbeat ] && echo "Make symbolic link for auditbeat" && sleep 2 && mkdir "$DATA_STORE/auditbeat" && ln -s "$DATA_STORE/auditbeat" /var/log/auditbeat
}

### MAIN ###
case "$(grep ^ID= /etc/os-release|cut -d = -f 2)" in
    ubuntu)
        echo "OS: Ubuntu, detected."
        echo
        func_ubuntu
        ;;
    debian)
        echo "OS: Debian, detected."
        echo
        func_debian
        ;;
    centos)
        echo "OS: CentOS, detected."
        echo
        ;;
    *):
        echo "Sorry I cannot detect your OS. Please make the steps manual."
esac