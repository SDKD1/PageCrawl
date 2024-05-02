#!/bin/bash
 
#########################
# PARSING HTML |  SDKD1 #
#########################

COR_VERDE='\033[0;32m'
COR_AMARELA='\033[0;33m'
COR_VERMELHA='\033[0;31m'
COR_RESET='\033[0m'

if [ $# -ne 1 ]; then
    echo -e "${COR_AMARELA}++++++++++++++++++++++++++++++++++++++++++${COR_RESET}"
    echo -e "${COR_AMARELA}+ ${COR_RESET}${COR_VERDE}PARSING HTML - SDKD1 | www.InfraSec.com ${COR_AMARELA}+${COR_RESET}"
    echo -e "${COR_AMARELA}+----------------------------------------+${COR_RESET}"
    echo -e "${COR_AMARELA}+${COR_RESET} ${COR_VERMELHA}Modo de uso:${COR_RESET} $0 ${COR_VERDE}<URL>${COR_AMARELA}          +${COR_RESET}"
    echo -e "${COR_AMARELA}+${COR_RESET} ${COR_VERMELHA}Exemplo uso:${COR_RESET} $0  example.com ${COR_AMARELA}  +${COR_RESET}"
    echo -e "${COR_AMARELA}++++++++++++++++++++++++++++++++++++++++++${COR_RESET}"
    exit 1
fi


#HOST="example.com"
PORT=80
RESOURCE="/"

exec 3<>/dev/tcp/$1/$PORT

echo -e "GET $RESOURCE HTTP/1.1\r\nHost: $1\r\nConnection: close\r\n\r\n" >&3

response=""
while IFS= read -r line <&3; do
    response+="$line\n"
done

exec 3<&-
exec 3>&-

urls=$(echo -e "$response" | grep -o 'href="[^"]*"' | sed 's/href="//' | sed 's/"//g')

echo "URLs encontradas na página $1:$PORT$RESOURCE:"
echo "$urls"


############
# BY SDKD1 #
############
