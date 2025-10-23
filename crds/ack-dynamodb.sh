#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export separated=0
export FILES=(
  "dynamodb.services.k8s.aws_backups.yaml"
  "dynamodb.services.k8s.aws_globaltables.yaml"
  "dynamodb.services.k8s.aws_tables.yaml"
  "services.k8s.aws_adoptedresources.yaml"
  "services.k8s.aws_fieldexports.yaml"
)

# renovate: datasource=github-tags depName=aws-controllers-k8s/dynamodb-controller
export VERSION=1.6.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/aws-controllers-k8s/dynamodb-controller/refs/tags/v${VERSION}/helm/crds/${crd_file}"
}