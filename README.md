# portfolio-archive

Frozen, prebuilt copies of the earlier versions of my portfolio, served side by side so the current site ([portfolio-v5](https://github.com/peterszarvas94/portfolio-v5), https://peterszarvas.hu) can link to them.

| Version | URL | Source | Commit | Stack |
|---|---|---|---|---|
| v1 | https://v1.peterszarvas.hu | portfolio-v1 | `e684ca5` (2026-11-23) | Create React App, React Bootstrap |
| v2 | https://v2.peterszarvas.hu | portfolio-v2 | `126879a` (2026-11-23) | Astro 2, Tailwind CSS |
| v3 | https://v3.peterszarvas.hu | portfolio-v3 | `d0d8108` (2026-11-23) | Astro 5, Tailwind CSS, daisyUI |
| v4 | https://v4.peterszarvas.hu | portfolio-v4 | `22814ed` (2026-10-22) | Go, templ |

The source repositories are archived, so these are the built files, not something rebuilt on deploy. v1 and v2 have no lockfiles and would drift if rebuilt.

## How the copies were built

- **v1**: `npm install --legacy-peer-deps`, then `npm install --no-save ajv@8` (Create React App 5 needs it with current npm) and `CI=false npx react-scripts build`. The Netlify `_redirects` file is dropped; the Caddyfile does the single-page fallback.
- **v2**: built as static output instead of the old Vercel server adapter (`output: "static"`, no adapter). astro-icon 0.8 fetched icons from an API that no longer exists, so the build used local `ic` and `mdi` packs in `src/icons/` that read from `@iconify-json/ic` and `@iconify-json/mdi`.
- **v3**: `bun install --frozen-lockfile && bun run build` (output in `dist/`).
- **v4**: `templ generate`, then `go run ./cmd` (output in `public/`).

## Deploy

Coolify on hub builds the `Dockerfile` (build pack: Dockerfile, port 8080): Caddy serves each version by host name. Unknown hosts redirect to https://peterszarvas.hu. Locally:

```sh
docker build -t portfolio-archive . && docker run --rm -p 8080:8080 portfolio-archive
curl -H 'Host: v1.localhost' http://localhost:8080/
```
