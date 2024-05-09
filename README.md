# Development containers

Docker development containers with my [profile](https://github.com/michalsvorc/profile) configuration.

## Features

- `./devcontainer` script for Docker commands automation
- Debian slim images
- Rootless containers
- [Zsh](https://www.zsh.org/) shell

## Usage

```shell
./devcontainer --help
```

## Container networking

Find container IP address:

```
./devcontainer network inspect bridge | jq '.[].Containers'
```

## Environments

Every environment is based on `base` image. The `base` image must be built prior to building any other environment:

```shell
./devcontainer build
```

Build a specific environment image:

```shell
./devcontainer --env <environment_id> build
```

Run environment container:

```shell
./devcontainer --env <environment_id> run
```

Example:

```shell
./devcontainer --env python build --no-cache
./devcontainer --env python run --rm
```

### Base

Environment id: `base`

To update system packages in existing `base` image, use Docker `--no-cache` flag:

```shell
./devcontainer build --no-cache
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

If you encounter issues with missing libraries, add `--platform linux/x86_64` flag after native Docker commands:

```shell
$ ./devcontainer --env <environment> build --platform linux/x86_64
$ ./devcontainer --env <environment> run --platform linux/x86_64
```
