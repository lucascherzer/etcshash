#!/bin/bash

while read line; do
  if [[ $line =~ ^([^:]+):\$(\d+|y)\$([^\$]+)\$(.+)$ ]]; then
    username=${BASH_REMATCH[1]}
    algorithm=${BASH_REMATCH[2]}
    salt=${BASH_REMATCH[3]}
    hash=${BASH_REMATCH[4]}

    echo "user: $username"
    echo "algorithm: $(case $algorithm in
      1) echo 'MD5';;
      2) echo 'Blowfish';;
      5) echo 'SHA-256';;
      6) echo 'SHA-512';;
      y) echo 'bcrypt';;
      *) echo 'Unknown';;
    esac)"
    echo "hash: $hash"
    echo "salt: $salt"
    echo "---"
  else
    echo "Error: line does not match the expected format."
    echo "---"
  fi
done < /dev/stdin
