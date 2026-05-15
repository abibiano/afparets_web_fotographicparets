# Development Guide — FOTOgraphic Parets

## Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Hugo | Latest (extended) | `brew install hugo` |
| Node.js + npm | LTS | `brew install node` |
| Git | Any | `brew install git` |

> **Important:** Hugo Extended is required for SCSS compilation. The standard (non-extended) Hugo binary cannot compile SCSS.

## Initial Setup

```bash
# Clone the repository
git clone <repo-url>
cd afparets_web_fotographicparets

# Install npm dependencies (Bootstrap + PostCSS)
npm install
```

That's it. Hugo finds Bootstrap SCSS and JS via the module mounts defined in `config.toml`:
```toml
[[module.mounts]]
  source = "node_modules/bootstrap/scss"
  target = "assets/scss/bootstrap"

[[module.mounts]]
  source = "node_modules/bootstrap/dist/js/bootstrap.bundle.min.js"
  target = "assets/js/bootstrap.bundle.min.js"
```

## Development Workflow

### Start the dev server
```bash
make serve
# or equivalently:
hugo server -D
```

- Serves at http://localhost:1313
- `-D` flag includes draft content
- Live reload on file changes (content, templates, SCSS)
- SCSS is compiled on-the-fly; no separate watcher needed

### Build for production
```bash
make build
# or equivalently:
hugo --gc --minify --cleanDestinationDir
```

- Output goes to `public/`
- `--gc` — removes unused cached assets
- `--minify` — minifies HTML/CSS/JS
- `--cleanDestinationDir` — removes stale files from `public/`

### Update npm dependencies
```bash
npm update
```

## Working with Content

### Adding a new page

```bash
hugo new content/my-new-page.md
```

Then edit `content/my-new-page.md`. It gets the default frontmatter from `archetypes/default.md`.

Hugo will automatically render it using `layouts/_default/single.html` unless you create a section-specific template.

### Adding a new speaker / ponencia

1. Create `content/ponencias/speaker-name.md`
2. Use this frontmatter:
   ```yaml
   ---
   title: "Speaker Full Name"
   description: "Short bio / session subtitle"
   schedule: "10:00 - 11:30h"
   participants: 20
   moderator: "Moderator Name"
   ---
   ```
3. Write the biography in Markdown below the frontmatter
4. Hugo will render it automatically using `layouts/ponencias/single.html`

### Updating the event schedule

Edit `data/agenda/2025.yaml`. The schedule component reads this file directly — no template changes needed.

```yaml
title: "Dissabte 29 de novembre de 2025"
items:
  - time: "09:30"
    title: "Activity name"
    description: "Optional description"
```

### Updating sponsors or partners

Edit `data/sponsors.yaml`. No template changes needed.

```yaml
organizers:
  - name: "Organization Name"
    logo: "img/logos/filename.png"
    url: "https://example.com"
    height: "60"

partners:
  - name: "Partner Name"
    logo: "img/logos/partner-logo.png"
    url: "https://example.com"
    height: "40"
```

Place logo files in `assets/img/logos/`.

## Working with Styles

### Modifying colors / design tokens

Edit `assets/scss/custom_variables.scss`. This overrides Bootstrap's Sass variables before Bootstrap is imported.

```scss
// Example: change primary color
$primary: #2a5c99;
$font-family-base: "My Font", sans-serif;
```

### Adding custom component styles

Edit `assets/scss/styles.scss`. Styles here are loaded after Bootstrap, so they can override Bootstrap classes.

### Style compilation

Hugo compiles SCSS automatically during `hugo server` and `hugo build`. No separate SCSS watcher is needed.

## Working with Images

Images should be placed in `assets/img/` (for Hugo-processed images) or `static/` (for unprocessed files like favicon).

### Using shortcodes in content

```markdown
{{< image-fill src="img/my-photo.jpg" width="800" height="600" alt="Alt text" >}}
{{< image-fit src="img/my-photo.jpg" width="800" height="400" alt="Alt text" >}}
{{< image-resize src="img/my-photo.jpg" width="600" alt="Alt text" >}}
```

- `image-fill` — crop to exact dimensions
- `image-fit` — scale proportionally to fit within bounds
- `image-resize` — resize by width only (preserves aspect ratio)

### Using images in templates

```go
{{ $img := resources.Get "img/my-photo.jpg" }}
{{ $processed := $img.Resize "300x" | fingerprint }}
<img src="{{ $processed.RelPermalink }}" alt="...">
```

## Hugo Template Cheatsheet

| Task | Syntax |
|------|--------|
| Access frontmatter | `{{ .Params.myField }}` |
| Access site data | `{{ $.Site.Data.sponsors }}` |
| Include a partial | `{{ partial "header.html" . }}` |
| List child pages | `{{ range .Pages }}` |
| Conditional | `{{ if .Params.description }}` |
| Current page URL | `{{ .Permalink }}` |
| Site base URL | `{{ .Site.BaseURL }}` |
| Image processing | `{{ $img := resources.Get "img/x.jpg" }}{{ $img.Resize "300x" }}` |
| Fingerprint asset | `{{ $asset | fingerprint }}` |

## Common Development Tasks

### Check for broken links
```bash
hugo --buildDrafts --buildFuture 2>&1 | grep -i error
```

### View which template is used for a page

Hugo prints template resolution in verbose mode:
```bash
hugo server -D --verbose 2>&1 | grep "template"
```

### Clean build artifacts
```bash
make clean-public
# Removes everything in public/
```

## Project Conventions

- **Language:** All content in Catalan (`ca`)
- **Frontmatter format:** YAML (between `---` markers)
- **No JavaScript custom code** — only Bootstrap Bundle JS included
- **No CMS** — all content is edited directly in files
- **No tests** — static site, no automated test suite
- **Markdown linting:** `.markdownlint.json` config (HTML allowed, no line length limit)
- **Editor:** VS Code (`.vscode/settings.json` configured; `node_modules` and `.vscode` excluded from explorer)
