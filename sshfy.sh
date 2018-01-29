#!/bin/bash

while getopts c,l option; do
  case "${option}" in
  c)  
    echo "Name of the new host:"
    read name
    echo "Host ip:"
    read ip
    echo "User:"
    read user
    new="$name $user@$ip"
    echo "$new" >> "scripts/hosts"
    echo "Nuevo host añadido"
    exit
  ;;
  l)
    while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$line"
    done < "scripts/hosts"
    exit
  esac
done

while IFS='' read -r line || [[ -n "$line" ]]; do
  name=`echo "$line" | cut -d " " -f 1`
  host=`echo "$line" | cut -d " " -f 2`
  if [ "$name" == "$1" ]
    then
    ssh="$host"
  fi
done < "scripts/hosts"
ssh "$ssh"

