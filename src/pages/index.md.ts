import type { APIRoute } from 'astro';
import catalog from '../../public/data/catalog.json';

const SITE = 'https://openspec-hub.portefaix.xyz';

const CATEGORIES: Array<{ name: string; match: (g: string) => boolean; description: string }> = [
    { name: 'AWS Infrastructure',  match: g => g.includes('aws') || g.includes('amazon'),                         description: 'ACK controllers and AWS service operators' },
    { name: 'Google Cloud',        match: g => g.includes('google') || g.includes('cnrm'),                        description: 'Config Connector CRDs for GCP services' },
    { name: 'Azure Ecosystem',     match: g => g.includes('azure') || g.includes('microsoft'),                    description: 'Azure Service Operator resources' },
    { name: 'GitOps & Deployment', match: g => g.includes('argoproj') || g.includes('fluxcd') || g.includes('kargo'), description: 'Argo CD, Flux CD, and Kargo resources' },
    { name: 'Databases & Storage', match: g => ['redis','mariadb','mysql','postgresql','clickhouse','dbfor'].some(k => g.includes(k)), description: 'Database operators' },
    { name: 'Observability',       match: g => ['monitoring','grafana','opentelemetry','prometheus'].some(k => g.includes(k)), description: 'Prometheus, Grafana, OpenTelemetry' },
    { name: 'Networking & Mesh',   match: g => ['networking','istio','gateway','envoy'].some(k => g.includes(k)), description: 'Istio, Gateway API, Envoy' },
    { name: 'Security',            match: g => ['security','cert-manager','external-secrets','doppler','hashicorp','sigstore','iam','kms'].some(k => g.includes(k)), description: 'cert-manager, external-secrets, Vault' },
    { name: 'Core Kubernetes',     match: g => g.includes('k8s.io'),                                              description: 'Native Kubernetes API resources' },
];

export const GET: APIRoute = () => {
    const groups = Object.entries(catalog.groups);
    const totalResources = groups.reduce((n, [, res]) => n + res.length, 0);

    const sections = CATEGORIES.map(cat => {
        const matched = groups.filter(([name]) => cat.match(name));
        if (!matched.length) return null;
        const count = matched.reduce((n, [, res]) => n + res.length, 0);
        const groupLinks = matched
            .slice(0, 10)
            .map(([name, res]) => {
                const r = (res as { slug: string }[])[0];
                return `  - [${name}](${SITE}/schemas/${name}) — ${res.length} resources`;
            })
            .join('\n');
        const more = matched.length > 10 ? `\n  - …and ${matched.length - 10} more groups` : '';
        return `### ${cat.name}\n\n${cat.description}. **${count} schemas** across ${matched.length} groups.\n\n${groupLinks}${more}`;
    }).filter(Boolean).join('\n\n');

    const md = `\
# OpenSpec HUB

> The central directory for Kubernetes Custom Resource Definitions. \
${totalResources.toLocaleString()} standardised JSON schemas across \
${groups.length} API groups and the cloud-native ecosystem.

- **Source**: <https://github.com/nlamirault/openspec-hub>
- **Catalog (JSON)**: <${SITE}/data/catalog.json>
- **Sitemap**: <${SITE}/sitemap.xml>
- **API Catalog**: <${SITE}/.well-known/api-catalog.json>

## Schema Categories

${sections}

## Integration

### VS Code (yaml-language-server)

\`\`\`yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{group}/{kind}_{version}.json
\`\`\`

### kubeconform

\`\`\`bash
kubeconform \\
  -schema-location 'https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/{{ .Group }}/{{ .ResourceKind }}_{{ .ResourceAPIVersion }}.json' \\
  manifest.yaml
\`\`\`
`;

    return new Response(md, {
        headers: {
            'Content-Type': 'text/markdown; charset=utf-8',
            'x-markdown-tokens': String(Math.ceil(md.length / 4)),
            'Vary': 'Accept',
        },
    });
};
