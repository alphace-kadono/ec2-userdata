# Ubuntu 22.04 LTSの SSH サービスにて ssh-rsa はデフォルトで無効にされている
# 暫定的に ssh-rsa を有効にしておく
# https://zenn.dev/noraworld/articles/ssh-rsa-sha1-disabled
cp -pn /etc/ssh/sshd_config{,.default}
sed -i '1s/^/PubkeyAcceptedAlgorithms=+ssh-rsa\n/' /etc/ssh/sshd_config
systemctl restart ssh

# タイムゾーン
timedatectl set-timezone Asia/Tokyo

apt -y update
apt -y upgrade

## 2022/10/06(木) 18:41
# alphace.2022.pem に変更 → Ed25519 鍵

# Ubuntu でアップグレードした場合の警告表示を無効化する
# https://sig9.org/archives/4580
cat << 'EOF' > /etc/needrestart/conf.d/99_restart.conf
$nrconf{kernelhints} = '0';
$nrconf{restart} = 'a';
EOF

# awscli
snap install aws-cli --classic

# 日本語ローケルのインストール・設定
# https://zenn.dev/okz/articles/39d7faa7a6d59a
apt -y install manpages-ja manpages-ja-dev
apt -y install language-pack-ja

cp -pn /etc/locale.conf{,.default}
update-locale LANG=ja_JP.utf8
