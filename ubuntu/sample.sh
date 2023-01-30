if [[ -z ${deployUser} ]];
then
  echo "VAR is not set"
else
  echo "VAR is set"
fi

echo "deployUser = {$deployUser}"


if [[ -z ${PATH} ]];
then
  echo "PATH is not set"
else
  echo "PATH is set"
fi

echo "PATH = {$PATH}"
