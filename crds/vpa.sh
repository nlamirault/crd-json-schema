#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "verticalpodautoscalercheckpoints.autoscaling.k8s.io.yaml"
  "verticalpodautoscalers.autoscaling.k8s.io.yaml"
)

# renovate: datasource=github-tags depName=kubernetes/autoscaler
export VERSION=1.5.1

function generate_url {
  echo "https://raw.githubusercontent.com/kubernetes/autoscaler/refs/tags/vertical-pod-autoscaler-${VERSION}/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml"
}
