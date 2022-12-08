## PHP
# Ubuntu20.04でApacheとPHP-FPMを使用して1つのサーバーで複数のPHPバージョンを実行する方法
# https://ja.getdocs.org/how-to-run-multiple-php-versions-on-one-server-using-apache-and-php-fpm-on-ubuntu-20-04

# Ubuntu 20.04 & Apache 2.4環境でHTTP/2 & FastCGIを実装
# https://world.203.jp/blog/post/1046

apt-get -y install software-properties-common
add-apt-repository -y ppa:ondrej/php

apt -y update

for ver in 5.6 7.4 8.1 ; do
  apt-get -y install php${ver} php${ver}-{apcu,cli,curl,fpm,gd,intl,mbstring,memcached,mysqlnd,opcache,pdo,xml,zip}
done

for ver in 5.6 7.4 8.1 ; do
  cp -p /etc/php/${ver}/fpm/pool.d/www.conf{,.default}
  cp -p /etc/php/${ver}/fpm/php.ini{,.default}
  cp -p /etc/php/${ver}/fpm/php-fpm.conf{,.default}
done

for ver in 5.6 7.4 8.1 ; do
  systemctl start php${ver}-fpm
done

apt -y install apache2 libapache2-mod-fcgid
cp -p /etc/apache2/apache2.conf{,.default}
cp -p /etc/apache2/ports.conf{,.default}

# Apache モジュールの有効化｜無効化
a2dismod php7.4
a2enmod proxy ssl rewrite alias
a2enmod proxy_fcgi

# Apache サイトの有効化｜無効化
# a2ensite sample-site.com
# a2dissite sample-site.com

# Apache テスト
apachectl configtest
systemctl restart apache2
systemctl restart mysqld
systemctl status apache2
systemctl enable apache2

## Nginx
apt -y install nginx
unlink /etc/nginx/sites-enabled/default

cp -p /etc/nginx/nginx.conf{,.default}
# nano /etc/nginx/sites-available/sample-site
# ln -s /etc/nginx/sites-available/sample-site /etc/nginx/sites-enabled/

# /etc/nginx
systemctl restart nginx
