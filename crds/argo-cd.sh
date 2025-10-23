#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export separated=0
export FILES=(
  "application-crd.yaml"
  "applicationset-crd.yaml"
  "appproject-crd.yaml"
)

# renovate: datasource=github-tags depName=argoproj/argo-cd
export VERSION=3.1.9

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/argoproj/argo-cd/v${VERSION}/manifests/crds/${crd_file}"
}
