# Pod errors due to “too many open files”

## Causa

Isso pode ser causado por esgotamento dos recursos inotify. O inotify é um mecanismo do kernel do Linux que permite que aplicativos monitorem alterações em arquivos e diretórios.

Quando esses limites são atingidos, os aplicativos que dependem do inotify podem encontrar erros relacionados a "muitos arquivos abertos". Nesses casos, é necessário aumentar os limites de recursos do inotify para permitir que o sistema monitore mais arquivos e diretórios.

Os limites de recursos são definidos pelas variáveis ​​de sistema fs.inotify.max_user_watches e fs.inotify.max_user_instances. Por exemplo, no Ubuntu, esses padrões são 8192 e 128 respectivamente, o que não é suficiente para criar um cluster com muitos nós.

## Solução

### Para aumentar esses limites temporariamente, execute os seguintes comandos no host

```
sysctl fs.inotify.max_user_watches=524288
sysctl fs.inotify.max_user_instances=512
```

*Para tornar as alterações persistentes, edite o arquivo /etc/sysctl.conf nos nós e adicione estas linhas:*  

fs.inotify.max_user_watches = 524288
fs.inotify.max_user_instances = 512
