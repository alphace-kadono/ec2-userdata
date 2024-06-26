## MySQL
apt -y install mysql-server mysql-client

# 外部ホストからの接続を許可
# AWS セキュリティグループにて 3306 ポートを制限するため、ここではソースアドレスの設定は不要
cp -pn /etc/mysql/mysql.conf.d/mysqld.cnf{,.default}
sed -i 's/^bind-address.*$/bind-address = 0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

# sql_mode 変更 WordPress 対応
[ -f "/etc/mysql/mysql.conf.d/sql_mode.cnf" ] && cp -pn /etc/mysql/mysql.conf.d/sql_mode.cnf{,.default}
cat <<\_EOT_ >> /etc/mysql/mysql.conf.d/sql_mode.cnf
[mysqld]
# MySQL 8のmy.cnfでsql_modeを設定する
# https://tagsqa.com/detail/4989

# default
# ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
sql_mode = ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
_EOT_

systemctl enable mysql
systemctl restart mysql

## 以降は手動操作で
# 認証プラグインを指定してユーザーを作成する
# https://www.javadrive.jp/mysql/user/index9.html
# mysql -u root

# ユーザー作成
# CREATE USER 'sample_user'@'%' IDENTIFIED WITH mysql_native_password BY 'sample_password';
# GRANT ALL ON *.* TO 'sample_user'@'%';

# 確認
# SELECT user, host, plugin FROM mysql.user;
# DROP USER 'sample_user'@'%';
