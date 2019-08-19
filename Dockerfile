
FROM runatlantis/atlantis

MAINTAINER Steve Porter <12199424+StevePorter92@users.noreply.github.com>

ARG TERRAGRUNT_VERSION=v0.19.20
ENV TERRAGRUNT_VERSION=$TERRAGRUNT_VERSION

RUN curl -s -Lo terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod +x terragrunt && \
    mv terragrunt /usr/local/bin

RUN chown -R atlantis:atlantis /usr/local/bin/atlantis
