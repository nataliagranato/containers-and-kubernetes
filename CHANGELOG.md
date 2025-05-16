# CHANGELOG

Todas as mudanças notáveis ​​neste projeto serão documentadas neste arquivo.

O formato é baseado em [Mantenha um Changelog](https://keepachangelog.com/pt-BR/1.1.0/)
e este projeto adere a [Versionamento Semântico](https://semver.org/lang/pt-BR/).

<!--
## [Unreleased] - yyyy-mm-dd

Here we write upgrading notes for brands. It's a team effort to make them as
straightforward as possible.

### Added

### Changed

### Fixed

### Breaking Changes
-->

## [2.1.0] - 2025-05-16

### Added
- Adicionado `permissions: read-all` nos workflows para seguir o princípio do menor privilégio.
- Instalação de dependências Python agora utiliza arquivos requirements.txt com hashes para integridade e segurança.
- Actions do GitHub agora estão pinadas por SHA.
- Implementação de melhorias e novas funcionalidades.
- Criação do arquivo SECURITY.md.
- Novo CODEOWNERS.
- Adiciona hashes de integridade ao requirements.txt.
- Melhorias de segurança em workflows do GitHub Actions.
- Diversos upgrades de dependências, melhorias de segurança e hardening ([changelog completo](https://github.com/nataliagranato/LINUXtips-PICK/releases/tag/v2.1.0)).

### Changed
- Permissões de escrita agora são concedidas apenas nos jobs que realmente precisam.
- Ajustes gerais para atender recomendações do Scorecard e StepSecurity.

### Fixed
- Correções relacionadas à rastreabilidade das dependências e integridade de builds.

### New Contributors
- @step-security-bot fez sua primeira contribuição.

---

## [2.0.0] - 2024-09-10

### Added
- Implementação de multi-stage build para otimização da imagem Docker.
- Pipeline para publicação de imagem Docker em repositório privado.
- Manifestos Kubernetes para Deployment, Service, PersistentVolume, PersistentVolumeClaim, Ingress e Secret.
- Pacotes Helm para ambientes de desenvolvimento, staging e produção.
- Escaneamento de segurança e correção de vulnerabilidades com Trivy, Docker Scout e Snyk.
- Políticas de segurança e compliance com Kyverno.
- Assinatura de imagens com Cosign.
- Instalação do Prometheus e Grafana.
- Monitoramento com ServiceMonitor, PodMonitor, Alertmanager e dashboards no Grafana.
- Construção de imagem com APKO e Melange.
- Integração com Hadolint, Digestabot, Dependabot, Scorecard Supply-Chain Security.
- Deploy usando repositórios helm e docker privados.

---

## [1.5.0] - 2024-08-26

### Changed
- Melhorias no Locust e documentação.
- Veja detalhes: [Release 1.5.0](https://github.com/nataliagranato/LINUXtips-PICK/releases/tag/v1.5.0)

---

## [1.4.0] - 2024-08-20

### Changed
- Atualização do azure/setup-kubectl de 3 para 4.
- Veja detalhes: [Release 1.4.0](https://github.com/nataliagranato/LINUXtips-PICK/releases/tag/v.1.4.0)

---

## [1.3.0] - 2024-08-17

Consulte o changelog completo: [Release 1.3.0](https://github.com/nataliagranato/LINUXtips-PICK/releases/tag/v.1.3.0)

---

## [1.2.0] - 2024-08-13

Consulte o changelog completo: [Release 1.2.0](https://github.com/nataliagranato/LINUXtips-PICK/releases/tag/v1.2.0)

---

## [1.1.0] - 2024-08-11

### Added
- Diversas atualizações de dependências, otimizações de imagens, e melhorias (ver changelog completo).

---

## [1.0.0] - 2024-08-08

Consulte o changelog completo: [Release 1.0.0](https://github.com/nataliagranato/LINUXtips-PICK/releases/tag/v1.0.0)

---

## [0.0.0] - 2025-03-25

### Added
- Esse é apenas um exemplo de descrição.
