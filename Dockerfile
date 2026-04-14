FROM linuxserver/code-server:latest
LABEL org.opencontainers.image.authors="ivo@schimani.de"

RUN apt update -y && apt install -y \
    bash-completion \
    dnsutils \
    htop \
    iputils-ping \
    jq \
    make \
    openssh-client \
    python3 \
    python3-pip \
    python3-venv \
    shellcheck \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Node.js LTS (Extension Host, LSPs, Claude Code)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# Docker CLI + Compose + Buildx
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

RUN tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

RUN apt update -y && apt install -y \
    docker-ce-cli \
    docker-compose-plugin \
    docker-buildx-plugin \
    && rm -rf /var/lib/apt/lists/*

# lazydocker
RUN LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | jq -r .tag_name | sed 's/v//') \
    && curl -fsSL "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_$(uname -m | sed 's/aarch64/arm64/;s/x86_64/x86_64/').tar.gz" \
    | tar xzf - -C /usr/local/bin lazydocker

# yq
RUN curl -fsSL "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_$(dpkg --print-architecture)" -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

RUN chsh -s /bin/bash abc

EXPOSE 8443