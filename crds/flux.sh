#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=kustomize
export FILES=(
  "alerts.notification.toolkit.fluxcd.io.yaml"
  "artifactgenerators.source.extensions.fluxcd.io.yaml"
  "buckets.source.toolkit.fluxcd.io.yaml"
  "externalartifacts.source.toolkit.fluxcd.io.yaml"
  "gitrepositories.source.toolkit.fluxcd.io.yaml"
  "helmcharts.source.toolkit.fluxcd.io.yaml"
  "helmreleases.helm.toolkit.fluxcd.io.yaml"
  "helmrepositories.source.toolkit.fluxcd.io.yaml"
  "imagepolicies.image.toolkit.fluxcd.io.yaml"
  "imagerepositories.image.toolkit.fluxcd.io.yaml"
  "imageupdateautomations.image.toolkit.fluxcd.io.yaml"
  "kustomizations.kustomize.toolkit.fluxcd.io.yaml"
  "ocirepositories.source.toolkit.fluxcd.io.yaml"
  "providers.notification.toolkit.fluxcd.io.yaml"
  "receivers.notification.toolkit.fluxcd.io.yaml"
)

# renovate: datasource=github-tags depName=fluxcd/flux2
export VERSION=2.7.2

function generate_url {
  echo "https://github.com/fluxcd/flux2/manifests/crds?ref=v${VERSION}"
}
