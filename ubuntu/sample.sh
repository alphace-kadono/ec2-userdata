if [[ -z ${deployUser} ]]; then
  echo "deployUser is not set"
  exit 1
fi

# deploy ユーザー
USER="${deployUser}"
# userdel -r ${USER}
echo ${USER}
useradd -m -s /bin/bash ${USER}
