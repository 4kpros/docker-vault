#!/bin/bash

# Extract backup files
if [ -f "/app/backup/vault_vault-data.tar.gz" ]; then
    # Backup current data
    mkdir -p /vault/data/backups
    mv /vault/data/backups /app
    tar czvf /app/backups/$(date +%Y%m%d_%H%M%S).tar.gz /vault/data

    # Apply new backup
    rm -r /vault/data/*
    tar -zxvf /app/backup/vault_vault-data.tar.gz -C /vault/data
    rm -r /app/backup
    mv /app/backups /vault/data
fi

vault server -config=/etc/vault/vault.hcl
