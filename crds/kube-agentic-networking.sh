#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "agentic.networking.x-k8s.io_xaccesspolicies.yaml"
  "agentic.networking.x-k8s.io_xbackends.yaml"
  "agentic.prototype.x-k8s.io_xbackends.yaml"
)

# renovate: datasource=github-tags depName=kubernetes-sigs/kube-agentic-networking
export VERSION=0.1.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/kubernetes-sigs/kube-agentic-networking/v${VERSION}/k8s/crds/${crd_file}"
}
