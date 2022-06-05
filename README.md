# Development containers

Docker development containers with basic CLI tools intended for develpment in isolation.

## Features

- `docker.sh` shell script for Docker commands automation
- Debian slim images
- rootless containers
- [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/) builds
- [Zsh](https://www.zsh.org/) shell
  - [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [fzf completion](https://github.com/Aloxaf/fzf-tab)
- Persistent [volumes](#volumes)

## Usage

```console
$ ./bin/docker.sh --help
```

## Environments

### Base

```console
$ ./bin/docker.sh build
```

Base image, must be built before building other environment.

### Node.js

```console
$ ./bin/docker.sh --environment nodejs build
$ ./bin/docker.sh --environment nodejs run
```

Features:
- [Node Version Manager](https://github.com/nvm-sh/nvm)
- Node.js [LTS version](https://nodejs.org/en/about/releases/)

## Volumes

Persisted container directory reusable across multiple development containers.

### devcontainer-local

- Directory: `${HOME}/.local/`
- Content: [user profile](#user-profile) configuration files, local executables

### devcontainer-ssh

- Directory: `${HOME}/.ssh/`
- Content: SSH keys

## User profile

Defaults to [https://github.com/michalsvorc/devcontainers-profile](https://github.com/michalsvorc/devcontainers-profile).

Specify custom user profile repository URL with `--user-profile` flag during base image build.

Custom user profile must contain `init.sh` shell script to link configuration files from Docker volume
`${HOME}/.local/profile` to container `$HOME`.

