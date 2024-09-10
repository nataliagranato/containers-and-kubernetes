# Construindo uma imagem com uma única camada

Os containers Docker são compostos por camadas. Cada instrução no Dockerfile cria uma nova camada. Quanto mais camadas, maior o tamanho da imagem e mais lenta a inicialização do container.

Criando uma imagem com uma única camada, podemos reduzir o tamanho da imagem, acelerar a inicialização do container e melhorar a segurança.

## Utilizando o APKO e o Melange

As imagens de contêiner são tipicamente montadas em múltiplas etapas. Uma ferramenta como o Docker, por exemplo, combina etapas de construção. Por outro lado, o apko é exclusivamente uma ferramenta que se concentra em produzir imagens base leves, que são totalmente reproduzíveis e contêm arquivos SBOM (Software Bill of Materials) gerados automaticamente para cada construção bem-sucedida.

Em vez de construir sua aplicação junto com seus componentes e dependências do sistema, você pode construir sua aplicação uma vez e cria-lo em diferentes arquiteturas e distribuições, usando uma ferramenta como o melange em combinação com o apko.

### Instalando o APKO

```bash
wget https://github.com/chainguard-dev/apko/releases/download/v0.14.7/apko_0.14.7_linux_amd64.tar.gz

tar -xvf apko_0.14.7_linux_amd64.tar.gz

cd cd apko_0.14.7_linux_amd64

sudo mv apko /usr/local/bin

chmod +x /usr/local/bin/apko
```

### Instalando o Melange

```bash
wget https://github.com/chainguard-dev/melange/releases/download/v0.11.6/melange_0.11.6_linux_amd64.tar.gz

tar -xvf melange_0.11.6_linux_amd64.tar.gz

cd melange_0.11.6_linux_amd64

sudo mv melange /usr/local/bin

chmod +x /usr/local/bin/melange
```

### O nosso projeto

```bash
cd chainguard/
```

Nesse diretório está o código fonte da nossa aplicação e os arquivos de configuração do apko e do melange para diferentes ambientes.

### O arquivo melange.yaml

```yaml
package:
  name: senhas
  version: 1.0.0
  description: Um gerador de senhas.
  copyright:
  - license: Apache-2.0
    paths:
    - "*"
  dependencies:
    runtime:
    - python3

environment:
  contents:
    repositories:
    - https://dl-cdn.alpinelinux.org/alpine/edge/main
    - https://dl-cdn.alpinelinux.org/alpine/edge/community
    packages:
    - alpine-baselayout-data
    - ca-certificates-bundle
    - busybox
    - gcc
    - musl-dev
    - python3
    - python3-dev
    - py3-pip
    - py3-virtualenv

pipeline:
- name: Build Python application
  runs: |
    WEBAPPDIR="${{targets.destdir}}/usr/share/webapps/app"
    mkdir -p "${WEBAPPDIR}"
    echo "#!/usr/share/webapps/app/venv/bin/python3" > "${WEBAPPDIR}/app"
    cat app.py >> "${WEBAPPDIR}/app"
    chmod +x "${WEBAPPDIR}/app"
    cp -r templates "${WEBAPPDIR}"
    cp -r static "${WEBAPPDIR}"
    virtualenv "${WEBAPPDIR}/venv"
    sh -c "source '${WEBAPPDIR}/venv/bin/activate' && pip install -r requirements.txt"
```

- O campo `package` define as especificações do pacote, incluindo nome, versão, descrição, licença e dependências de runtime.

- O campo `environment` define o ambiente de construção, incluindo repositórios de pacotes e pacotes a serem instalados.

- O campo `pipeline` define as etapas de construção do pacote. Neste caso, a etapa `Build Python application` cria um ambiente virtual Python, instala as dependências do Python e copia o código fonte da aplicação para o diretório de destino.

Depois de entender um pouco da estrutura do arquivo melange.yaml, vamos construir a imagem:

```bash
melange keygen
# Gera um par de chaves temporário para assinar o pacote.
```

```bash
melange build melange.yaml --runner docker --signing-key melange.rsa --arch amd64
# Constrói a imagem usando o arquivo melange.yaml, utiliza o docker como runner, assina o pacote com a chave de assinatura melange.rsa e gera o pacote para a arquitetura amd64.
```

O output do comando `melange build` contém o diretório `packages` com um diretório para cada arquitetura que você definiu, nele temos o arquivo `senhas-1.0.0-r0.apk` que é o pacote da nossa aplicação e `APKINDEX.json` que é o índice de pacotes.

Agora que possuímos o pacote da nossa aplicação, vamos construir a imagem Docker com o apko:

```bash
apko build apko.yaml giropos-melange-apko:1.0.0 giropops-senhas.tar -k melange.rsa.pub --arch amd64
# Constrói a imagem usando o arquivo apko.yaml, define o nome da imagem como giropos-melange-apko:1.0.0, gera o arquivo giropops-senhas.tar e utiliza a chave pública melange.rsa.pub para verificar a assinatura do pacote.
```

O output do comando `apko build` contém o arquivo `giropops-senhas.tar` que é um arquivo tarball contendo a imagem Docker.

Para carregar a imagem Docker no Docker Engine, execute o comando:

```bash
docker load < giropops-senhas.tar
```

Assim que a imagem é carregada no Docker Engine, também fica disponível para ser utilizada em qualquer ambiente que tenha o Docker Engine instalado.

```bash
74160b492eff: Loading layer  20.16MB/20.16MB
Loaded image: giropos-melange-apko:1.0.0-amd64
```

Agora é possível publicar a imagem em um registry Docker, como o Docker Hub, utiliza-la localmente, no Kubernetes e em qualquer outro ambiente que suporte imagens Docker.

Na pipeline disponível no repositório em `.github/workflows/chainguard.yaml` temos todas as etapas acima, além de assinatura com Cosign, verificação de segurança e publicação no registry.

As imagens também foram construídas para diferentes utilizando o GitHub Packages, para acessar as imagens, basta acessar o **[link](https://github.com/nataliagranato?tab=packages&repo_name=LINUXtips-PICK).**
