# Container Image for Hugo on Photon OS

![](logo.png)

## Status

|                |                                                                                                                                                                          |
|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Pipeline       | [![pipeline status](https://gitlab.eng.vmware.com/sydney/containers/hugo/badges/main/pipeline.svg)](https://gitlab.eng.vmware.com/sydney/containers/hugo/-/commits/main) |
| Coverage       | [![coverage report](https://gitlab.eng.vmware.com/sydney/containers/hugo/badges/main/coverage.svg)](https://gitlab.eng.vmware.com/sydney/containers/hugo/-/commits/main) |
| Latest Release | [![Latest Release](https://gitlab.eng.vmware.com/sydney/containers/hugo/-/badges/release.svg)](https://gitlab.eng.vmware.com/sydney/containers/hugo/-/releases)          |

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

## Variables

### Harbor Variables

These can be set at any level but we generally set them at the group or project level.

| Variable        | Value                                                                           |
|-----------------|---------------------------------------------------------------------------------|
| HARBOR_HOST     | hostname of harbor instance, no `http://` or `https://`                         |
| HARBOR_CERT     | PEM format certificate with each `\n` (actual char) replaced with `"\n"` string |
|                 | Run the following command:                                                      |
|                 | `cat harbor.crt \| sed -E '$!s/$/\\n/' \| tr -d '\n'`                           |
|                 | where `harbor.crt`                                                              |
| HARBOR_USER     | Username of harbor user with permissions to push images                         |
| HARBOR_EMAIL    | Email  of harbor user with permissions to push images                           |
| HARBOR_PASSWORD | Password of harbor user with permissions to push images                         |

### GitLab Variables

| GitLab Env Var            | Value |
|---------------------------|-------|
| CI_COMMIT_AUTHOR          |       |
| CI_COMMIT_BRANCH          |       |
| CI_COMMIT_SHA             |       |
| CI_COMMIT_SHORT_SHA       |       |
| CI_COMMIT_TIMESTAMP       |       |
| CI_PAGES_DOMAIN           |       |
| CI_PAGES_URL              |       |
| CI_PIPELINE_CREATED_AT    |       |
| CI_PROJECT_DIR            |       |
| CI_PROJECT_NAME           |       |
| CI_PROJECT_NAMESPACE      |       |
| CI_PROJECT_PATH           |       |
| CI_PROJECT_PATH_SLUG      |       |
| CI_PROJECT_ROOT_NAMESPACE |       |
| CI_PROJECT_TITLE          |       |
| CI_PROJECT_URL            |       |
| CI_SERVER_HOST            |       |
| CI_SERVER_PORT            |       |
| CI_SERVER_PROTOCOL        |       |
| CI_SERVER_URL             |       |
| CI_TEMPLATE_REGISTRY_HOST |       |
| GITLAB_USER_EMAIL         |       |
| GITLAB_USER_LOGIN         |       |
| GITLAB_USER_NAME          |       |
