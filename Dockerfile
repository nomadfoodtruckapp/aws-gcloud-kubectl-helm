# Update versions as needed.
FROM lachlanevenson/k8s-helm:v2.16.7
FROM lachlanevenson/k8s-kubectl:latest
FROM alpine:3.10


ENV AWSCLI_VERSION 1.16.190

RUN apk add -U --no-cache python3 ca-certificates \
    && apk add --update curl \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 --no-cache-dir install awscli==${AWSCLI_VERSION}

COPY --from=0 /usr/local/bin/helm /usr/local/bin/helm
COPY --from=1 /usr/local/bin/kubectl /usr/local/bin/kubectl

RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator && chmod +x ./aws-iam-authenticator
RUN mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin


CMD [ "echo", "hello world!" ]
