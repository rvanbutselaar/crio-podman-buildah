yum install -y podman crio buildah skopeo docker-distribution
systemctl enable docker-distribution && systemctl start docker-distribution
# goss & dgoss?
