#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

export choice=individual
export FILES=(
  "openstack.k-orc.cloud_addressscopes.yaml"
  "openstack.k-orc.cloud_applicationcredentials.yaml"
  "openstack.k-orc.cloud_domains.yaml"
  "openstack.k-orc.cloud_endpoints.yaml"
  "openstack.k-orc.cloud_flavors.yaml"
  "openstack.k-orc.cloud_floatingips.yaml"
  "openstack.k-orc.cloud_groups.yaml"
  "openstack.k-orc.cloud_images.yaml"
  "openstack.k-orc.cloud_keypairs.yaml"
  "openstack.k-orc.cloud_networks.yaml"
  "openstack.k-orc.cloud_ports.yaml"
  "openstack.k-orc.cloud_projects.yaml"
  "openstack.k-orc.cloud_roles.yaml"
  "openstack.k-orc.cloud_routerinterfaces.yaml"
  "openstack.k-orc.cloud_routers.yaml"
  "openstack.k-orc.cloud_securitygroups.yaml"
  "openstack.k-orc.cloud_servergroups.yaml"
  "openstack.k-orc.cloud_servers.yaml"
  "openstack.k-orc.cloud_services.yaml"
  "openstack.k-orc.cloud_subnets.yaml"
  "openstack.k-orc.cloud_trunks.yaml"
  "openstack.k-orc.cloud_users.yaml"
  "openstack.k-orc.cloud_volumes.yaml"
  "openstack.k-orc.cloud_volumetypes.yaml"
)

# renovate: datasource=github-tags depName=k-orc/openstack-resource-controller
export VERSION=v2.5.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/k-orc/openstack-resource-controller/${VERSION}/config/crd/bases/${crd_file}"
}
