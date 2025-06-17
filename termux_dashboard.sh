#!/data/data/com.termux/files/usr/bin/bash

clear
figlet -f slant "KRATOR" | lolcat

# --- SYSTEM STATUS ---
echo -e "\e[1;32m[+] User:\e[0m $(whoami)"
echo -e "\e[1;32m[+] Uptime:\e[0m $(uptime -p)"
echo -e "\e[1;32m[+] IP:\e[0m $(ip a | grep 'inet ' | grep wlan | awk '{print $2}' | cut -d/ -f1 || echo Offline)"
echo -e "\e[1;32m[+] Battery:\e[0m $(termux-battery-status | jq '.percentage')%"

# --- GIT STATUS ---
if git rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git branch --show-current)
  changes=$(git status --porcelain | wc -l)
  echo -e "\e[1;33m[+] Git Branch:\e[0m $branch"
  echo -e "\e[1;33m[+] Pending Changes:\e[0m $changes"
fi

# --- PROJECT STATUS ---
echo -e "\n\e[1;36mDetected Projects:\e[0m"
for d in ~/Krator* ~/sherlock; do
  [ -d "$d" ] && echo " • $(basename "$d") - $(du -sh "$d" 2>/dev/null | cut -f1)"
done

# --- TOOL CHECK ---
echo -e "\n\e[1;36mTool Status:\e[0m"
for t in python git nmap hydra sqlmap termux-api; do
  if command -v $t >/dev/null 2>&1; then
    echo -e " ✅ $t"
  else
    echo -e " ❌ $t"
  fi
done

# --- MAIN MENU ---
echo -e "\n\e[1;35m======== KRATOR OPS MENU ========\e[0m"
echo " [1] 🔍 Sherlock"
echo " [2] 🌐 Nmap Scanner"
echo " [3] 💣 Hydra Brute Force"
echo " [4] 🧠 SQLMap Injector"
echo " [5] 📂 Browse Projects"
echo " [6] ⬇️  Git Pull Current Repo"
echo " [7] 🔄 System + Tools Update"
echo " [8] 🤖 Launch Krator AI (coming)"
echo " [9] 🛑 Exit"
echo -e "==================================\n"

read -p $'\e[1;34mChoose option: \e[0m' opt

case $opt in
  1) cd ~/sherlock && python3 sherlock.py ;;
  2) read -p "Target IP: " ip && nmap -A $ip ;;
  3) hydra ;;
  4) sqlmap ;;
  5) cd ~ && ls -d Krator* sherlock 2>/dev/null ;;
  6) git pull ;;
  7) pkg update -y && pkg upgrade -y ;;
  8) echo "Launching Krator AI (soon)" ;;
  9) exit ;;
  *) echo "Invalid input." && sleep 1 ;;
esac

