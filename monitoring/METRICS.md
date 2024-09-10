# Métricas de Monitoramento

Este documento descreve as métricas de monitoramento disponíveis na aplicação giropops-senhas.

## Métricas relacionadas ao Garbage Collector (GC) do Python

### `python_gc_objects_collected_total`

**Título em português:** Objetos coletados durante o GC
**Descrição:** Esta métrica representa o número total de objetos coletados durante a execução do Garbage Collector do Python.

### `python_gc_objects_uncollectable_total`

**Título em português:** Objetos não coletáveis encontrados durante o GC
**Descrição:** Esta métrica representa o número total de objetos não coletáveis encontrados durante a execução do Garbage Collector do Python.

### `python_gc_collections_total`

**Título em português:** Número de vezes que essa geração foi coletada
**Descrição:** Esta métrica representa o número total de vezes que cada geração do Garbage Collector do Python foi coletada.

## Métrica relacionada à informação da plataforma Python

### `python_info`

**Título em português:** Informações da plataforma Python
**Descrição:** Esta métrica fornece informações sobre a plataforma Python, incluindo a implementação, versão principal, versão secundária, nível de patch e a versão completa.

## Métricas relacionadas ao processo

### `process_virtual_memory_bytes`

**Título em português:** Tamanho da memória virtual em bytes
**Descrição:** Esta métrica representa o tamanho da memória virtual utilizada pelo processo em bytes.

### `process_resident_memory_bytes`

**Título em português:** Tamanho da memória residente em bytes
**Descrição:** Esta métrica representa o tamanho da memória residente utilizada pelo processo em bytes.

### `process_start_time_seconds`

**Título em português:** Tempo de início do processo desde a época Unix em segundos
**Descrição:** Esta métrica representa o tempo de início do processo desde a época Unix em segundos.

### `process_cpu_seconds_total`

**Título em português:** Tempo total de CPU do usuário e do sistema gasto em segundos
**Descrição:** Esta métrica representa o tempo total de CPU do usuário e do sistema gasto pelo processo em segundos.

### `process_open_fds`

**Título em português:** Número de descritores de arquivo abertos
**Descrição:** Esta métrica representa o número de descritores de arquivo abertos pelo processo.

### `process_max_fds`

**Título em português:** Número máximo de descritores de arquivo abertos
**Descrição:** Esta métrica representa o número máximo de descritores de arquivo que o processo pode abrir.

## Métricas personalizadas

### `senha_gerada_total`

**Título em português:** Contador de senhas geradas
Esta métrica representa o número total de senhas geradas.

### `senha_gerada_created`

**Título em português:** Contador de senhas geradas
**Descrição:** Esta métrica representa o número de senhas geradas.
