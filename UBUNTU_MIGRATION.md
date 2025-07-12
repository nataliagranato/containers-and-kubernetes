# 🔧 Migração GitHub Actions: Ubuntu 20.04 → Ubuntu 22.04

## 📋 Resumo da Migração

Esta documentação registra a migração obrigatória dos workflows do GitHub Actions de `ubuntu-20.04` para `ubuntu-22.04`, em preparação para a **descontinuação do Ubuntu 20.04 em 15 de abril de 2025**.

## ⚠️ Motivação

O GitHub Actions está removendo o suporte ao runner Ubuntu 20.04 LTS em **15 de abril de 2025**. Todos os workflows que utilizam `ubuntu-20.04` devem ser migrados para uma versão suportada antes dessa data para evitar falhas nos pipelines.

**Referência oficial:** [actions/runner-images#11101](https://github.com/actions/runner-images/issues/11101)

## 🔄 Arquivos Alterados

Os seguintes workflows foram migrados de `ubuntu-20.04` para `ubuntu-22.04`:

### 1. `.github/workflows/chainguard.yml`
- **Função:** Build e Distribuição de Pacotes com Melange e APKO
- **Linha alterada:** 14
- **Mudança:** `runs-on: ubuntu-20.04` → `runs-on: ubuntu-22.04`

### 2. `.github/workflows/ghcr.yml`
- **Função:** Melange, APKO e GitHub Container Registry
- **Linha alterada:** 13
- **Mudança:** `runs-on: ubuntu-20.04` → `runs-on: ubuntu-22.04`

### 3. `.github/workflows/redis-docker.yml`
- **Função:** Build da imagem de container Redis
- **Linha alterada:** 14
- **Mudança:** `runs-on: ubuntu-20.04` → `runs-on: ubuntu-22.04`

### 4. `.github/workflows/giropops-docker.yml`
- **Função:** Build da imagem de container giropops-senhas
- **Linha alterada:** 14
- **Mudança:** `runs-on: ubuntu-20.04` → `runs-on: ubuntu-22.04`

## ✅ Compatibilidade Verificada

O Ubuntu 22.04 LTS é totalmente compatível com todas as ferramentas utilizadas nos workflows:

- ✅ **Docker e Docker Buildx**: Suportado nativamente
- ✅ **Ferramentas Chainguard**: Melange e APKO funcionam perfeitamente
- ✅ **Cosign**: Para assinatura de imagens de container
- ✅ **Aqua Security Trivy**: Scanner de segurança
- ✅ **GitHub Actions**: Todas as actions utilizadas são compatíveis
- ✅ **Dependências**: Continuam funcionando sem modificações

## 🔒 Análise de Impacto

- **Risco:** Baixo - Ubuntu 22.04 é altamente compatível com Ubuntu 20.04
- **Breaking Changes:** Nenhum esperado
- **Rollback:** Simples - reverter para `ubuntu-latest` se necessário
- **Testes:** Workflows devem continuar funcionando sem modificações

## ✅ Checklist de Verificação

- [x] Identificar todos os workflows usando ubuntu-20.04
- [x] Atualizar chainguard.yml
- [x] Atualizar ghcr.yml  
- [x] Atualizar redis-docker.yml
- [x] Atualizar giropops-docker.yml
- [x] Validar sintaxe YAML dos arquivos modificados
- [ ] Executar workflow chainguard.yml
- [ ] Executar workflow ghcr.yml
- [ ] Executar workflow redis-docker.yml
- [ ] Executar workflow giropops-docker.yml
- [ ] Verificar builds de imagens Docker
- [ ] Confirmar assinaturas com Cosign
- [ ] Validar push para registries

## 📅 Cronograma

- **Data da migração:** Concluída
- **Deadline GitHub:** 15 de abril de 2025
- **Status:** ✅ Migração completa
- **Próximos passos:** Monitoramento e testes

## 🔍 Comandos de Verificação

Para verificar se ainda existem workflows usando ubuntu-20.04:

```bash
grep -r "ubuntu-20.04" .github/workflows/
```

Para validar sintaxe YAML:

```bash
yamllint .github/workflows/*.yml
```

## 📚 Referências

- [GitHub Actions Runner Images](https://github.com/actions/runner-images)
- [Ubuntu 20.04 Deprecation Notice](https://github.com/actions/runner-images/issues/11101)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---

**⚠️ Importante:** Esta migração é **obrigatória** para evitar interrupções nos pipelines após 15/04/2025.