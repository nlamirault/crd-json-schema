#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export separated=0
export FILES=(
  "eventbridge.services.k8s.aws_archives.yaml"
  "eventbridge.services.k8s.aws_endpoints.yaml"
  "eventbridge.services.k8s.aws_eventbuses.yaml"
  "eventbridge.services.k8s.aws_rules.yaml"
  "services.k8s.aws_adoptedresources.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/eventbridge-controller
export VERSION=1.1.1

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/eventbridge-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}