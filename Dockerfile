FROM runatlantis/atlantis:v0.9.0

ARG TERRAGRUNT_VERSION=v0.19.26
ENV TERRAGRUNT_VERSION=$TERRAGRUNT_VERSION

# Download Terragrunt
RUN curl -s -Lo terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod +x terragrunt && \
    mv terragrunt /usr/local/bin

RUN chown -R atlantis:atlantis /usr/local/bin/atlantis

# Create ssh key if passed $GITHUB_USER_SSH_KEY
ADD create_ssh_key.sh /usr/local/bin/

# Rename original entry point
RUN mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-original.sh

# Add our new entrypoint to create ssh key and continue to run original entry point
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/create_ssh_key.sh
