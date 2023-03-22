# Container Image for Hugo on Photon OS

## Overview

Provides a container image for running Hugo (extended).

This image includes the following components:

| Component        | Version  | Description                                                                 |
|------------------|----------|-----------------------------------------------------------------------------|
| VMware Photon OS | 4.0      | A Linux container host optimized for vSphere and cloud-computing platforms. |
| NodeJS           |          |                                                                             |
| Hugo             | Extended | A static website generator                                                  |

## Get Started

Run the following to download the latest container from Harbor:

```bash
docker pull harbor.sydeng.vmware.com/rcroft/hugo:latest
```

Run the following to download a specific version from Harbor:

```bash
docker pull harbor.sydeng.vmware.com/rcroft/hugo:x.y.z
```

Open an interactive terminal:

```bash
docker run --rm -it harbor.sydeng.vmware.com/rcroft/hugo
```

Run a local script:

```bash
docker run --rm --entrypoint="/usr/bin/hugo" -v /path/to/hugo/src:/src -w /src harbor.sydeng.vmware.com/rcroft/hugo
```

Where `/path/to/hugo/src` is the local directory path for the source for the Hugo website.

