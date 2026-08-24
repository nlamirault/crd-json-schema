#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "karpenter.clever-cloud.com_clevernodeclasses.yaml"
)

# renovate: datasource=github-tags depName=CleverCloud/karpenter-provider-clever-cloud
export VERSION=0.12.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/CleverCloud/karpenter-provider-clever-cloud/v${VERSION}/deploy/crds/${crd_file}"
}
