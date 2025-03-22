
set -x

{
    echo "Install required packages"
    apt-get update
    apt-get -y install python3-pip
    apt-get -y install openssh-client
}

{
    echo "Create and configure ubuntu user"
    adduser ubuntu --disabled-password --gecos ""
    echo "%wheel   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
    addgroup wheel
    usermod -aG wheel ubuntu
    usermod -aG sudo ubuntu
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
    echo "Generate SSH Key"
    sudo -u ubuntu ssh-keygen -t rsa -q -f "/home/ubuntu/.ssh/id_rsa" -N ""
}

{
    echo "Create scripts folder"
    mkdir -p /home/ubuntu/.github-hetzner-runners/scripts
    mkdir -p /home/ubuntu/.github-hetzner-runners/configs
}

{
    echo "Configure Python venv"
    apt-get install --yes --no-install-recommends \
        python3-venv
    su ubuntu -s /usr/bin/env python3 -m venv /home/ubuntu/venv
    ls -la /home/ubuntu
    echo -n 'export PATH="/home/ubuntu/venv/bin/:$PATH"' >> /home/ubuntu/.profile
}
