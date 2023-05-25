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
    tdnf install -y ca-certificates gawk git nodejs tar && \
    git config --global --add safe.directory /src && \
    export VARIANT=${VARIANT} && \
    export VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') && \
    curl -skSLo ${VERSION}.tar.gz https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${VARIANT}_${VERSION}_Linux-${ARCH}.tar.gz && \
    tar xzf ${VERSION}.tar.gz hugo && \
    mv hugo /usr/local/bin && \
    rm ${VERSION}.tar.gz && \
    tdnf erase -y unzip && \
    tdnf clean all

# set entrypoint to hugo, not a shell
ENTRYPOINT ["/usr/local/bin/hugo"]

#############################################################################
# vim: ft=unix sync=dockerfile ts=4 sw=4 et tw=78:
