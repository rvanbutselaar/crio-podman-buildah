yum-config-manager --add-repo=https://cbs.centos.org/repos/paas7-crio-311-candidate/x86_64/os/
yum install --nogpgcheck cri-o crictl
yum install -y podman buildah skopeo docker-distribution
systemctl enable docker-distribution && systemctl start docker-distribution
# goss & dgoss?
curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
