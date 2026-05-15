# Architecture — FOTOgraphic Parets

## Executive Summary

FOTOgraphic Parets is a Hugo static site. All pages are compiled at build time from Markdown content + Go templates into static HTML/CSS/JS files. There is no runtime server, no database, and no API. The compiled output is deployed to an OVH VPS via rsync over SSH.

## Architecture Pattern: Static Site Generation (SSG)

```
Content (Markdown/YAML)  +  Templates (Go HTML)  +  SCSS
         │                          │                  │
         └──────────────────────────┘                  │
                     Hugo Build                        │
                         │                        PostCSS
                         └──────────────────────────┘
                                   │
                              public/ (static files)
                                   │
                              rsync via SSH
                                   │
                          OVH VPS /var/www/...
```

## Technology Stack

| Layer | Technology | Details |
|-------|-----------|---------|
| SSG | Hugo | `config.toml`, Go templates, Goldmark markdown |
| CSS Framework | Bootstrap 5.3.3 | Mounted from `node_modules` into Hugo asset pipeline |
| CSS Pre-processing | SCSS + PostCSS CLI | `assets/scss/` → fingerprinted CSS bundle |
| Templating | Go HTML Templates | `layouts/` directory |
| Content | Markdown + YAML frontmatter | `content/` directory |
| Data | YAML data files | `data/` directory |
| Image Processing | Hugo built-in | Resize, Fill, Fit operations with fingerprinting |
| Deployment | Make + rsync + SSH | Target: OVH VPS, Ubuntu |

## Hugo Template Hierarchy

Hugo resolves templates in a specific order. The rendering flow for any page is:

```
baseof.html (base layout)
    │
    ├── head.html (partial)       → SEO, SCSS compilation, meta tags
    ├── header.html (partial)     → Sticky navbar with Bootstrap
    │
    ├── [page-specific template]
    │   ├── index.html            → Homepage (hero, features, highlights)
    │   ├── _default/single.html  → Generic single page
    │   ├── _default/list.html    → Generic list page
    │   ├── ponencias/list.html   → Program page (with schedule component)
    │   └── ponencias/single.html → Speaker detail page (with carousel)
    │
    ├── sponsors.html (partial)   → Organizers + partners display
    └── footer.html (partial)     → Copyright, social links, Bootstrap JS
```

### Template Resolution Priority

Hugo selects the most specific template available. For example, `/ponencias/danny-vela/` resolves to `layouts/ponencias/single.html` before `layouts/_default/single.html`.

## Partials & Components

### `partials/head.html`
- Builds full `<head>` block
- Compiles SCSS: `assets/scss/main.scss` → `toCSS` → PostCSS → fingerprinted `<link>`
- Injects SEO metadata: title, description, canonical URL, Open Graph tags
- Uses `params.seo.default_image` for OG fallback image

### `partials/header.html`
- Sticky Bootstrap navbar (`sticky-top`)
- Brand logo image (resized to 60px height)
- Menu items from `sectionPagesMenu = "main"` in `config.toml`
- Dropdown support via Bootstrap JS

### `partials/sponsors.html`
- Reads `data/sponsors.yaml`
- Dynamically renders organizer logos and partner logos
- Handles `width` / `height` specifications in YAML (e.g., `"200x50"` → separate width/height)
- Uses Hugo's `ImageFit` with fingerprinting

### `partials/components/schedule.html`
- Reads agenda data from a `agenda` variable passed by the page template
- Renders a table or list of time-slotted activities
- Data source: `data/agenda/2025.yaml`
- Gracefully handles missing agenda data

### Shortcodes

| Shortcode | Hugo Method | Usage |
|-----------|------------|-------|
| `image-fill` | `.Fill` | Crop and fill to exact dimensions |
| `image-fit` | `.Fit` | Scale to fit within dimensions |
| `image-resize` | `.Resize` | Resize by width or height |
| `image-carrousel` | `.Fit` | For carousel/slider images |

All shortcodes apply fingerprinting to the processed image URL.

## SCSS Architecture

```
assets/scss/
├── main.scss               → Entry point: imports in correct order
├── custom_variables.scss   → Bootstrap variable overrides (colors, fonts)
└── styles.scss             → Custom component styles
```

**Import order in `main.scss`:**
1. `custom_variables.scss` — must come before Bootstrap to override variables
2. Bootstrap (mounted from `node_modules/bootstrap/scss`)
3. `styles.scss` — custom styles layered on top

**Custom Design Tokens (`custom_variables.scss`):**
- Primary color (brand dark)
- Secondary/accent/info/success/warning/danger colors
- Font families (custom heading + body fonts)
- Background and text color overrides
- CSS custom properties (`--bs-*` overrides)

**`styles.scss` covers:**
- Body, heading, and text typography
- Button variants and hover states
- Sticky header scroll behavior
- Hero section (full-height, background, CTA layout)
- Card grid and hover effects
- Content styles (`.content-styles` for markdown output)
- Schedule table styling
- Sponsors grid (responsive, logo sizing)
- Footer layout and social icons

## Data Layer

Hugo's `data/` directory stores structured content that templates can access via `.Site.Data`.

### `data/sponsors.yaml`
```yaml
organizers:
  - name: "Associació Fotogràfica Parets"
    logo: "img/logos/logo-afparets.png"
    url: "..."
  - name: "Danny Vela"
    ...
partners:
  - name: "Ajuntament de Parets del Vallès"
    logo: "img/logos/logo-ajuntament-parets.png"
    ...
  # 9 partner entries total
```

### `data/agenda/2025.yaml`
```yaml
title: "Dissabte 29 de novembre de 2025"
items:
  - time: "09:30"
    title: "Acreditació i recollida de material"
    description: "..."
  # 13 time-slotted activities
```

## Content Frontmatter

Hugo content files use YAML frontmatter between `---` markers. The site uses custom frontmatter fields beyond the standard Hugo ones:

**Homepage (`_index.md`) custom fields:**
- `hero.badge`, `hero.title`, `hero.subtitle`, `hero.description`
- `hero.cta` — array of call-to-action buttons (label, url, style)
- `highlights` — array of feature cards (title, description, icon, url)

**Speaker (`ponencias/danny-vela.md`) custom fields:**
- `schedule` — when the session occurs
- `participants` — number of participants
- `moderator` — session moderator

## Asset Pipeline

Hugo processes assets through its built-in asset pipeline:

1. **SCSS compilation:** `resources.Get "scss/main.scss" | toCSS | postCSS`
2. **Minification:** `| minify` (in production builds via `hugo --minify`)
3. **Fingerprinting:** `| fingerprint` — adds content hash to filenames for cache busting
4. **Image processing:** `resources.Get image | .Resize/.Fill/.Fit` — on-demand image transformation
5. **Bootstrap JS:** Mounted from `node_modules` and included in footer with SRI hash

## SEO Implementation

Handled in `partials/head.html`:
- `<title>` — page-specific with site title suffix
- `<meta name="description">` — from page description or site description
- `<link rel="canonical">` — absolute URL
- Open Graph tags: `og:title`, `og:description`, `og:image`, `og:url`, `og:type`
- Fallback OG image: `params.seo.default_image`
- `<html lang="">` — set from Hugo's language code (`ca`)

## Build & Deployment

See [development-guide.md](./development-guide.md) and [deployment-guide.md](./deployment-guide.md) for detailed instructions.

### Build Command
```bash
hugo --gc --minify --cleanDestinationDir
```
- `--gc` — garbage collect unused cache files
- `--minify` — minify HTML, CSS, JS output
- `--cleanDestinationDir` — remove stale output files

### Deployment Command
```bash
make deploy
```
- Builds the site
- Rsyncs `public/` to a staging area on the OVH VPS
- Promotes staged files to `/var/www/fotographicparets.com/public` with `www-data` ownership
- Sets correct file permissions (755 dirs, 644 files)

## No Backend Components

This is a 100% static site:
- No API endpoints
- No database (YAML data files are compile-time only)
- No authentication
- No server-side rendering
- No state management (beyond browser)
- Registration links to an external form (Google Forms or similar)
