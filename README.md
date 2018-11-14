# Requirements

- vagrant
- virtualbox

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html/managing_containers/finding_running_and_building_containers_without_docker

https://github.com/GoogleContainerTools/container-structure-test

# Start Vagrant
```
vagrant up && vagrant ssh
sudo -i
ps aux | grep docker
```

https://github.com/containers/libpod/issues/1523
rootless mode is not working on RHEL 7.5 as the newuidmap/newgidmap tools are not available there so there is no way to set up the user namespace

# List and pull images
```
podman pull nginx:latest
podman images
```

# Run a container
```
podman run -it nginx:latest bash
```

# List all (non-)running containers
```
podman ps -a
```

# Remove container based on it's name
```
podman rm hungry_ritchie
```

# Remove all unused images
```
podman rmi $(podman images -a -q)
```

# Build a container using podman
```
cat <<EOF >Dockerfile
FROM alpine:latest
ENTRYPOINT ["echo"]
CMD ["Podman build this container."]
EOF
podman build -t podbuilt .
podman run podbuilt

```

# Buildah
## No Daemon!: Buildah bypasses the Docker daemon! So no container runtime (Docker, CRI-O, or other) is needed to use Buildah.
## Base image or scratch: Lets you not only build an image based on another container, but also lets you start with an empty image (scratch).
## Build tools external: Doesn’t include build tools within the image itself. As a result, Buildah:
### Reduces the size of images you build
### Makes the image more secure by not having the software used to build the container (like gcc, make, and dnf) within the resulting image.
### Creates images that require fewer resources to transport the images (because they are smaller).


# Build image using buildah
```
cat <<EOF >Dockerfile
FROM centos:latest
ADD myecho /usr/local/bin
ENTRYPOINT "/usr/local/bin/myecho"
EOF
cat <<EOF >myecho
echo "This container works!"
EOF
chmod 755 myecho
buildah bud -t myecho .
```

# List images using buildah
```
buildah images
```

# Runing a container build by buildah
```
buildah from myecho
podman run myecho
```

# Pushing containers to a repository
```
buildah push --tls-verify=false podbuilt:latest localhost:5000/podbuilt:latest
```

# Inspect a public docker image
```
skopeo inspect docker://docker.io/library/mariadb
```


# Install and run container using Docker
```
yum install -y docker && systemctl start docker
docker pull localhost:5000/podbuilt:latest && docker run localhost:5000/podbuilt:latest
```
