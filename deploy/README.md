# Deploy POS to Ubuntu Server

Your code is on GitHub: https://github.com/arrrJay27-gh/ubunto-server-exam

## Option A — One command on the server (recommended)

SSH into your Ubuntu server, then run:

```bash
curl -fsSL https://raw.githubusercontent.com/arrrJay27-gh/ubunto-server-exam/main/deploy/ubuntu-setup.sh | bash
```

This installs `git` and `nginx`, clones the repo to `/var/www/pos`, and serves the site on port 80.

## Option B — Manual steps

```bash
sudo apt update
sudo apt install -y git nginx
sudo git clone https://github.com/arrrJay27-gh/ubunto-server-exam.git /var/www/pos
cd /var/www/pos
chmod +x deploy/ubuntu-setup.sh
./deploy/ubuntu-setup.sh
```

## Update after you change code on GitHub

On the server:

```bash
cd /var/www/pos
sudo git pull origin main
```

## Option C — Copy from Windows with SCP

Replace `USER` and `SERVER_IP` with your SSH login and server address:

```powershell
scp -r "c:\Users\Arnulfo\OneDrive\Desktop\POS-2\index.html" `
         "c:\Users\Arnulfo\OneDrive\Desktop\POS-2\*.jpg" `
         USER@SERVER_IP:/tmp/pos/
```

Then on the server: `sudo mkdir -p /var/www/pos && sudo mv /tmp/pos/* /var/www/pos/`

## Firewall

If the site does not load from another PC:

```bash
sudo ufw allow 'Nginx Full'
sudo ufw status
```

## What you need

- Ubuntu server IP address (e.g. `192.168.1.50` or a cloud public IP)
- SSH username (often `ubuntu` on AWS, or your own user)
- SSH key or password to log in: `ssh username@SERVER_IP`
