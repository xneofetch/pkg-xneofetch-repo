#!/bin/bash

# Renkler
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${CYAN}|----------------------|"
echo -e "|      xneofetch       |"
echo -e "|----------------------|${RESET}"

# Kullanıcı ve host bilgisi
echo -e "${CYAN}User:  ${RESET}$(whoami)@$(hostname)"

# İşletim sistemi bilgisi
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
echo -e "${CYAN}Operating System: ${RESET}$OS"

# Kernel bilgisi
KERNEL=$(uname -r)
echo -e "${CYAN}Kernel: ${RESET}$KERNEL"

# Uptime
UPTIME=$(uptime -p)
echo -e "${CYAN}Uptime: ${RESET}$UPTIME"

# CPU modeli
CPU=$(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | xargs)
echo -e "${CYAN}CPU: ${RESET}$CPU"

# RAM bilgisi
RAM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
RAM_USED=$(free -h | awk '/Mem:/ {print $3}')
echo -e "${CYAN}RAM: ${RESET}${RAM_USED} / ${RAM_TOTAL}"

