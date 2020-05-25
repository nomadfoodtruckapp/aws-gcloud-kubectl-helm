# Update versions as needed.
FROM lachlanevenson/k8s-helm:v2.16.7
FROM lachlanevenson/k8s-kubectl:latest
FROM alpine:3.10


ENV AWSCLI_VERSION 1.16.190

RUN apk add -U --no-cache python3 ca-certificates \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 --no-cache-dir install awscli==${AWSCLI_VERSION}

COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl


CMD [ "echo", "hello world!" ]
