# Ubuntu 20.04にスワップ領域を追加する方法
# https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04-ja

### swap on 8GB
dd if=/dev/zero of=/swapfile1 bs=1M count=8192
chmod 600 /swapfile1
mkswap /swapfile1
swapon -s
swapon /swapfile1

cp -p /etc/fstab{,.default}

cat <<\_EOT_ >> /etc/fstab
/swapfile none swap sw 0 0
_EOT_

# swappinessパラメーターは、システムがRAMからスワップ領域にデータをスワップする頻度を設定します。これは、パーセンテージを表す0～100の値です。
sysctl vm.swappiness=10
# vfs_cache_pressure です。これは、システムが他のデータ上の_inode_および_dentry_の情報をキャッシュするために選択する量を設定します。

# 基本的に、これはファイルシステムに関するアクセスデータです。通常、これは検索に非常にコストがかかり、頻繁にリクエストされるため、システムがキャッシュするのに最適です。
sysctl vm.vfs_cache_pressure=200

cp -p /etc/sysctl.conf{,.default}
cat <<\_EOT_ >> /etc/sysctl.conf
vm.swappiness=10
vm.vfs_cache_pressure=200
_EOT_
