# Configurando o Redis como fonte de dados no Grafana

1. Acesse o Grafana através do serviço exposto no Kubernetes.
2. Faça login como administrador.
3. Navegue até "Configuration" > "Data Sources".
4. Clique em "Add data source".
5. Procure e selecione "Redis".
6. Preencha os campos conforme abaixo:
   - **Name**: Redis
   - **Type**: Standalone
   - **URL**: `redis-service.giropops-senhas.svc.cluster.local:6379` # DNS interno do Redis no Kubernetes
7. Clique em "Save & Test".

Agora o Grafana está configurado para acessar o Redis como fonte de dados. É esperado que apareça a seguinte mensagem: "Data Source is working as expected." Possibilitando a criação de dashboards com dados do Redis.

## Criando uma dasboard com dados do Redis

1. Navegue até "Dashboards" > "New".
2. Clique em "New dashboard".
3. Importe a dashboard do Redis através do arquivo `redis-dashboard.json` disponível no repositório.
4. Os dados começarão a ser exibidos na dashboard.
5. Clique em "Save dashboard" para salvar a dashboard.
6. Acesse a minha dashboard do Redis através do link: [Redis Dashboard](https://grafana.nataliagranato.xyz/public-dashboards/853f8db7e3984dd58011fc4cdd12d439).
