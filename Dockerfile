FROM base:dev

# set argument defaults
ARG OS_ARCH="amd64"
ARG VARIANT="hugo_extended"

# Switch to root to install OS packages
USER root:root

# update repositories, install packages, and then clean up
RUN tdnf update -y && \
    # grab what we can via standard packages
    tdnf install -y \
        nodejs && \
    # clean up
    tdnf clean all

# install tini
RUN TINI_VERSION=$(curl -H 'Accept: application/json' -sSL https://github.com/krallin/tini/releases/latest | jq -r '.tag_name' | tr -d 'v') && \
    curl -L https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-${OS_ARCH} > /usr/local/bin/tini && \
    chmod 0755 /usr/local/bin/tini

# install hugo
RUN HUGO_VARIANT=${VARIANT} && \
    HUGO_VERSION=$(curl -H 'Accept: application/json' -sSL https://github.com/gohugoio/hugo/releases/latest | jq -r '.tag_name' | tr -d 'v') && \
    curl -skSLo hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_VARIANT}_${HUGO_VERSION}_linux-${OS_ARCH}.tar.gz && \
    tar xzf hugo.tar.gz hugo && \    
    mv hugo /usr/local/bin && \
    chmod 0755 /usr/local/bin/hugo && \
    rm -rf hugo.tar.gz

# harden and remove unnecessary packages
RUN chown -R root:root /usr/local/bin/ && \
    chown root:root /var/log && \
    chmod 0640 /var/log && \
    chown root:root /usr/lib/ && \
    chmod 755 /usr/lib/

# switch back to non-root user
USER ${USER}

# set entrypoint to hugo, not a shell
ENTRYPOINT ["/usr/local/bin/hugo"]

#############################################################################
# vim: ft=unix sync=dockerfile ts=4 sw=4 et tw=78:
