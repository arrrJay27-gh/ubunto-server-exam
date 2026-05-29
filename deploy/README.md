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

## Deploy from Windows with your SSH key

From the project folder in PowerShell:

```powershell
Set-Location "c:\Users\Arnulfo\OneDrive\Desktop\POS-2"
.\deploy\ssh-deploy.ps1 -Server "YOUR_USER@YOUR_SERVER_IP"
```

Example:

```powershell
.\deploy\ssh-deploy.ps1 -Server "ubuntu@192.168.1.50"
```

Or run SSH yourself (same thing):

```powershell
ssh YOUR_USER@YOUR_SERVER_IP "curl -fsSL https://raw.githubusercontent.com/arrrJay27-gh/ubunto-server-exam/main/deploy/ubuntu-setup.sh | bash"
```

Custom key file:

```powershell
.\deploy\ssh-deploy.ps1 -Server "user@10.0.0.5" -IdentityFile "$env:USERPROFILE\.ssh\id_rsa"
```

## What you need

- Ubuntu server IP address (e.g. `192.168.1.50` or a cloud public IP)
- SSH username (often `ubuntu` on AWS, or your own user)
- Your SSH private key (default: `~/.ssh/id_rsa` or `id_ed25519`)
