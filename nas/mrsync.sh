#!/bin/bash
# basic script to use on my nas to concurrently transfer files

MAX_CONCURRENT=3

# every line is a name of a file in the server
LIST_FILE=foo.txt

SRC_URI=foo@192.168.1.10:/home/user/my/path

DEST_PATH=/volume1/foo

PEM_PATH=/home/foo/.ssh/id_rsa

cat "$LIST_FILE" | while read line; do
  while [ $(jobs -r | wc -l) -ge $MAX_CONCURRENT ]; do
    wait -n 1
  done
  echo "Transferring $line"
  mkdir -p "$DEST_PATH/$line"
  rsync -savz --progress -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $PEM_PATH" "$SRC_URI/$line/" "$DEST_PATH/$line/" &
done
