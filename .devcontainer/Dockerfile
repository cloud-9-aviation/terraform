FROM mcr.microsoft.com/devcontainers/base:noble

# https://developer.1password.com/docs/cli/install-server
COPY --from=1password/op:2-beta /usr/local/bin/op /usr/local/bin/op

RUN \
    apt-get update && \
    apt-get install \
    --yes \
    --no-install-recommends \
    gosu=1.17-1ubuntu0.24.04.2 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  curl -1sLf \
  'https://dl.cloudsmith.io/public/gitguardian/ggshield/setup.deb.sh' \
  | gosu root bash

RUN \
    apt-get update && \
    apt-get install \
    --yes \
    --no-install-recommends \
    ggshield=1.36.0-1 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/hadolint/hadolint:v2.12.1-beta-debian /bin/hadolint /usr/local/bin/hadolint
