# etcshash

> A shell script to parse the /etc/shadow file and automatically display the relevant information

## Usage

Currently, the script only supports reading from stdin:
```sh
cat /etc/shadow | ./etcshash.sh
```
or output every field of the `/etc/shadow` file with the `-a` flag
```sh
cat /etc/shadow | ./etcshash.sh -a
```
