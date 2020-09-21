ARG REGISTRY
ARG WORKLOAD
FROM ${REGISTRY}/accord/theia-full:latest as theia

FROM ${REGISTRY}/accord/${WORKLOAD}:latest

# Theia boilerplate
COPY --from=theia /usr/local /usr/local
EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/usr/local/theia/plugins \
    USE_LOCAL_GIT=true
WORKDIR /usr/local/theia
ENTRYPOINT [ "node", "/usr/local/theia/src-gen/backend/main.js", "/project", "--hostname=0.0.0.0" ]
# /Theia boilerplate