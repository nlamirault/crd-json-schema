# Schema Hub: Schema Lookup

Retrieve a Kubernetes CRD JSON schema by kind, API group, and version from the Schema Hub registry.

## Catalog endpoint

GET https://schema-hub.portefaix.xyz/data/catalog.json

The response is a JSON object with a `groups` key that maps API group names to arrays of resources:

```json
{
  "groups": {
    "cert-manager.io": [
      {
        "kind": "Certificate",
        "version": "v1",
        "file": "cert-manager.io/certificate_v1.json",
        "slug": "cert-manager.io/v1/certificate"
      }
    ]
  }
}
```

## Lookup steps

1. Fetch `catalog.json`
2. Search `groups` for entries where `kind` (case-insensitive) and/or group name match the query
3. Build the raw schema URL from the `file` field:

```
https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{file}
```

## Direct URL pattern

```
https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{api-group}/{kind}_{version}.json
```

Example:
```
https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/cert-manager.io/certificate_v1.json
```

## Browse

Human-readable schema pages: https://schema-hub.portefaix.xyz/schemas/{slug}
