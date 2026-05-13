# Schema Hub: Schema Validation

Validate Kubernetes manifests against CRD JSON schemas sourced from Schema Hub.

## Schema URL pattern

```
https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{api-group}/{kind}_{version}.json
```

## kubeconform

```bash
kubeconform \
  -schema-location 'https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{{ .Group }}/{{ .ResourceKind }}_{{ .ResourceAPIVersion }}.json' \
  manifest.yaml
```

## yaml-language-server (VS Code / neovim)

Add this comment to the top of any Kubernetes YAML manifest:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{api-group}/{kind}_{version}.json
apiVersion: cert-manager.io/v1
kind: Certificate
```

## JSON Schema $schema field

```json
{
  "$schema": "https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/cert-manager.io/certificate_v1.json"
}
```

## Finding the right URL

Use the schema-lookup skill or fetch the catalog directly:
GET https://schema-hub.portefaix.xyz/data/catalog.json
