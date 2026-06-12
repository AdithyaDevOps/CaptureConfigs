#!/bin/bash

echo "================================================="
echo "1. RUNNING SYSTEMD SERVICES (Active & Enabled)"
echo "================================================="
systemctl list-units --type=service --state=running \
--no-pager --no-legend \
| awk '{print $1}' \
| sort

echo
echo "================================================="
echo "2. ENABLED SERVICES (Start on Boot)"
echo "================================================="
systemctl list-unit-files --type=service --state=enabled \
--no-pager --no-legend \
| awk '{print $1}' \
| sort

echo
echo "================================================="
echo "3. COMMON AGENTS - STATUS CHECK"
echo "================================================="

declare -a agents=(
  "splunk"
  "splunkforwarder"
  "amazon-cloudwatch-agent"
  "cwagent"
  "nessus"
  "tenable"
  "qualys"
  "tanium"
  "foreScout"
  "pingmesh"
  "ss2"
  "datadog"
  "newrelic"
  "osquery"
  "falcon"
)

for agent in "${agents[@]}"; do
  if systemctl list-units --type=service --all | grep -qi "$agent"; then
    echo "---- $agent ----"
    systemctl status "$agent"* 2>/dev/null | grep -E "Loaded:|Active:"
  fi
done

echo
echo "================================================="
echo "4. AGENT PROCESSES ACTUALLY RUNNING"
echo "================================================="
ps -ef \
| grep -Ei 'splunk|nessus|tenable|qualys|tanium|forescout|pingmesh|ss2|datadog|newrelic|falcon|osquery' \
| grep -v grep

echo
echo "================================================="
echo "5. INSTALLED RPM PACKAGES (AGENT RELATED)"
echo "================================================="
rpm -qa \
| grep -Ei 'splunk|nessus|tenable|qualys|tanium|forescout|pingmesh|cloudwatch|datadog|newrelic|falcon|osquery' \
| sort