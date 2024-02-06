# Components

Provides a container image for running Hugo (extended).

This image includes the following components:

| Component        | Version  | Description                                                                 |
|------------------|----------|-----------------------------------------------------------------------------|
| VMware Photon OS | 4.0      | A Linux container host optimized for vSphere and cloud-computing platforms. |
| NodeJS           |          |                                                                             |
| Hugo             | Extended | A static website generator                                                  |


| Package/Tool                         | Version  |
|--------------------------------------|----------|
| ahmetb/kubectx                       | v0.9.5   |
| derailed/k9s                         | v0.31.7  |
| gohugoio/hugo                        | v0.122.0 |
| hashicorp/packer                     | v1.10.1  |
| hashicorp/packer-plugin-vsphere      | v1.2.4   |
| hashicorp/terraform                  | v1.7.2   |
| hashicorp/terraform-provider-vsphere | v2.6.1   |
| helm/helm                            | v3.14.0  |
| jesseduffield/lazydocker             | v0.23.1  |
| jesseduffield/lazygit                | v0.40.2  |
| krallin/tini                         | v0.19.0  |
| kubernetes-sigs/cluster-api          | v1.6.1   |