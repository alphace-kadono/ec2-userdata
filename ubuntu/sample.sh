if [[ -z ${deployUser} ]];
then
  echo "deployUser is not set"
  exit 1;
fi

echo "deployUser = ${deployUser}"


if [[ -z ${PATH} ]];
then
  echo "PATH is not set"
else
  echo "PATH is set"
fi

echo "PATH = ${PATH}"
