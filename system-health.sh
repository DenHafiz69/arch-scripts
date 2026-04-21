#!/bin/bash
# Description: Checks disk space, memory, CPU temp, and failed systemd services.

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== System Health Report ===${NC}"
date
echo "---------------------------"

# 1. Check Disk Usage (Root and Home)
echo -e "${GREEN}[Disk Usage]${NC}"
df -h / /home | awk 'NR==1 || /^\// {print $0}'
echo ""

# 2. Check Memory Usage
echo -e "${GREEN}[Memory/Swap]${NC}"
free -h | awk 'NR==1 || /^Mem:/ || /^Swap:/ {print $0}'
echo ""

# 3. Check CPU Temperature
# Requires 'lm_sensors' package. If not installed, it skips.
echo -e "${GREEN}[CPU Temperature]${NC}"
if command -v sensors &> /dev/null; then
    sensors | grep -E 'Core 0|Package id 0|temp1' | awk '{print $1, $2}'
else
    echo "Install 'lm_sensors' to see CPU temps."
fi
echo ""

# 4. Check for Failed Systemd Services
echo -e "${GREEN}[Failed Services]${NC}"
FAILED_COUNT=$(systemctl --failed --quiet | wc -l)
if [ "$FAILED_COUNT" -eq 0 ]; then
    echo "All systemd services are running correctly."
else
    echo -e "${RED}Warning: $FAILED_COUNT services have failed!${NC}"
    systemctl --failed --no-legend
fi

echo "---------------------------"
echo -e "${YELLOW}Health Check Complete${NC}"
