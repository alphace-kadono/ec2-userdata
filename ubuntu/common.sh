# Ubuntu 22.04 LTSのインスタンスにSSH接続/ログインできません。
# https://help.arena.ne.jp/hc/ja/articles/5737789875223-Ubuntu-22-04-LTS%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%82%BF%E3%83%B3%E3%82%B9%E3%81%ABSSH%E6%8E%A5%E7%B6%9A-%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%A7%E3%81%8D%E3%81%BE%E3%81%9B%E3%82%93-
cp -p /etc/ssh/sshd_config{,.default}
sed -i '1s/^/PubkeyAcceptedAlgorithms=+ssh-rsa\n/' /etc/ssh/sshd_config
systemctl restart ssh.service

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

# git
apt -y install git
# awscli
apt -y install awscli
