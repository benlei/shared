#!/usr/bin/env bash
if [[ $# -ne 1 ]]; then
  echo "Must provide only 1 argument - the pem file"
  exit 1
fi

if [[ ! -f "$1" ]]; then
  echo "$1 does not exist"
  exit 1
fi

NAME=$(basename $1)
EXT="${NAME##*.}"
NAME="${NAME%.*}"

if [[ $EXT != "pem" ]]; then
  echo "$1 is not a PEM file"
  exit 1
fi

PUBLIC_KEY="$(ssh-keygen -y -f $1)"
if [[ !${PUBLIC_KEY} ]]; then
  echo "Could not generate public key from $1"
  exit 1
fi

for region in $(aws ec2 describe-regions --region us-west-1 --output text | awk '{ print $3 }'); do
  aws ec2 import-key-pair --key-name ${NAME} --public-key-material "${PUBLIC_KEY}" --region ${region}
done

