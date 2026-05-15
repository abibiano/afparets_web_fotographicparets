---
project_name: 'afparets_web_fotographicparets'
user_name: 'Alex'
date: '2026-05-15'
sections_completed:
  ['technology_stack', 'language_rules', 'framework_rules', 'content_data_rules', 'quality_rules', 'workflow_rules', 'anti_patterns']
status: 'complete'
rule_count: 42
optimized_for_llm: true
---

# Project Context for AI Agents

_Critical rules and patterns AI agents must follow when implementing code in this project. Focused on unobvious details agents might otherwise miss._

---

## Technology Stack & Versions

- **Hugo** — static site generator (config.toml, Go HTML templates, Goldmark markdown)
- **Bootstrap 5.3.3** — CSS framework (mounted from node_modules into Hugo asset pipeline)
- **SCSS + PostCSS CLI 11.0.0** — CSS pre-processing
- **Go HTML Templates** — all layouts under `layouts/`
- **Node.js / npm** — only for Bootstrap and PostCSS; no frontend JS framework
- **Make + rsync + SSH** — deployment to OVH VPS (Ubuntu)
- **Hugo image processing** — built-in Resize/Fill/Fit with fingerprinting
- Content: Markdown + YAML frontmatter | Data: YAML files in `data/`

---

## Critical Implementation Rules

### Go Template Rules

- All page templates must use `{{ define "main" }}...{{ end }}` — never write bare HTML
- Partial calls: `{{ partial "name.html" . }}` — always pass context (`.`) or a dict
- Pass data to components via dict: `{{ partial "components/schedule.html" (dict "agenda" $agenda "page" .) }}`
- Use `{{ with .Params.field }}...{{ end }}` for conditional rendering — safer than bare `{{ if }}`
- `cond` for inline ternary: `{{ cond .IsHome $site.Title (printf "%s | %s" .Title $site.Title) }}`
- `or` for fallback chains: `{{ or .Params.seo.description .Params.description .Description }}`
- Templates inherit from `baseof.html` via `block "main"` — page templates define this block
- Use `-` to strip whitespace: `{{- partial "head.html" . -}}`
- Save outer context before `with`: `{{ $page := . }}` — `with` changes `.` to the matched value

### SCSS Rules

- Import order in `main.scss` is MANDATORY: `custom_variables.scss` → `bootstrap.scss` → `styles.scss`
- Never import Bootstrap before `custom_variables.scss` — overrides will not apply
- Bootstrap variable overrides only in `custom_variables.scss`, never in `styles.scss`
- Use `@include media-breakpoint-up(lg)` — never raw `@media` queries for breakpoints
- Use `$primary`, `$accent`, `$light`, `$dark` variables — never hardcode brand hex values
- CSS custom properties defined in `:root {}` in `custom_variables.scss`; use `var(--color-accent)` in styles

### Asset Pipeline Rules

- All CSS and images MUST go through Hugo's fingerprint pipeline for cache busting
- CSS pipeline: `resources.Get "scss/main.scss" | toCSS $options | postCSS | minify | fingerprint`
- Images in templates: `resources.Get "img/..." | .Resize "WxH"` or `.Fill` or `.Fit`
- Images in content: use existing shortcodes (`image-resize`, `image-fill`, `image-fit`, `image-carrousel`)
- Static files (favicons, PDFs) go in `static/` — NOT processed by asset pipeline
- Bootstrap JS is mounted from `node_modules` — do not copy it to `static/`

### Content Frontmatter Schema

- Standard fields: `title`, `description`, `date`, `draft`
- Homepage (`_index.md`): `hero.badge`, `hero.title`, `hero.subtitle`, `hero.description`, `hero.actions[]` (`label`, `url`, `variant`, `disabled`), `hero.meta[]` (`label`, `value`), `highlights[]` (`title`, `description`, `url`)
- Speaker pages (`ponencias/*.md`): `schedule`, `participants`, `moderator`
- SEO overrides: `seo.description`, `og_image`
- Never add frontmatter fields without a corresponding template consuming them

### Data File Conventions

- `data/sponsors.yaml` — top-level keys: `organizers` and `partners`; each entry: `name`, `logo` (path relative to `assets/`), `url`; optional `width`/`height` as `"WxH"` string
- `data/agenda/YEAR.yaml` — `title` (Catalan date string), `items[]` with `time` (HH:MM) and `title`, optional `description`
- Access in templates: `.Site.Data.sponsors`, `.Site.Data.agenda.2025`
- YAML keys with hyphens: use `index .Site.Data "key-name"` — dot notation breaks

### Template Resolution Rules

- Hugo picks most specific template: `layouts/ponencias/single.html` beats `layouts/_default/single.html`
- New sections need both `content/SECTION/_index.md` AND `layouts/SECTION/list.html`
- Schedule component is NOT auto-included — list template must call it and pass agenda data explicitly

### Code Quality & Style Rules

- File naming: `kebab-case` for all templates, SCSS files, content, data, images, and shortcodes
- Use Bootstrap utility classes for layout spacing — no custom CSS for margins/padding
- Responsive grid: always `col-12 col-md-X col-lg-Y` (mobile-first)
- All text content in **Catalan (`ca`)** — never hardcode strings in Spanish or English
- External links opening in new tab: must include `rel="noopener"`
- No inline `style=""` attributes — all styling via SCSS or Bootstrap utilities
- Component styles in `styles.scss` with a descriptive comment header per component
- Never use `!important` unless unavoidable when overriding Bootstrap
- No custom JavaScript — Bootstrap bundle only; interactive behavior via Bootstrap JS or pure CSS

### Development Workflow Rules

- Dev server: `hugo server` | with drafts: `hugo server -D`
- Production build: `hugo --gc --minify --cleanDestinationDir` — all three flags required
- Run `npm install` before first build (PostCSS dependency)
- Deploy ONLY via `make deploy` — never rsync manually (permission errors)
- Never commit `public/` — build output, git-ignored and wiped on every build
- `resources/` is Hugo cache — git-ignored, never edit manually

### Critical Anti-Patterns

- **Never hardcode URLs** — use `.Permalink`, `absURL`, or Hugo menu system
- **Never skip fingerprinting** on CSS or images — breaks cache busting
- **Never edit `public/`** — wiped on every build
- **Never call a partial without context** — `{{ partial "name.html" }}` loses all page/site data
- **Never duplicate SCSS imports** — Bootstrap imported once in `main.scss` only
- **Never add custom JS files** — only Bootstrap bundle in `footer.html`

### Hugo-Specific Gotchas

- `resources.Get` path is relative to `assets/` — use `resources.Get "img/logo.png"` not `resources.Get "assets/img/logo.png"`
- `static/` files served at root — `static/img/foo.png` → `/img/foo.png` in HTML; NOT accessible via `resources.Get`
- Image shortcodes use `resources.Get` — they silently fail for files in `static/`
- `.Site.Data.agenda` returns a map keyed by filename without extension — use `.Site.Data.agenda.2025`
- Drafts (`draft: true`) excluded from production builds — set `draft: false` before deploying
- Every new page needs a `description` in frontmatter — no automatic fallback on list pages
- OG image defaults to `img/logos/logo-fotographic.png` — override per page with `og_image` frontmatter field

---

## Usage Guidelines

**For AI Agents:** Read this file before implementing any code. Follow all rules exactly. When in doubt, prefer the more restrictive option.

**For Humans:** Keep lean and focused. Update when the technology stack changes. Review after each event edition (annual cycle).

Last Updated: 2026-05-15
