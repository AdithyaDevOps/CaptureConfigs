#!/bin/bash

echo "================================================="
echo "1. PYTHON VERSIONS INSTALLED"
echo "================================================="
command -v python >/dev/null 2>&1 && python --version
command -v python2 >/dev/null 2>&1 && python2 --version
command -v python3 >/dev/null 2>&1 && python3 --version

echo
echo "================================================="
echo "2. PYTHON BINARIES AVAILABLE"
echo "================================================="
ls -1 /usr/bin/python* 2>/dev/null

echo
echo "================================================="
echo "3. PIP VERSIONS"
echo "================================================="
command -v pip >/dev/null 2>&1 && pip --version
command -v pip3 >/dev/null 2>&1 && pip3 --version

echo
echo "================================================="
echo "4. PYTHON MODULES INSTALLED (python3)"
echo "================================================="
python3 -m pip list 2>/dev/null

echo
echo "================================================="
echo "5. COMMON OS TOOLS - VERSION CHECK"
echo "================================================="

tools=(
  "curl"
  "wget"
  "openssl"
  "tar"
  "gzip"
  "zip"
  "unzip"
  "netstat"
  "ss"
  "traceroute"
  "ip"
  "dig"
  "nslookup"
  "ping"
  "docker"
)

for tool in "${tools[@]}"; do
  echo "---- $tool ----"
  command -v "$tool" >/dev/null 2>&1 && "$tool" --version || echo "Not installed"
done

echo
echo "================================================="
echo "6. INSTALLED RPM PACKAGES (PYTHON & TOOLS)"
echo "================================================="
rpm -qa | grep -Ei 'python|pip|curl|wget|openssl|net-tools|bind-utils|iproute|traceroute|docker' | sort
``