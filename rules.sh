#!/bin/bash

# Network configuration script for test application
# This script should be run on both VMs

set -e

BACKEND_VM_IP="172.16.3.9"
PROXY_VM_IP="172.16.3.10"
POSTGRES_PORT="5432"
BACKEND_PORT="8080"
REDIS_PORT="6379"
PROXY_PORT="5000"

# Detect which VM we are on
detect_vm() {
    local ip=$(hostname -I | awk '{print $1}')
    if [ "$ip" = "$BACKEND_VM_IP" ]; then
        echo "backend"
    elif [ "$ip" = "$PROXY_VM_IP" ]; then
        echo "proxy"
    else
        echo "unknown"
    fi
}

VM_TYPE=$(detect_vm)

case $VM_TYPE in
    "backend")
        echo "Configuring Backend VM firewall rules..."
        
        # Default policies
        ufw default deny incoming
        ufw default allow outgoing
        
        # Allow SSH
        ufw allow ssh
        
        # Allow PostgreSQL from localhost only
        ufw allow from 127.0.0.1 to any port $POSTGRES_PORT
        
        # Allow Backend API only from Proxy VM
        ufw allow from $PROXY_VM_IP to any port $BACKEND_PORT
        
        # Enable UFW
        ufw --force enable
        ;;
        
    "proxy")
        echo "Configuring Proxy VM firewall rules..."
        
        # Install and configure firewalld on CentOS
        yum install -y firewalld
        systemctl enable firewalld
        systemctl start firewalld
        
        # Allow SSH
        firewall-cmd --permanent --add-service=ssh
        
        # Allow Proxy API from anywhere
        firewall-cmd --permanent --add-port=$PROXY_PORT/tcp
        
        # Allow Redis from localhost only
        firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="127.0.0.1" port port="6379" protocol="tcp" accept'
        
        # Allow outbound connections to Backend VM
        firewall-cmd --permanent --add-rich-rule='rule family="ipv4" destination address="'"$BACKEND_VM_IP"'" port port="8080" protocol="tcp" accept'
        
        # Reload firewall
        firewall-cmd --reload
        ;;
        
    *)
        echo "Error: Unknown VM type. Please set correct IP addresses."
        exit 1
        ;;
esac

echo "Network configuration completed for $VM_TYPE VM"
