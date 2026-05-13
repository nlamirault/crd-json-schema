/**
 * Cloudflare Pages Function middleware for Accept: text/markdown content negotiation.
 * Serves pre-generated .md endpoints when agents request markdown.
 * Ref: https://isitagentready.com/.well-known/agent-skills/markdown-negotiation/SKILL.md
 */

export async function onRequest({ request, next }) {
    const accept = request.headers.get('Accept') ?? '';
    const wantsMarkdown = accept.includes('text/markdown') || accept.includes('text/*');

    if (wantsMarkdown) {
        const url = new URL(request.url);
        const mdPath = url.pathname === '/' ? '/index.md' : `${url.pathname.replace(/\/$/, '')}.md`;
        const mdUrl = new URL(mdPath, url.origin).toString();

        try {
            const mdRes = await fetch(mdUrl);
            if (mdRes.ok) {
                const body = await mdRes.text();
                return new Response(body, {
                    status: 200,
                    headers: {
                        'Content-Type': 'text/markdown; charset=utf-8',
                        'Vary': 'Accept',
                        'x-markdown-tokens': String(Math.ceil(body.length / 4)),
                        'Cache-Control': 'public, max-age=3600',
                    },
                });
            }
        } catch {
            // No .md variant available — fall through to normal HTML response
        }
    }

    const response = await next();

    // Always advertise that Accept negotiation is supported
    const newHeaders = new Headers(response.headers);
    newHeaders.set('Vary', 'Accept');
    return new Response(response.body, {
        status: response.status,
        statusText: response.statusText,
        headers: newHeaders,
    });
}
