#!/bin/bash

# Fix docker-compose.yml to use literal network names
# This script replaces variable network names with literal ones
# because Docker Compose doesn't expand variables in networks section

set -e

if [[ ! -f "deploy-config.env" ]]; then
    echo "❌ deploy-config.env not found!"
    echo "Run this script from the project root directory."
    exit 1
fi

# Load APP_NAME from config
source deploy-config.env

if [[ -z "$APP_NAME" ]]; then
    echo "❌ APP_NAME not set in deploy-config.env"
    exit 1
fi

echo "🔧 Fixing docker-compose.yml for app: $APP_NAME"

# Replace variable network references with literal names
sed -i "s/\${APP_NAME:-webapp}_default/${APP_NAME}_default/g" docker-compose.yml

echo "✅ Updated docker-compose.yml to use literal network name: ${APP_NAME}_default"
echo "📝 Remember to run this command on your server:"
echo "   ssh root@zoidberg 'docker network create ${APP_NAME}_default || true'"
