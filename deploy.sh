#!/bin/bash

echo "🚀 Starting Tri3D Clone Auto Deployment"

# 1. Install Docker
echo "🐳 Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y docker.io

# 2. Install Docker Compose
echo "🔧 Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="v2.22.0"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 3. Add current user to docker group
echo "👤 Adding user to docker group..."
sudo usermod -aG docker $USER

# 4. Log out & back in required for group change to take effect
echo "⚠️ If this is the first time adding user to docker group, you may need to logout/login or run: newgrp docker"

# 5. Unzip code (if not already unzipped)
echo "📦 Unzipping project if needed..."
if [ -f tri3d_clone_full.zip ]; then
    unzip -o tri3d_clone_full.zip
fi

cd tri3d_clone_full || { echo "❌ Folder tri3d_clone_full not found."; exit 1; }

# 6. Set permissions
echo "🔐 Setting permissions..."
sudo chown -R $USER:$USER .

# 7. Build and run Docker containers
echo "🔁 Building Docker containers..."
docker-compose down
docker-compose up --build -d

# 8. Done
echo "✅ Deployment completed!"
echo "🌐 App should be live at: http://$(curl -s ifconfig.me)/"
