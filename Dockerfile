FROM photon:5.0

# set argument defaults
ARG ARCH="amd64"
ARG VARIANT="hugo_extended"
ARG USER=vlabs
ARG USER_ID=1000
ARG GROUP=users
ARG GROUP_ID=100
#ARG LABEL_PREFIX=net.lab

# # add metadata via labels
# LABEL ${LABEL_PREFIX}.version="0.0.1"
# LABEL ${LABEL_PREFIX}.git.repo="git@github.com:grumpdumpty/hugo.git"
# LABEL ${LABEL_PREFIX}.git.commit="DEADBEEF"
# LABEL ${LABEL_PREFIX}.maintainer.name="Richard Croft"
# LABEL ${LABEL_PREFIX}.maintainer.email="rcroft@vmware.com"
# LABEL ${LABEL_PREFIX}.maintainer.url="https://github.com/grumpdumpty"
# LABEL ${LABEL_PREFIX}.released="9999-99-99"
# LABEL ${LABEL_PREFIX}.based-on="photon:5.0"
# LABEL ${LABEL_PREFIX}.project="hugo"

# update repositories, install packages, and then clean up
RUN tdnf update -y && \
    # grab what we can via standard packages
    tdnf install -y \
        bash \
        ca-certificates \
        coreutils \
        curl \
        diffutils \
        gawk \
        git \
        jq \
        ncurses \
        nodejs \
        shadow \
        tar \
        vim && \
    # add user/group
    # groupadd -g ${GROUP_ID} ${GROUP} && \
    # useradd -u ${USER_ID} -g ${GROUP} -m ${USER} && \
    useradd -g ${GROUP} -m ${USER} && \
    chown -R ${USER}:${GROUP} /home/${USER} && \
    # add /workspace and give user permissions
    mkdir -p /workspace && \
    chown -R ${USER}:${GROUP} /workspace && \
    # set git config
    git config --system --add init.defaultBranch "main" && \
    git config --system --add safe.directory "/workspace"

# install tini
RUN TINI_VERSION=$(curl -H 'Accept: application/json' -sSL https://github.com/krallin/tini/releases/latest | jq -r '.tag_name' | tr -d 'v') && \
    curl -L https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-${ARCH} > /usr/local/bin/tini && \
    chmod 0755 /usr/local/bin/tini

# install hugo
RUN VARIANT=${VARIANT} && \
    HUGO_VERSION=$(curl -H 'Accept: application/json' -sSL https://github.com/gohugoio/hugo/releases/latest | jq -r '.tag_name' | tr -d 'v') && \
    curl -skSLo hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${VARIANT}_${HUGO_VERSION}_linux-${ARCH}.tar.gz && \
    tar xzf hugo.tar.gz hugo && \    
    mv hugo /usr/local/bin && \
    chmod 0755 /usr/local/bin/hugo && \
    rm -rf hugo.tar.gz

# harden and remove unecessary packages
RUN chown -R root:root /usr/local/bin/ && \
    chown root:root /var/log && \
    chmod 0640 /var/log && \
    chown root:root /usr/lib/ && \
    chmod 755 /usr/lib/

# clean up
RUN tdnf erase -y unzip shadow && \
    tdnf clean all

# set user
USER ${USER}

# set working directory
WORKDIR /workspace

# set entrypoint to hugo, not a shell
ENTRYPOINT ["/usr/local/bin/hugo"]

#############################################################################
# vim: ft=unix sync=dockerfile ts=4 sw=4 et tw=78:
