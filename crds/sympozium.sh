#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "sympozium.ai_agentruns.yaml"
  "sympozium.ai_agents.yaml"
  "sympozium.ai_ensembles.yaml"
  "sympozium.ai_mcpservers.yaml"
  "sympozium.ai_models.yaml"
  "sympozium.ai_skillpacks.yaml"
  "sympozium.ai_sympoziumconfigs.yaml"
  "sympozium.ai_sympoziumpolicies.yaml"
  "sympozium.ai_sympoziumschedules.yaml"
)

# renovate: datasource=github-tags depName=sympozium-ai/sympozium
export VERSION=v0.10.48

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/sympozium-ai/sympozium/refs/tags/${VERSION}/config/crd/bases/${crd_file}"
}
