# Deferred Work

## AFParets main site — 2025 history entry

**Context:** The AFParets site (`/Users/abibiano/Projects/Web/afparets`) has a placeholder at `content/fotographic/2025.md`. This should be updated after the fotographicparets.com 2026 deploy.

**Tasks:**
1. Copy 9 winner/finalist photos from `tmp/CONCURS-2025/FOTOS PARTICIPANTS/` (files: `49.- ressorgint de la penombra.jpg`, `29.- Rastre de fum.jpg`, `21.- Contrallum.jpg`, `47.- desafio.jpg`, `31.- SKATE_PARETS_1.jpg`, `17.- Foscor B.jpg`, `14.- Equilibrio en Suspenso.jpg`, `13.- Chispa de Control.jpg`, `7.- Força i equilibri.jpg`) → `/Users/abibiano/Projects/Web/afparets/static/fotographic/2025/`
2. Update `/Users/abibiano/Projects/Web/afparets/content/fotographic/2025.md` (TOML frontmatter) with 2025 edition summary: Danny Vela, skateboard, 29 novembre 2025, winner Ignasi Pallisa "Ressorgint de la Penombra", use `fotographic-grid` shortcode with all 9 image paths `/fotographic/2025/FILENAME` (follow 2024 pattern in that file).

**Source data:** `tmp/CONCURS-2025/Acta fotographic 25.pdf` — jury verdict, winner and finalist names confirmed.

---

## Surfaced during review (not caused by this change)

- **danny-vela redirect:** `/ponencias/danny-vela/` now 404s. Add a Hugo alias or Nginx redirect if inbound links exist from social media or the 2025 event.
- **YAML `\` backslash fragility:** The `data/agenda/2026.yaml` A/B blocks use `\` for Markdown line breaks inside YAML literal blocks. Works in Goldmark but any YAML reformatter or editor that strips trailing backslashes will silently merge the lines. Document this in a code comment or switch to `<br>` inside the body string.
- **Stray `hu` in `image-carrousel.html`:** `layouts/shortcodes/image-carrousel.html` line 1 has a stray `hu` that renders as literal text if the shortcode is ever called. Not used in 2026 content, but should be cleaned up.
- **Dead `$page` variable in `schedule.html` partial:** `layouts/partials/components/schedule.html` passes `Page` but never uses it — dead code.
- **`data/sponsors.yaml` field name inconsistency:** File uses `image:` but `project-context.md` documents it as `logo:`. Template reads `$item.image` (works), but the schema doc is wrong. Update `project-context.md`.
- **`sponsors.html` inline style:** Template renders `style="max-height:Npx"` from the `height:` field, violating the no-inline-style rule. Refactor to a CSS utility class in `styles.scss`.
