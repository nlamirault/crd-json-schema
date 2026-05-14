import type { APIRoute } from 'astro';
import * as fs from 'node:fs';
import * as crypto from 'node:crypto';
import * as path from 'node:path';

const SITE = 'https://schema-hub.portefaix.xyz';
const SKILLS_DIR = path.resolve('public/.well-known/agent-skills');

function sha256Digest(filePath: string): string {
    const content = fs.readFileSync(filePath, 'utf-8');
    return 'sha256:' + crypto.createHash('sha256').update(content, 'utf-8').digest('hex');
}

const SKILLS = [
    {
        name: 'schema-lookup',
        type: 'skill-md' as const,
        description: 'Look up a Kubernetes CRD JSON schema by kind, API group, and version from the Schema Hub registry.',
        skillFile: path.join(SKILLS_DIR, 'schema-lookup', 'SKILL.md'),
        url: `${SITE}/.well-known/agent-skills/schema-lookup/SKILL.md`,
    },
    {
        name: 'schema-validate',
        type: 'skill-md' as const,
        description: 'Validate Kubernetes manifests against CRD schemas using kubeconform or yaml-language-server.',
        skillFile: path.join(SKILLS_DIR, 'schema-validate', 'SKILL.md'),
        url: `${SITE}/.well-known/agent-skills/schema-validate/SKILL.md`,
    },
];

export const GET: APIRoute = () => {
    const index = {
        $schema: 'https://schemas.agentskills.io/discovery/0.2.0/schema.json',
        skills: SKILLS.map(s => ({
            name: s.name,
            type: s.type,
            description: s.description,
            url: s.url,
            digest: sha256Digest(s.skillFile),
        })),
    };

    return new Response(JSON.stringify(index, null, 2), {
        headers: { 'Content-Type': 'application/json; charset=utf-8' },
    });
};
