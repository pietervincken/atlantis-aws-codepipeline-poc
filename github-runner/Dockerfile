FROM mcr.microsoft.com/dotnet/runtime:9.0

RUN apt-get update
RUN apt-get install -y curl

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /actions-runner

RUN curl -o actions-runner-linux-arm64-2.329.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-linux-arm64-2.329.0.tar.gz
RUN tar -xzf ./actions-runner-linux-arm64-2.329.0.tar.gz
RUN ./bin/installdependencies.sh
COPY entrypoint.sh /actions-runner/entrypoint.sh
RUN chmod +x /actions-runner/entrypoint.sh

RUN groupadd -r ghrunner && useradd -r -g ghrunner ghrunner
RUN chown -R ghrunner:ghrunner /actions-runner
USER ghrunner

CMD [ "/actions-runner/entrypoint.sh" ]