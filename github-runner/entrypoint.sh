#!/bin/bash
set -e

# Adapted from https://github.com/docker/github-actions-runner/blob/main/scr/entrypoint.sh

deregister_runner() {
  echo "Caught SIGTERM. Deregistering runner"
  ./config.sh remove --token "${RUNNER_TOKEN}"
  exit
}

configure_runner() {
  echo "Configuring"
  ./config.sh \
      --url "${REPO_URL}" \
      --token "${RUNNER_TOKEN}" \
      --name "${RUNNER_NAME}" \
      --unattended \
      --replace
}

configure_runner

trap deregister_runner SIGINT SIGQUIT SIGTERM INT TERM QUIT

./run.sh