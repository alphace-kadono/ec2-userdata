## PHP
# Ubuntu20.04でApacheとPHP-FPMを使用して1つのサーバーで複数のPHPバージョンを実行する方法
# https://ja.getdocs.org/how-to-run-multiple-php-versions-on-one-server-using-apache-and-php-fpm-on-ubuntu-20-04

# Ubuntu 20.04 & Apache 2.4環境でHTTP/2 & FastCGIを実装
# https://world.203.jp/blog/post/1046

apt-get -y install software-properties-common
add-apt-repository -y ppa:ondrej/php

apt -y update

for ver in 5.6 7.4 8.1 8.3 ; do
  apt-get -y install php${ver} php${ver}-{apcu,cli,curl,fpm,gd,intl,mbstring,memcached,mysqlnd,opcache,pdo,xml,zip,imagick}
done

for ver in 5.6 7.4 8.1 8.3 ; do
  cp -pn /etc/php/${ver}/fpm/pool.d/www.conf{,.default}
  cp -pn /etc/php/${ver}/fpm/php.ini{,.default}
  cp -pn /etc/php/${ver}/fpm/php-fpm.conf{,.default}
done

for ver in 5.6 7.4 8.1 8.3 ; do
  systemctl enable php${ver}-fpm
  systemctl start php${ver}-fpm
done

## Apache
apt -y install apache2 libapache2-mod-fcgid
cp -pn /etc/apache2/apache2.conf{,.default}
cp -pn /etc/apache2/ports.conf{,.default}
cp -pn /etc/apache2/conf-available/security.conf{,.default}

mkdir -p /etc/apache2/include/
cat << 'EOF' > /etc/apache2/include/vhosts.conf
Protocols h2 http/1.1
SetEnvIf X-Forwarded-Proto "https" HTTPS=on
EOF

# Apache 設定の有効化
a2enconf php7.4-fpm

# Apache モジュールの有効化
a2enmod alias headers proxy proxy_fcgi rewrite
# a2dismod ssl # Nginx Proxy を使用するので SSL は不要

# Apache サイトの有効化｜無効化
a2dissite 000-default
# a2ensite sample

systemctl enable apache2
systemctl restart apache2

# Apache テスト
# apachectl configtest
# systemctl restart mysqld
# systemctl status apache2

## Nginx
apt -y install nginx
# unlink /etc/nginx/sites-enabled/default

cp -pn /etc/nginx/nginx.conf{,.default}
# nano /etc/nginx/sites-available/sample-site
# ln -s /etc/nginx/sites-available/sample-site /etc/nginx/sites-enabled/

systemctl enable nginx
systemctl restart nginx

# Let's Encriptでワイルドカード証明書を取得
# https://rapicro.com/certbot-lets-encript-wildcard-certificate/
snap install core && snap refresh core
snap install --classic certbot
# ln -nfs /snap/bin/certbot /usr/bin/certbot
