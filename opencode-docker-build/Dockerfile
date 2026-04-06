FROM alpine AS base

# Installiere notwendige Abhängigkeiten, einschließlich git und curl für gh cli
# Deaktiviert den Laufzeit-Transpiler-Cache in Docker-Containern standardmäßig.
# Bei kurzlebigen Containern ist der Cache nicht nützlich
ARG BUN_RUNTIME_TRANSPILER_CACHE_PATH=0
ENV BUN_RUNTIME_TRANSPILER_CACHE_PATH=${BUN_RUNTIME_TRANSPILER_CACHE_PATH}
RUN apk add --no-cache libgcc libstdc++ ripgrep git curl bash

# Installiere GitHub CLI
RUN apk add --no-cache github-cli

FROM base AS build-amd64
COPY dist/opencode-linux-x64-baseline-musl/bin/opencode /usr/local/bin/opencode

FROM base AS build-arm64
COPY dist/opencode-linux-arm64-musl/bin/opencode /usr/local/bin/opencode

ARG TARGETARCH
FROM build-${TARGETARCH}
RUN opencode --version
ENTRYPOINT ["opencode"]
