# Nixos

Настройки сервера.

## Обновление системы

```bash
sudo nixos-rebuild --flake .#comfycamp switch
```

Перед установкой требуется заполнить файл /var/lib/secrets/certs.txt:
```bash
REGRU_USERNAME=xxx
REGRU_PASSWORD=xxx
```
Он должен быть доступен пользователю `acme`.

Нужно проверить ID пользователя `maddy` и ID группы `acme`,
они используются сервисом `maddy` для доступа к сертификатам.
При необходимости отредактировать `maddy.deployment.yml`.
