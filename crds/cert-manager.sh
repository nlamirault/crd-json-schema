#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export separated=0
export FILES=(
  "acme.cert-manager.io_challenges.yaml"
  "acme.cert-manager.io_orders.yaml"
  "cert-manager.io_certificaterequests.yaml"
  "cert-manager.io_certificates.yaml"
  "cert-manager.io_clusterissuers.yaml"
  "cert-manager.io_issuers.yaml"
)

# renovate: datasource=github-tags depName=argoproj/argo-cd
export VERSION=v3.1.9

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/cert-manager/cert-manager/refs/tags/v${VERSION}/deploy/crds/${crd_file}"
}
