---
description: Look up Kubernetes CRD JSON schemas from OpenSpec HUB. Use when the user needs a $schema URL for a Kubernetes resource, wants to validate manifests, or asks about CRD schemas for operators like cert-manager, ArgoCD, Flux, External Secrets, Prometheus, etc.
---

Fetch the catalog and resolve the schema URL for the requested resource.

## Steps

1. Fetch https://openspec-hub.portefaix.xyz/data/catalog.json
2. Search `catalog.groups` — keys are API group names (e.g. `cert-manager.io`), values are arrays of `{ kind, version, file, slug }` objects
3. Match on `kind` (case-insensitive) and optionally `group`
4. Build the raw schema URL: `https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{file}`
5. Return the URL and offer the yaml-language-server snippet:
   `# yaml-language-server: $schema=<url>`

## Multiple versions

If multiple versions exist for the same kind, list all and suggest the highest stable version (prefer `v1` > `v1beta1` > `v1alpha1`).

## If not found

Tell the user the kind was not found in the catalog and link them to:
https://openspec-hub.portefaix.xyz
so they can search manually or open an issue to request the schema.
