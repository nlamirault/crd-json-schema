#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "kagent.dev_agentharnesses.yaml"
  "kagent.dev_agents.yaml"
  "kagent.dev_memories.yaml"
  "kagent.dev_modelconfigs.yaml"
  "kagent.dev_modelproviderconfigs.yaml"
  "kagent.dev_remotemcpservers.yaml"
  "kagent.dev_sandboxagents.yaml"
  "kagent.dev_toolservers.yaml"
)

# renovate: datasource=github-tags depName=kagent-dev/kagent
export VERSION=0.9.4

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kagent-dev/kagent/v${VERSION}/helm/kagent-crds/templates/${crd_file}"
}
