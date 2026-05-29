#!/bin/bash
# Run on your Ubuntu server (as a user with sudo):
#   curl -fsSL https://raw.githubusercontent.com/arrrJay27-gh/ubunto-server-exam/main/deploy/ubuntu-setup.sh | bash
# Or after cloning:
#   chmod +x deploy/ubuntu-setup.sh && ./deploy/ubuntu-setup.sh

set -euo pipefail

REPO_URL="https://github.com/arrrJay27-gh/ubunto-server-exam.git"
INSTALL_DIR="/var/www/pos"
SITE_NAME="pos"

echo "==> Installing packages (git, nginx)..."
sudo apt-get update -qq
sudo apt-get install -y git nginx

echo "==> Deploying app to ${INSTALL_DIR}..."
sudo mkdir -p "$(dirname "${INSTALL_DIR}")"
if [ -d "${INSTALL_DIR}/.git" ]; then
  cd "${INSTALL_DIR}"
  sudo git pull origin main
else
  sudo rm -rf "${INSTALL_DIR}"
  sudo git clone "${REPO_URL}" "${INSTALL_DIR}"
fi

echo "==> Configuring nginx..."
sudo tee "/etc/nginx/sites-available/${SITE_NAME}" > /dev/null <<'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/pos;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
NGINX

sudo ln -sf "/etc/nginx/sites-available/${SITE_NAME}" /etc/nginx/sites-enabled/pos
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl enable nginx
sudo systemctl reload nginx

echo ""
echo "Done. Open in a browser:"
echo "  http://$(hostname -I | awk '{print $1}')/"
echo "Files live at: ${INSTALL_DIR}"
