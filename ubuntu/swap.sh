## swap on 8GB
# https://tecadmin.net/how-to-add-swap-in-ubuntu-24-04/
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

cp -pn /etc/fstab{,.default}

cat <<\_EOT_ >> /etc/fstab
/swapfile none swap sw 0 0
_EOT_

# swappinessパラメーターは、システムがRAMからスワップ領域にデータをスワップする頻度を設定します。これは、パーセンテージを表す0～100の値です。
sysctl vm.swappiness=10
# vfs_cache_pressure です。これは、システムが他のデータ上の_inode_および_dentry_の情報をキャッシュするために選択する量を設定します。

# 基本的に、これはファイルシステムに関するアクセスデータです。通常、これは検索に非常にコストがかかり、頻繁にリクエストされるため、システムがキャッシュするのに最適です。
sysctl vm.vfs_cache_pressure=200

cp -pn /etc/sysctl.conf{,.default}
cat <<\_EOT_ >> /etc/sysctl.conf
vm.swappiness=10
vm.vfs_cache_pressure=200
_EOT_
