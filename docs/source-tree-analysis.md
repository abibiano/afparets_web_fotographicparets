# Source Tree Analysis — FOTOgraphic Parets

## Annotated Directory Structure

```
afparets_web_fotographicparets/          ← Project root
│
├── config.toml                          ← Hugo site config (baseURL, language, params, modules)
├── package.json                         ← npm deps: Bootstrap 5.3.3, PostCSS CLI
├── package-lock.json                    ← Locked npm dependency tree
├── Makefile                             ← Build and deploy automation
├── README.md                            ← Developer setup guide
├── .markdownlint.json                   ← Markdown lint config (allows HTML, no line limit)
├── .gitignore                           ← Ignores public/, resources/, node_modules/
│
├── content/                             ← ★ Site content (Markdown + HTML)
│   ├── _index.md                        ← Homepage content (hero, highlights, CTAs)
│   ├── ponencias/                       ← Lectures / program section
│   │   ├── _index.md                    ← Program overview page (list view)
│   │   └── danny-vela.md               ← Speaker bio + session details
│   ├── concurso.md                      ← National photo contest rules & prizes
│   ├── exposiciones-fotographic.md      ← Previous edition's exhibition winners
│   ├── quienes-somos.md                ← About the association (history 2013–2024)
│   ├── guia.md                          ← Visitor guide (maps, transport, restaurants)
│   ├── opiniones.html                   ← Testimonials (raw HTML file, not processed)
│   └── politica-privacidad.md          ← Privacy policy
│
├── layouts/                             ← ★ Hugo Go templates
│   ├── index.html                       ← Homepage template (hero + features + highlights)
│   ├── 404.html                         ← Custom 404 error page
│   ├── _default/                        ← Fallback templates for any content type
│   │   ├── baseof.html                  ← Base HTML document skeleton (lang, head, header, main, footer)
│   │   ├── single.html                  ← Default single page (title + content)
│   │   └── list.html                    ← Default list page (title + child page cards)
│   ├── ponencias/                       ← Section-specific templates (override _default for this section)
│   │   ├── list.html                    ← Program list page with schedule component
│   │   └── single.html                  ← Speaker detail page (bio + carousel + session metadata)
│   ├── partials/                        ← Reusable template fragments
│   │   ├── head.html                    ← <head>: SEO meta, SCSS compilation, canonical URL
│   │   ├── header.html                  ← Sticky Bootstrap navbar with logo and nav links
│   │   ├── footer.html                  ← Copyright, social links, Bootstrap JS injection
│   │   ├── sponsors.html                ← Organizers + partners logo grid from sponsors.yaml
│   │   └── components/
│   │       └── schedule.html            ← Event schedule table from agenda YAML data
│   └── shortcodes/                      ← Custom {{< shortcode >}} tags for content files
│       ├── image-fill.html              ← {{< image-fill src="" width="" height="" alt="" >}}
│       ├── image-fit.html               ← {{< image-fit src="" width="" height="" alt="" >}}
│       ├── image-resize.html            ← {{< image-resize src="" width="" alt="" >}}
│       └── image-carrousel.html         ← {{< image-carrousel src="" width="" height="" alt="" >}}
│
├── assets/                              ← ★ Hugo asset pipeline source files
│   ├── scss/                            ← SCSS source (compiled by Hugo + PostCSS)
│   │   ├── main.scss                    ← Entry point: imports variables → Bootstrap → styles
│   │   ├── custom_variables.scss        ← Bootstrap variable overrides (colors, fonts, tokens)
│   │   └── styles.scss                  ← Custom components (hero, cards, schedule, sponsors...)
│   ├── img/                             ← Web-optimized images (processed by Hugo pipeline)
│   │   ├── proximamente.png             ← "Coming soon" placeholder image
│   │   ├── logo-fotographic2025-completo-300.jpg ← Navbar brand logo
│   │   ├── opiniones/                   ← 12 testimonial author photos
│   │   ├── logos/                       ← 13 sponsor/partner logos
│   │   ├── icons/                       ← 3 SVG icons (Facebook, email, web)
│   │   └── concurso-resultado/
│   │       └── guanyadors/              ← 3 contest prize-winning photographs
│   └── originales/                      ← High-res source images (TIF, high-quality JPEGs)
│       └── [logos + photography TIFs]   ← Source material, not referenced in templates directly
│
├── data/                                ← ★ Structured YAML data (accessed in templates as .Site.Data)
│   ├── sponsors.yaml                    ← Organizers (2) + partners (9) with logo paths and URLs
│   └── agenda/
│       └── 2025.yaml                    ← Full event schedule (13 items, 9:30–20:00)
│
├── static/                              ← Static files (copied as-is to public/)
│   └── favicon.ico                      ← Site favicon
│
├── archetypes/                          ← Templates for `hugo new` command
│   └── default.md                       ← Default frontmatter template for new content
│
├── docs/                                ← ★ Project documentation (this directory)
│   ├── index.md                         ← Master documentation index
│   ├── project-overview.md              ← Project summary and purpose
│   ├── architecture.md                  ← Technical architecture documentation
│   ├── source-tree-analysis.md          ← This file
│   ├── component-inventory.md           ← Template components catalog
│   ├── development-guide.md             ← Dev setup and workflow
│   ├── deployment-guide.md              ← Deployment process
│   └── project-scan-report.json        ← Workflow state file
│
├── node_modules/                        ← npm dependencies (Bootstrap, PostCSS) [git-ignored]
├── public/                              ← Hugo build output [git-ignored]
├── resources/                           ← Hugo cache (processed assets) [git-ignored]
└── tmp/                                 ← Temporary files [git-ignored]
```

## Critical Directories

| Directory | Role | AI Guidance |
|-----------|------|-------------|
| `content/` | Site pages and their data (frontmatter) | To add/edit a page, modify or add a Markdown file here |
| `layouts/` | Hugo Go templates that render content | Template changes affect how pages look; baseof.html touches every page |
| `assets/scss/` | Stylesheet source — compiled at build time | Edit `styles.scss` for UI changes; `custom_variables.scss` for theme tokens |
| `data/` | Structured data (sponsors, schedule) | Edit YAML files to update sponsors or the event agenda |
| `static/` | Files served as-is (favicon, etc.) | Place binary assets here if no Hugo processing is needed |
| `docs/` | Project documentation | This directory; AI context for future development |

## Entry Points

| Type | File | Description |
|------|------|-------------|
| Hugo config | `config.toml` | Top-level Hugo configuration |
| Homepage | `content/_index.md` + `layouts/index.html` | Site root `/` |
| Base template | `layouts/_default/baseof.html` | Wraps every page |
| SCSS entry | `assets/scss/main.scss` | CSS compilation starts here |
| npm | `package.json` | Bootstrap and PostCSS dependencies |
| Build/deploy | `Makefile` | `make build`, `make serve`, `make deploy` |

## Integration Points

- **Bootstrap:** Mounted from `node_modules/bootstrap/scss` into Hugo's asset filesystem via `config.toml` module mounts. Bootstrap JS is included from `node_modules/bootstrap/dist/js/bootstrap.bundle.min.js` in `partials/footer.html`.
- **Data → Templates:** `data/sponsors.yaml` → `partials/sponsors.html`; `data/agenda/2025.yaml` → `partials/components/schedule.html` (via ponencias list template)
- **Content → Layout:** Hugo maps each content file to the most specific template. `ponencias/` section uses `layouts/ponencias/` templates instead of `_default/`.
- **External links:** Registration form (external URL in hero CTA), Instagram links in speaker pages, Google Maps embeds in `guia.md`.
