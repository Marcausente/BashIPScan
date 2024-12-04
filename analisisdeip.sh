#!/bin/bash

read -p "Entra una IP a escanear pero pon solo los tres primeros ocetos: " base_ip
if ! [[ "$base_ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Me has pasado una ip que no es valida"
    exit 1
fi

total=254
count=0
> ipaddresses.txt

for i in {1..254}; do
    ping -c 1 -W 1 "$base_ip.$i" > /dev/null 2>&1 && echo "$base_ip.$i" >> ipaddresses.txt
    count=$((count + 1))
    echo -ne "Completado: $((count * 100 / total))%   \r"
done

echo -e "\nEscaneo finalizado. Las IPs activas las he guardado en el archivo que he creado, ipaddresses.txt"
