# ec2-userdata
amazon ec2 userdata

### e.g. for Ubuntu
```
#!/bin/bash -ex

# user-data.log ファイルに保存
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2> /dev/console) 2>&1

baseUrl="https://raw.githubusercontent.com/alphace-kadono/ec2-userdata/main/ubuntu"
curl ${baseUrl}/common.sh | bash
curl ${baseUrl}/swap.sh | bash
curl ${baseUrl}/apache-php.sh | bash
curl ${baseUrl}/mysqld.sh | bash
curl ${baseUrl}/docker.sh | bash
```
