#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "tuppr.home-operations.com_kubernetesupgrades.yaml"
  "tuppr.home-operations.com_talosupgrades.yaml"
)

# renovate: datasource=github-tags depName=home-operations/tuppr
export VERSION=0.1.35

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/home-operations/tuppr/refs/tags/${VERSION}/config/crd/bases/${crd_file}"
}
