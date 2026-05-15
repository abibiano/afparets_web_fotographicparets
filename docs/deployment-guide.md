# Deployment Guide — FOTOgraphic Parets

## Infrastructure

| Item | Value |
|------|-------|
| Hosting | OVH VPS |
| OS | Ubuntu |
| Server Alias | `ovh-afparets` (SSH config alias) |
| SSH Port | 28419 |
| SSH User | `ubuntu` |
| Web Root | `/var/www/fotographicparets.com/public` |
| Web User | `www-data` |
| Live URL | https://fotographicparets.com |

## Deployment Method

Manual deployment via `make deploy`. No CI/CD pipeline is configured — deployment is always triggered manually by the developer.

**Flow:**
```
make deploy
    ↓
hugo --gc --minify --cleanDestinationDir  (builds to public/)
    ↓
rsync public/ → ubuntu@ovh-afparets:/home/ubuntu/.afparets_deploy/  (staging)
    ↓
ssh: sudo rsync staging → /var/www/fotographicparets.com/public  (promotion with www-data ownership)
    ↓
ssh: sudo chmod 755 dirs, 644 files
```

## SSH Configuration

The Makefile uses an SSH key and config alias. Set up your `~/.ssh/config`:

```
Host ovh-afparets
    HostName <OVH_IP_ADDRESS>
    User ubuntu
    Port 28419
    IdentityFile ~/.ssh/ovh-afparets
```

The SSH key path defaults to `~/.ssh/ovh-afparets`. You can override it:
```bash
make deploy DEPLOY_KEY=~/.ssh/my-other-key
```

## Deployment Steps

### 1. Deploy (build + push)

```bash
make deploy
```

This runs the full pipeline: clean build → rsync → promote.

### 2. Build only (no deploy)

```bash
make build
# Output in public/
```

### 3. Deploy a pre-built site

If you've already run `make build`, you can push without rebuilding by running the rsync and SSH commands directly from the Makefile. However, `make deploy` always rebuilds first.

## Makefile Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DEPLOY_USER` | `ubuntu` | SSH user on the VPS |
| `DEPLOY_HOST` | `ovh-afparets` | SSH host alias |
| `DEPLOY_PORT` | `28419` | SSH port |
| `DEPLOY_PATH` | `/var/www/fotographicparets.com/public` | Remote web root |
| `DEPLOY_KEY` | `~/.ssh/ovh-afparets` | SSH private key path |
| `PUBLIC_DIR` | `public` | Local build output directory |

Override any variable on the command line:
```bash
make deploy DEPLOY_HOST=192.168.1.100
```

## Remote Server File Permissions

After each deployment:
- **Directories:** `chmod 755` (rwxr-xr-x)
- **Files:** `chmod 644` (rw-r--r--)
- **Ownership:** `www-data:www-data`

The web server (Nginx or Apache) runs as `www-data` and reads files with these permissions.

## Staging Pattern

The Makefile uses a two-step promotion to avoid serving a partial site during deployment:

1. **Rsync to staging area:** `~ubuntu/.afparets_deploy/`
2. **Atomic promotion:** `sudo rsync` from staging to web root

This minimizes downtime because the final promotion is a fast local server-side rsync.

## Environment Configuration

There are no runtime environment variables for this static site. All configuration is in:
- `config.toml` — Hugo site config (baseURL, language, params)
- `Makefile` — deployment variables
- `~/.ssh/config` — SSH connection details (local developer machine)

The `baseURL = "https://fotographicparets.com/"` in `config.toml` must match the live domain.

## Pre-Deployment Checklist

Before running `make deploy`:

- [ ] Run `hugo server -D` locally and verify all pages render correctly
- [ ] Check that `baseURL` in `config.toml` is set to the production URL (not localhost)
- [ ] Verify SSH connectivity: `ssh -p 28419 ubuntu@ovh-afparets echo ok`
- [ ] Confirm no draft content is intended for production (remove `draft: true` from frontmatter)
- [ ] Review any new images are web-optimized (Hugo will process them, but oversized originals slow builds)

## Rollback

There is no automated rollback mechanism. To roll back:

1. Restore a previous `public/` directory from git history or backup
2. Manually rsync the old files to the server:
   ```bash
   rsync -az --delete -e "ssh -p 28419 -i ~/.ssh/ovh-afparets" \
     public/ ubuntu@ovh-afparets:/var/www/fotographicparets.com/public/
   ```

## No CI/CD

This project has no `.github/workflows/` or other CI/CD pipeline. All deployments are manual via `make deploy` on a developer machine with SSH access.

If CI/CD is added in the future, the `make build` and `make deploy` targets provide the build and deploy commands needed.
