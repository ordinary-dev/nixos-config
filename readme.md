# Nixos

My home server settings.

## Upgrade

```bash
sudo nixos-rebuild --flake .#comfycamp switch
```

## Required files

### Acme

- /var/lib/secrets/certs.txt:

```bash
REGRU_USERNAME=xxx
REGRU_PASSWORD=xxx
```

The file must be available to the `acme` user.

### Mastodon

- /var/lib/mastodon/otp-secret.txt
- /var/lib/mastodon/postgres.txt
- /var/lib/mastodon/secret-key-base.txt
- /var/lib/mastodon/smtp-password.txt
- /var/lib/mastodon/vapid-private-key.txt
- /var/lib/mastodon/vapid-public-key.txt

### Nextcloud

- /var/lib/nextcloud/admin-pass.txt

### Synapse

- /var/lib/matrix-synapse/config.yml

```yml
registration_shared_secret: xxx
macaroon_secret_key: xxx
form_secret: xxx
```
