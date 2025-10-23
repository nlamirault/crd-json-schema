#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export separated=0
export FILES=(
  "analysis-run-crd.yaml"
  "analysis-template-crd.yaml"
  "cluster-analysis-template-crd.yaml"
  "experiment-crd.yaml"
  "rollout-crd.yaml"
)

# renovate: datasource=github-tags depName=argoproj/argo-rollouts
export VERSION=1.8.3

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/argoproj/argo-rollouts/v${VERSION}/manifests/crds/${crd_file}"
}
