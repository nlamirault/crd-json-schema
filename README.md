# CRD Schema Store

A collection of JSON schemas extracted from Kubernetes Custom Resource Definitions (CRDs) for popular cloud-native applications and operators.

## Schema Organization

Schemas are organized by API group and follow the naming convention:

```
schemas/{api-group}/{kind}_{version}.json
```

For example:

- `schemas/argoproj.io/application_v1alpha1.json`
- `schemas/external-secrets.io/externalsecret_v1alpha1.json`
- `schemas/monitoring.coreos.com/prometheus_v1.json`

## Usage

### IDE Integration

#### VSCode

Add the following to your VSCode `settings.json`:

```json
{
  "yaml.schemas": {
    "https://raw.githubusercontent.com/nlamirault/kubernetes-schema-store/main/schemas/argoproj.io/application_v1alpha1.json": [
      "*/applications/*.yaml",
      "*/applications/*.yml"
    ],
    "https://raw.githubusercontent.com/nlamirault/kubernetes-schema-store/main/schemas/monitoring.coreos.com/prometheus_v1.json": [
      "*/prometheus/*.yaml",
      "*/prometheus/*.yml"
    ]
  }
}
```

### CLI Tools

Use with tools like `yq`, `kubeval`, or custom validation scripts:

```bash
# Validate an ArgoCD Application
curl -s https://raw.githubusercontent.com/nlamirault/kubernetes-schema-store/main/schemas/argoproj.io/application_v1alpha1.json | \
  yq eval 'validate(.)' my-application.yaml
```

## Development

### Prerequisites

- `bash` shell
- `yq` (YAML processor)
- `curl` or `wget`
- `slice` kubectl plugin
- Python 3.8+ with `uv` (for development environment)

### Adding New Applications

1. Create a new script in `crds/` directory following the naming convention `{app-name}.sh`
2. Define the required variables and functions:

```bash
#!/usr/bin/env bash

export separated=0  # 0 for individual files, 1 for bundle
export FILES=(
  "crd-file1.yaml"
  "crd-file2.yaml"
)

# renovate: datasource=github-tags depName=org/repo
export VERSION=1.0.0

function generate_url {
  local crd_file=$1
  echo "https://raw.githubusercontent.com/org/repo/v${VERSION}/manifests/${crd_file}"
}
```

3. Build the schemas:

```bash
make build APP=your-app-name
```

### Project Structure

```
├── crds/                    # CRD download scripts
├── schemas/                 # Generated JSON schemas (organized by API group)
├── scripts/
│   ├── commons.sh          # Common utility functions
│   └── schema-store.sh     # Main schema generation script
├── Makefile                # Build automation
└── README.md              # This file
```

### How It Works

1. **Download**: CRD scripts download the latest Custom Resource Definitions from upstream repositories
2. **Extract**: The `yq` tool extracts the `openAPIV3Schema` from each CRD
3. **Convert**: Schemas are converted to JSON format and organized by API group
4. **Cleanup**: Temporary files are removed after processing

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License

See the [LICENSE](LICENSE) file for details.
