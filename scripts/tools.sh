#!/bin/bash
set -euo pipefail

# Instalando o Docker

# Baixando o script de instalação do Docker de forma segura
TMP_DOCKER_SCRIPT=$(mktemp)
curl -fsSL https://get.docker.com -o "$TMP_DOCKER_SCRIPT"

# Verificando o hash SHA256 do script (atualize o hash se necessário)
EXPECTED_HASH="0158433a384a7ef6d60b6d58e556f4587dc9e1ee9768dae8958266ffb4f84f6f"
ACTUAL_HASH=$(sha256sum "$TMP_DOCKER_SCRIPT" | awk '{print $1}')

if [ "$EXPECTED_HASH" != "$ACTUAL_HASH" ]; then
  echo "[ERRO] O hash do script get-docker.sh não confere! Abortando instalação por segurança."
  exit 1
fi

bash "$TMP_DOCKER_SCRIPT"
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose 

# Instalando o Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Instalando o Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
./get_helm.sh

# Instalando o Kind

# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Instalação o Hadolint
brew install hadolint

# Instalando o docker-scout
curl -sSfL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh -s --

# Instalando o Trivy
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.deb
sudo dpkg -i trivy_0.18.3_Linux-64bit.deb

