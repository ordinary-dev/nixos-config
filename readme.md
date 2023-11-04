# Nixos

My home server settings.

## Upgrade

```bash
sudo nixos-rebuild --flake .#comfycamp switch
```

## Services

| Name       | Url                                            |
| ---        | ---                                            |
| Mastodon   | [m.comfycamp.space](https://m.comfycamp.space) |
| Synapse    | matrix.comfycamp.space                         |
| Jellyfin   | Private                                        |
| Photoprism | Private                                        |
| Nextcloud  | Private                                        |
| Maddy      | Private                                        |
| Plausible  | Private                                        |

## Required files

- /var/lib/secrets/certs.txt

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


### Mail

- /var/lib/mta-sts/.well-known/mta-sts.txt

```
version: STSv1
mode: enforce
max_age: 604800
mx: mx.comfycamp.space
```

The file must be available to the `nginx` user.


### Plausible

- /var/lib/secrets/plausible/admin-pass.txt
- /var/lib/secrets/plausible/keybase.txt
- /var/lib/secrets/plausible/release-cookie.txt
- /var/lib/secrets/plausible/smtp-pass.txt
