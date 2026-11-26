FROM mcr.microsoft.com/devcontainers/python:1-3.12-bookworm

# La imagen base trae el repositorio APT de Yarn, cuya firma GPG ya no se puede
# verificar. Eso hace fallar "apt-get update" y, con él, la instalación de
# Docker (feature docker-in-docker). El curso no usa Yarn: se elimina esa fuente.
RUN grep -rl "dl.yarnpkg.com" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null \
      | xargs -r rm -f \
    && apt-get update \
    && rm -rf /var/lib/apt/lists/*
