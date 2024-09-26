#  Criando um cluster Kubernetes gerenciado na AWS

## Para criar um cluster EKS com o eksctl, você precisa ter o eksctl instalado, realize a instalação com o comando abaixo:

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
```

## Iremos precisar do AWS CLI instalado e configurado em nossa máquina. Para instalar o AWS CLI, use o comando abaixo:

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Agora exporte as variáveis de ambiente com suas credenciais da AWS:

```
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_DEFAULT_REGION=your_region
```


### Crie um arquivo chamado `api.yaml` com o conteúdo a seguir:

```
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: nataliagranato
  region: us-east-1
  version: "1.30"

availabilityZones: ["us-east-1a","us-east-1b","us-east-1c"]

vpc:
  cidr: 172.20.0.0/16
  clusterEndpoints:
    publicAccess: true
    privateAccess: true

iam:
  withOIDC: true
  serviceAccounts:
  - metadata:
      name: s3-fullaccess
    attachPolicyARNs:
    - "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  - metadata:
      name: aws-load-balancer-controller
      namespace: kube-system
    wellKnownPolicies:
      awsLoadBalancerController: true
  - metadata:
      name: external-dns
      namespace: kube-system
    wellKnownPolicies:
      externalDNS: true
  - metadata:
      name: cert-manager
      namespace: cert-manager
    wellKnownPolicies:
      certManager: true
  - metadata:
      name: cluster-autoscaler
      namespace: kube-system
    wellKnownPolicies:
      autoScaler: true
```

## Para criar o cluster com o arquivo de configuração, execute o comando abaixo:

```
eksctl create cluster -f api.yaml
```

## Crie  um arquivo chamado `nodegroup.yaml` com o conteúdo a seguir:

```
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: nataliagranato
  region: us-east-1
  version: "1.30"

managedNodeGroups:
 - name: ng-ondemand-1
   instanceTypes: ["m6a.xlarge"]
   spot: false
   privateNetworking: true
   minSize: 1
   maxSize: 3
   desiredCapacity: 2
   volumeSize: 50
   volumeType: gp3
   updateConfig:
     maxUnavailablePercentage: 30
   availabilityZones: ["us-east-1a"]
   ssh:
     allow: false
   labels:
     node_group: ng-ondemand-1
   tags:
     nodegroup-role: ng-ondemand-1
     k8s.io/cluster-autoscaler/enabled: "true"
     k8s.io/cluster-autoscaler/nataliagranato: "owned"
     nataliagranato.xyz: "true"

   iam:
     withAddonPolicies:
       externalDNS: true
       certManager: true
       imageBuilder: true
       albIngress: true
       autoScaler: true
       ebs: true
       efs: true
```

## Para criar o nodegroup com o arquivo de configuração, execute o comando abaixo:

```
eksctl create nodegroup -f nodegroup.yaml
```

## Obtenha o kubeconfig e utilize seu cluster

```
eksctl utils write-kubeconfig --cluster=nataliagranato
```

