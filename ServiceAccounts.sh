echo "===== 1. System / Service Accounts (non-login) ====="
awk -F: '($3 < 1000 || $7 ~ /(nologin|false)$/) {printf "%-25s UID=%s GID=%s SHELL=%s\n",$1,$3,$4,$7}' /etc/passwd

echo
echo "===== 2. Accounts with Running Processes ====="
ps -eo user= | sort -u | while read u; do
  getent passwd "$u" | awk -F: '{printf "%-25s UID=%s GID=%s SHELL=%s\n",$1,$3,$4,$7}'
done

echo
echo "===== 3. Accounts Used by systemd Services ====="
grep -R "^User=" /etc/systemd/system /usr/lib/systemd/system 2>/dev/null \
| awk -F= '{print $2}' | sort -u | while read u; do
  getent passwd "$u"
done

echo
echo "===== 4. Accounts with Cron Jobs ====="
for u in $(ls /var/spool/cron 2>/dev/null); do
  echo "Cron user: $u"
done