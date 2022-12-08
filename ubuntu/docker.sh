## Docker
# Docker Engine インストール Ubuntu 向け
# https://matsuand.github.io/docs.docker.jp.onthefly/engine/install/ubuntu/
# ubuntu初期設定まとめ
# https://qiita.com/yukimark/items/5afc64a646872fee55aa

apt-get -y install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt -y update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# docker version
# docker compose version
