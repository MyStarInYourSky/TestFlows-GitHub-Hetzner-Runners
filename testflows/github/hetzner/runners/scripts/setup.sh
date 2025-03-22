set -x

{
    echo "Create and configure ubuntu user"
    adduser ubuntu --disabled-password --gecos ""
    echo "%wheel   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
    addgroup wheel
    addgroup docker
    usermod -aG wheel ubuntu
    usermod -aG sudo ubuntu
    usermod -aG docker ubuntu
}

{
    echo "Install fail2ban"
    apt-get update
    apt-get install --yes --no-install-recommends \
        fail2ban

    echo "Launch fail2ban"
    systemctl start fail2ban
}

{
    echo "Configure Python venv"
    apt-get install --yes --no-install-recommends \
        python3-venv
    su ubuntu -s python3 -m venv /home/ubuntu/venv
    echo -n 'export PATH="/home/ubuntu/venv/bin/:$PATH"' >> /home/ubuntu/.profile
}
