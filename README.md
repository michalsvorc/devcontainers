# Development containers

Docker development containers with my [profile](https://github.com/michalsvorc/profile) configuration.

## Features

- `./docker` script for Docker commands automation
- Debian slim images
- Rootless containers
- [Zsh](https://www.zsh.org/) shell

## Usage

```console
./docker --help
```

## Container networking

Find container IP address:

```
docker network inspect bridge | jq '.[].Containers'
```

## Environments

Every environment is based on `base` image. The `base` image must be built prior to building any other environment:

```console
./docker build
```

Build a specific environment image:

```console
./docker --env <environment_id> build
```

Run environment container:

```console
./docker --env <environment_id> run
```

Example:

```console
./docker --env python build --no-cache
./docker --env python run --rm
```

### Base

Environment id: `base`

To update system packages in existing `base` image, use Docker `--no-cache` flag:

```console
./scripts/docker.sh build --no-cache
```

You must rebuild environment images and create new containers as well.

### Node.js

Environment id: `nodejs`

Features:
- [Node.js LTS](https://nodejs.org/en/download/)
- [fnm](https://github.com/Schniz/fnm#readme)

### Python

Environment id: `python`

Features:
- [Python Version Manager](https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv)

### Go

Environment id: `go`

Features:
- [Managing Go Installations](https://go.dev/doc/manage-install)

## Troubleshooting

### Apple M1 MacBook

If you encounter issues with missing libraries, add `--platform linux/x86_64` flag after native docker commands:

```console
$ ./docker --env <environment> build --platform linux/x86_64
$ ./docker --env <environment> run --platform linux/x86_64
```
