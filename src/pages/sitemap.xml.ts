import type { APIRoute } from 'astro';
import catalog from '../../public/data/catalog.json';

const SITE = 'https://schema-hub.portefaix.xyz';

function buildUrls(): string[] {
    const urls: string[] = ['/'];
    for (const [group, resources] of Object.entries(catalog.groups)) {
        urls.push(`/schemas/${group}`);
        for (const res of resources as { slug: string }[]) {
            urls.push(`/schemas/${res.slug}`);
        }
    }
    return urls;
}

export const GET: APIRoute = () => {
    const entries = buildUrls();
    const xml = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
        ...entries.map(u => `  <url><loc>${SITE}${u}</loc></url>`),
        '</urlset>',
    ].join('\n');

    return new Response(xml, {
        headers: { 'Content-Type': 'application/xml; charset=utf-8' },
    });
};
