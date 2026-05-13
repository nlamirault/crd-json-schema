#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=bundle
export FILES=(
  "backends.gateway.envoyproxy.io.yaml"
  "backendtrafficpolicies.gateway.envoyproxy.io.yaml"
  "clienttrafficpolicies.gateway.envoyproxy.io.yaml"
  "envoyextensionpolicies.gateway.envoyproxy.io.yaml"
  "envoypatchpolicies.gateway.envoyproxy.io.yaml"
  "envoyproxies.gateway.envoyproxy.io.yaml"
  "httproutefilters.gateway.envoyproxy.io.yaml"
  "securitypolicies.gateway.envoyproxy.io.yaml"
)

# renovate: datasource=github-tags depName=envoyproxy/gateway
export VERSION=1.8.0

function generate_url {
  echo "https://github.com/envoyproxy/gateway/releases/download/v${VERSION}/envoy-gateway-crds.yaml"
}
