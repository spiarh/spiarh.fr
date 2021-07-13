---
title: "podman/docker"
linkTitle: "podman/docker"
date: 2017-01-05
---

### Use ssh-agent

```bash
podman run -ti --rm \
    -v "$(dirname "$SSH_AUTH_SOCK")":"$(dirname "$SSH_AUTH_SOCK")" \
    -e SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
    r.spiarh.fr/alpine
```

### Run without isolation

```bash
podman run -ti --rm \
  --privileged \
  --userns=keep-id \
  --group-add keep-groups \
  --net=host \
  --cgroups=disabled \
  --pid=host \
  --ipc=host
```

### Use graphical tool

Before running the container, user inside the container (root)
must be allowed to make connections to the X server. User here
is `root` because container run in rootless mode.

```bash
xhost local:root
```

For example, start `tor-browser`:

```bash
podman run -u root --rm -ti \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/snd:/dev/snd \
    -v /dev/shm:/dev/shm \
    -v /etc/machine-id:/etc/machine-id:ro \
    -e DISPLAY=$DISPLAY \
    r.spiarh.fr/tor-browser
```
