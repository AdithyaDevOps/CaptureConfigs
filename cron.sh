#!/bin/bash

echo "================================================="
echo "1. SYSTEM-WIDE CRON FILE (/etc/crontab)"
echo "================================================="
if [ -f /etc/crontab ]; then
  cat /etc/crontab
else
  echo "/etc/crontab not found"
fi

echo
echo "================================================="
echo "2. SYSTEM CRON DIRECTORIES"
echo "================================================="
for dir in /etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly; do
  echo "---- $dir ----"
  if [ -d "$dir" ]; then
    ls -l "$dir"
  else
    echo "Directory not present"
  fi
done

echo
echo "================================================="
echo "3. USER CRON JOBS (/var/spool/cron)"
echo "================================================="
if [ -d /var/spool/cron ]; then
  for user in $(ls /var/spool/cron); do
    echo "---- Cron jobs for user: $user ----"
    crontab -u "$user" -l
    echo
  done
else
  echo "/var/spool/cron directory not found"
fi

echo
echo "================================================="
echo "4. ANACRON JOBS"
echo "================================================="
if [ -f /etc/anacrontab ]; then
  cat /etc/anacrontab
else
  echo "/etc/anacrontab not found"
fi

echo
echo "================================================="
echo "5. CRON SERVICE STATUS"
echo "================================================="
systemctl status crond --no-pager