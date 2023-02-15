#!/bin/bash

usage() {
    echo "Usage: $0 [-a] [-h]"
    echo "  -a: Print all fields"
    echo "  -h: Display this help message"
    exit 1
}

# Default behavior (print only user and password hash)
print_user_pass_only=true

# Parse command line options
while getopts ":ah" opt; do
    case ${opt} in
        a )
            print_user_pass_only=false
            ;;
        h )
            usage
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Print help if no arguments given
if [ "$1" == "-h" ]; then
    usage
fi

while read line; do
    IFS=':' read -ra fields <<< "$line"
    username=${fields[0]}
    password_hash=${fields[1]}
    last_change=${fields[2]}
    min_age=${fields[3]}
    max_age=${fields[4]}
    warning=${fields[5]}
    inactive=${fields[6]}
    expiration=${fields[7]}
    unused=${fields[8]}
    algo=${password_hash:0:3}
    hash=${password_hash:3}

    if [ $last_change -eq 0 ]; then
        last_change="No password change yet"
    else
        last_change=$(date -d "@$last_change")
    fi

    case $algo in
        '$1$')
            algo_name="MD5"
            ;;
        '$2a$')
            algo_name="Blowfish"
            ;;
        '$y$')
            algo_name="Bcrypt"
            ;;
        '$2y$')
            algo_name="Eksblowfish"
            ;;
        '$5$')
            algo_name="SHA-256"
            ;;
        '$6$')
            algo_name="SHA-512"
            ;;
        *)
            algo_name="Unknown"
            ;;
    esac

    if [ "$print_user_pass_only" = true ]; then
        # Print only username, password hash and algo name
        if [[ -z "${fields[6]}" && -z "${fields[7]}" ]]; then
            echo "user: $username"
            echo "hash: $hash ($algo_name)"
        fi
    else
        # Print all fields
        echo "Username: $username"
        echo "Password hash: $hash ($algo_name)"
        echo "Last password change: $last_change"
        echo "Minimum password age: $min_age"
        echo "Maximum password age: $max_age"
        echo "Password warning period: $warning"
        echo "Password inactivity period: $inactive"
        echo "Account expiration date: $expiration"
        echo "Unused field: $unused"
    fi
    echo "----"
done 