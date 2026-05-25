#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "agentgateway.dev_agentgatewaybackends.yaml"
  "agentgateway.dev_agentgatewayparameters.yaml"
  "agentgateway.dev_agentgatewaypolicies.yaml"
)

# renovate: datasource=github-tags depName=agentgateway/agentgateway
export VERSION=1.2.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/agentgateway/agentgateway/refs/tags/v${VERSION}/controller/install/helm/agentgateway-crds/templates/${crd_file}"
}
