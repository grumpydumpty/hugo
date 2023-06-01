FROM photon:5.0

# set argument defaults
ARG ARCH="64bit"
ARG VARIANT="hugo_extended"
ARG VERSION="0.111.3"
#ARG LABEL_PREFIX=com.vmware.eocto

# add metadata via labels
#LABEL ${LABEL_PREFIX}.version="0.0.1"
#LABEL ${LABEL_PREFIX}.git.repo="git@gitlab.eng.vmware.com:sydney/containers/hugo.git"
#LABEL ${LABEL_PREFIX}.git.commit="DEADBEEF"
#LABEL ${LABEL_PREFIX}.maintainer.name="Richard Croft"
#LABEL ${LABEL_PREFIX}.maintainer.email="rcroft@vmware.com"
#LABEL ${LABEL_PREFIX}.maintainer.url="https://gitlab.eng.vmware.com/rcroft/"
#LABEL ${LABEL_PREFIX}.released="9999-99-99"
#LABEL ${LABEL_PREFIX}.based-on="photon:4.0"
#LABEL ${LABEL_PREFIX}.project="containers"

# set working to user's home directory
WORKDIR ${HOME}

# update repositories, install packages, and then clean up
RUN tdnf update -y && \
    tdnf install -y ca-certificates curl diffutils gawk git nodejs shadow tar && \
    # add user hugo
    useradd -u 1000 -m hugo && \
    chown -R 1000:100 /home/hugo && \
    # add /workspace and give hugo permissions
    mkdir -p /workspace && \
    chown -R hugo /workspace && \
    # set git config
    #git config --global --add safe.directory /workspace && \
    echo -e "[safe]\n\tdirectory=/workspace" > /etc/gitconfig && \
    # install tini
    export BUILDARCH="amd64" && \
    export TINI_RELEASE=$(curl -s https://api.github.com/repos/krallin/tini/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') && \
    curl -L https://github.com/krallin/tini/releases/download/v${TINI_RELEASE}/tini-${BUILDARCH} > /usr/local/bin/tini && \
    chmod 0755 /usr/local/bin/tini && \
    # install hugo
    export VARIANT=${VARIANT} && \
    export VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') && \
    curl -sL https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${VARIANT}_${VERSION}_Linux-${ARCH}.tar.gz | tar xz -C /usr/local/bin hugo && \
    chmod 0755 /usr/local/bin/hugo && \
    # clean up
    tdnf erase -y unzip && \
    tdnf clean all

# set user
USER hugo

# set working directory
WORKDIR /workspace

# set entrypoint to hugo, not a shell
ENTRYPOINT ["/usr/local/bin/hugo"]

#############################################################################
# vim: ft=unix sync=dockerfile ts=4 sw=4 et tw=78:
