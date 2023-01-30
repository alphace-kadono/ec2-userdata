if [[ -z ${deployUser} ]];
then
  echo "VAR is not set"
else
  echo "VAR is set"
fi

echo "deployUser = {$deployUser}"
