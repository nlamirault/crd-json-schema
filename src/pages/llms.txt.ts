import type { APIRoute } from 'astro';
import catalog from '../../public/data/catalog.json';

const SITE = 'https://schema-hub.portefaix.xyz';

export const GET: APIRoute = () => {
    const groups = Object.entries(catalog.groups);
    const totalResources = groups.reduce((n, [, res]) => n + res.length, 0);

    const groupLines = groups
        .map(([group, resources]) => {
            const first = (resources as { slug: string }[])[0];
            const url = first ? `${SITE}/schemas/${first.slug}` : `${SITE}/schemas/${group}`;
            return `- [${group}](${url}): ${resources.length} resource${resources.length !== 1 ? 's' : ''}`;
        })
        .join('\n');

    const md = `\
# Schema Hub

> The central directory for Kubernetes Custom Resource Definitions. \
${totalResources.toLocaleString()} standardised JSON schemas across \
${groups.length} API groups covering AWS, GCP, Azure, GitOps, databases, \
observability, networking, security, and core Kubernetes.

## Overview

- **Total schemas**: ${totalResources.toLocaleString()}
- **API groups**: ${groups.length}
- **Source**: <https://github.com/nlamirault/schema-hub>
- **Raw schema base**: <https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/>
- **Machine-readable catalog**: <${SITE}/data/catalog.json>
- **Sitemap**: <${SITE}/sitemap.xml>

## Using schemas

Add a \`$schema\` reference to any Kubernetes manifest:

\`\`\`yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{api-group}/{kind}_{version}.json
apiVersion: example.io/v1
kind: MyResource
\`\`\`

With kubeconform:

\`\`\`bash
kubeconform \\
  -schema-location 'https://raw.githubusercontent.com/nlamirault/schema-hub/main/schemas/{{ .Group }}/{{ .ResourceKind }}_{{ .ResourceAPIVersion }}.json' \\
  manifest.yaml
\`\`\`

## API Groups

${groupLines}
`;

    return new Response(md, {
        headers: {
            'Content-Type': 'text/plain; charset=utf-8',
            'x-markdown-tokens': String(Math.ceil(md.length / 4)),
        },
    });
};
