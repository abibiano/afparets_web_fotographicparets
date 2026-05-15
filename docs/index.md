# Project Documentation Index — FOTOgraphic Parets

**Generated:** 2026-05-15  
**Project:** afparets_web_fotographicparets  
**Scan Level:** Deep Scan

---

## Project Overview

- **Type:** Monolith — single-part Hugo static site
- **Primary Language:** Catalan (ca) / Markdown + Go Templates + SCSS
- **Architecture:** Static Site Generation (SSG)
- **Framework:** Hugo + Bootstrap 5.3.3
- **Live URL:** https://fotographicparets.com
- **Entry Point:** `config.toml` + `layouts/_default/baseof.html`
- **Architecture Pattern:** Compile-time SSG — no runtime server or database

---

## Quick Reference

| Area | Key File | Description |
|------|----------|-------------|
| Site config | `config.toml` | baseURL, language, params, Bootstrap module mounts |
| Homepage | `content/_index.md` + `layouts/index.html` | Hero, features, highlights |
| All pages base | `layouts/_default/baseof.html` | Document skeleton wrapping all pages |
| Styles | `assets/scss/main.scss` | SCSS entry point |
| Theme tokens | `assets/scss/custom_variables.scss` | Colors, fonts |
| Event schedule | `data/agenda/2025.yaml` | 2025 program (edit to update schedule) |
| Sponsors | `data/sponsors.yaml` | Organizers + partners (edit to update sponsors) |
| Build & deploy | `Makefile` | `make serve`, `make build`, `make deploy` |

---

## Generated Documentation

- [Project Overview](./project-overview.md) — Purpose, content pages, event details, tech stack summary
- [Architecture](./architecture.md) — Hugo SSG architecture, template hierarchy, asset pipeline, data layer
- [Source Tree Analysis](./source-tree-analysis.md) — Annotated directory tree with all entry points and integration points
- [Component Inventory](./component-inventory.md) — All Hugo templates, partials, shortcodes, and SCSS components
- [Development Guide](./development-guide.md) — Setup, local dev workflow, content editing, Hugo template cheatsheet
- [Deployment Guide](./deployment-guide.md) — OVH VPS deployment, SSH config, Makefile variables, rollback

---

## Existing Documentation

- [README.md](../README.md) — Quick developer setup guide (install, serve, deploy)

---

## Getting Started

### Local development

```bash
# Prerequisites: Hugo Extended, Node.js/npm
npm install
make serve        # or: hugo server -D
# → http://localhost:1313
```

### Common tasks

| Task | Command / File |
|------|---------------|
| Edit homepage content | `content/_index.md` |
| Edit event schedule | `data/agenda/2025.yaml` |
| Edit sponsors | `data/sponsors.yaml` |
| Add a new speaker | `hugo new content/ponencias/speaker-name.md` |
| Change site colors | `assets/scss/custom_variables.scss` |
| Build for production | `make build` |
| Deploy to server | `make deploy` |

### For AI-assisted development

When working on this project with an AI assistant:

- Point to `docs/architecture.md` for understanding the Hugo template system and rendering pipeline
- Point to `docs/component-inventory.md` for template/partial/shortcode reference
- Point to `docs/development-guide.md` for content editing conventions and Hugo syntax
- The project is a **static site** — there is no API, no database, and no backend code

### Related project

The main AFParets association website lives at `/Users/abibiano/Projects/Web/afparets/` (separate repo, Hugo + Blowfish theme). This project is exclusively for the annual FOTOgraphic Parets photography event.
