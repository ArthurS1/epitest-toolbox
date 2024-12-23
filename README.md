## Epitest Toolbox

**This repository is no longer updated - do not hesitate to fork it.**

### Requirements

You need to install `podman` (an alternative to docker present on fedora 31+), to build correctly epitest-toolbox image.
Furthermore, this image is meant to be used with toolbox. Toolbox is a way to develop in immutable systems such as fedora silverblue.

### Notable changes

This toolbox image doesn't contain php because of httpd's incompatibility with rootless containerisation.

### Epitest-Toolbox

Build the image with podman :

``` bash
cd HUB_epitest_toolbox_2020
podman build . -t epitest-toolbox
```

Use it within the toolbox environment :

``` bash
toolbox create -i epitest-toolbox
```
