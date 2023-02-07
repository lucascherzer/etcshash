# etcshash

> A shell script to parse the /etc/shadow file and automatically display the relevant information

## Usage

Currently, the script only supports reading from stdin:
```sh
cat /etc/shadow | ./etcshash.sh
```

If a file contains many service accounts, the script can not yet handle them correctly and outputs a lot of errors. To circumvent this, errors can be redirected to `/dev/null`:
```sh
cat /etc/shadow | ./etcshash.sh 2>/dev/null
```
