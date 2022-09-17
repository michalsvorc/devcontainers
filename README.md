# Development containers

Docker development containers with basic CLI tools intended for development in isolation.

## Features

- `docker.sh` shell script for Docker commands automation
- Debian slim images
- Rootless containers
- Containers are not removed after stopping
- [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements/) builds
- [Zsh](https://www.zsh.org/) shell:
  - [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [fzf completion](https://github.com/Aloxaf/fzf-tab)
- Customizable [user profiles](#user-profile)

## Usage

```console
$ ./bin/docker.sh --help
```

## Environments

### Base

```console
$ ./bin/docker.sh build
```

Base image must be built before building other environment. You can provide the Docker `--no-cache` flag after the
`build` command to rebuild images with updated system packages.

### Node.js

```console
$ ./bin/docker.sh --env nodejs build
$ ./bin/docker.sh --env nodejs run
```

Features:
- [Node Version Manager](https://github.com/nvm-sh/nvm)
- Node.js [LTS version](https://nodejs.org/en/about/releases/)

## User profile

User profile is as collection of user specific configuration files. Defaults to
[https://github.com/michalsvorc/devcontainers-profile](https://github.com/michalsvorc/devcontainers-profile).

### Custom user profile

Specify custom user profile repository URL with `--user-profile` flag during the base image build.

```
$ ./bin/docker.sh --user-profile <repository-url> build --no-cache
```

Custom user profile repository must implement `init.sh` shell script to create softlinks from `${HOME}/.local/profile`
to `$HOME`.

