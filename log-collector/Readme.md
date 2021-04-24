Log-Collector
=============

You can have one or more of them.
It is the device which receives the logs from hosts, make a further processing and send it to SIEM.

# Installation
```
# Installa dependency:
apt install -y curl
# Start Init script...
bash <(curl -Ss https://raw.githubusercontent.com/it-bgk/central-log-container/log-collector/init.sh)
# or if you need debug output:
bash <(curl -Ss https://raw.githubusercontent.com/it-bgk/central-log-container/log-collector/init.sh) -debug
# or if you want to use dev version:
bash <(curl -Ss https://raw.githubusercontent.com/it-bgk/central-log-container/dev/log-collector/init.sh)
```


# Source
- https://www.netdata.cloud/get-netdata/