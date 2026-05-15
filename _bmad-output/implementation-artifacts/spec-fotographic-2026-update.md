---
title: 'FOTOgraphic 2026 site update'
type: 'feature'
created: '2026-05-15'
status: 'done'
baseline_commit: '0fd392c219a964e01c085a4e713ce29f830f9e2f'
context:
  - '_bmad-output/project-context.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** The site still shows the 2025 Danny Vela / skateboard edition — wrong dates, instructor, theme, sponsors, and contest rules. Zero 2025 references may remain after the single-release deploy.

**Approach:** Replace all edition-specific content in one pass: homepage hero with a 6-photo portfolio carousel (replacing the generic card), two new instructor pages, new 2026 schedule YAML, updated contest page (two-category format, external submission), updated sponsors (2 entries only), and updated expositions page with 2025 skate contest results.

## Boundaries & Constraints

**Always:**
- All new images through `resources.Get` → resize → `fingerprint` — never `static/` for instructors or contest photos
- All text content in Catalan; no hardcoded edition-specific strings in template files
- External links: `target="_blank" rel="noopener"`
- Hero carousel: `.Resize "900x"` per image; wrap in `{{ with resources.Get }}` guard

**Ask First:**
- If any `resources.Get` for an instructor image returns nil after copy (path mismatch)

**Never:**
- Touch `public/`, `resources/`, or `node_modules/`
- Add custom JS; add inline `style=""` attributes
- Create new Hugo sections or layout templates beyond the `layouts/index.html` edits described

</frozen-after-approval>

## Code Map

- `config.toml` — site title + description with 2025 references
- `content/_index.md` — homepage hero frontmatter; add `hero.carousel` field
- `layouts/index.html` — hardcoded logo path, hardcoded Danny Vela paragraph, right-column hero card
- `assets/img/instructors/` — new dir; destination for 6 images from `tmp/2026/`
- `assets/img/concurso-resultado-2025/` — new dir; destination for 9 contest photos from `tmp/CONCURS-2025/FOTOS PARTICIPANTS/`
- `content/ponencias/danny-vela.md` — delete
- `content/ponencias/alex-bibiano.md` — create
- `content/ponencias/toni-barbany.md` — create
- `content/ponencias/_index.md` — agenda key `"2026"` + 2026 intro text + 3-sets section
- `data/agenda/2026.yaml` — create: full day schedule from PDF
- `data/sponsors.yaml` — strip to 2 entries (AFParets + Ajuntament)
- `content/concurso.md` — full replacement: 2-category 2026 contest
- `content/exposiciones-fotographic.md` — update to show VII Concurs 2025 results

## Tasks & Acceptance

**Execution:**

- [x] Copy `tmp/2026/bibiano01.jpg`, `bibiano02.jpg`, `bibiano03.jpg`, `barbany01.jpeg`, `barbany02.jpeg`, `barbany03.jpeg` → `assets/img/instructors/` — required before homepage and instructor pages

- [x] Copy 9 photos from `tmp/CONCURS-2025/FOTOS PARTICIPANTS/` (`49.- ressorgint de la penombra.jpg`, `29.- Rastre de fum.jpg`, `21.- Contrallum.jpg`, `47.- desafio.jpg`, `31.- SKATE_PARETS_1.jpg`, `17.- Foscor B.jpg`, `14.- Equilibrio en Suspenso.jpg`, `13.- Chispa de Control.jpg`, `7.- Força i equilibri.jpg`) → `assets/img/concurso-resultado-2025/`

- [x] `config.toml` — `title = "FOTOgraphic Parets 2026"`, `description = "FOTOgraphic Parets 2026, 13a edició de l'esdeveniment fotogràfic amb bodegons, ponències i tallers."`

- [x] `layouts/index.html` — three changes: (1) wrap the hardcoded logo `resources.Get` block in `{{ with .Params.hero.logo }}{{ with resources.Get . }}…{{ end }}{{ end }}`; (2) delete the `<p class="hero-collab…">Amb la col·laboració de…Danny Vela…</p>` line; (3) replace the entire `col-12 col-lg-5 col-xl-5` hero-card div with a Bootstrap `carousel slide` iterating `$hero.carousel` — each slide renders `resources.Get .src | .Resize "900x" | fingerprint`, image has `class="d-block w-100 rounded-4"`, carousel wrapper has `overflow-hidden rounded-4 shadow-lg`, `data-bs-ride="carousel" data-bs-interval="3000"`, prev/next controls with Catalan `visually-hidden` labels

- [x] `content/_index.md` — update: `hero.badge` → `"13a edició · Vallès Oriental"`, `hero.title` → `"FOTOgraphic Parets 2026"`, `hero.subtitle` → `"Festival de fotografia de bodegons"`, `hero.meta[0].value` → `"6 de juny de 2026"`, `hero.actions[0].label` → `"Consulta el programa 2026"`. Add `hero.carousel` list: 6 entries with `src` and `alt` for `img/instructors/bibiano01.jpg` through `bibiano03.jpg` (alt: "Alex Bibiano · bodegó clau baixa") and `img/instructors/barbany01.jpeg` through `barbany03.jpeg` (alt: "Toni Barbany · tècnica de transparents"). Leave `hero.logo` absent.

- [x] `content/ponencias/danny-vela.md` — delete

- [x] `content/ponencias/alex-bibiano.md` — create. `title: "Alex Bibiano"`, `description: "Bodegó en clau baixa: objectes, llum LED lateral 45° i gestió d'ombres."`, `draft: false`. Body: short bio (AFParets, guanyador VI Concurs FOTOgraphic 2024 "La Dansa del Moviment"), technique paragraph (clau baixa, LED lateral 45°, focus stacking, tethering Capture One), three `image-resize` shortcodes for `img/instructors/bibiano0{1,2,3}.jpg` with `size="1200x"` and `class="rounded-4 shadow-sm mb-4 w-100"`

- [x] `content/ponencias/toni-barbany.md` — create. `title: "Toni Barbany"`, `description: "Bodegó amb transparents: retroil·luminació amb cartolina per ressaltar perfils i siluetes."`, `draft: false`. Body: short bio (fotògraf de llarga trajectòria, finalista VI Concurs 2024 amb "Diabol" i "Anelles", finalista VII Concurs 2025 amb "Skate Parets 1"), technique paragraph (transparents, retroil·luminació, cartolina difusora, ampolles i copes), three `image-resize` shortcodes for `img/instructors/barbany0{1,2,3}.jpeg` same params

- [x] `content/ponencias/_index.md` — set `agenda: "2026"`. Replace body: 2026 intro paragraph (June 6, still life, dual instructors [Alex Bibiano](/ponencias/alex-bibiano/) + [Toni Barbany](/ponencias/toni-barbany/)). Add `### Els 3 sets de shooting` section: **Bodegó barroc** — ceràmica, fruita, flors, drapeig, composició clàssica; **Clau baixa** — metalls patinats, llautó, coure, llum lateral 45°; **Transparents (tècnica Barbany)** — ampolles, copes de vi, retroil·luminació amb cartolina

- [x] `data/agenda/2026.yaml` — create. `title: "Dissabte 6 de juny de 2026"`. `items[]` with `time` and `body` (and optional `title`) for 10 slots derived from PDF agenda table: 09:30–10:00, 10:00–10:30, 10:30–12:00, 12:00–12:20, 12:20–13:00 *(split: Grup A shooting / Grup B demo — use `**Grup A**` and `**Grup B**` bold labels in body)*, 13:00–15:30, 15:30–16:50 *(split)*, 16:50–17:00, 17:00–19:00 *(split, note demo repeats)*, 19:00 clausura. See PDF pages 1–2 for exact wording of each slot.

- [x] `data/sponsors.yaml` — keep only: `organizers`: AFParets entry; `partners`: Ajuntament de Parets entry. Remove Danny Vela and all commercial sponsors.

- [x] `content/concurso.md` — full replacement. `title: "Concurs Fotogràfic FOTOgraphic Parets 2026"`, `LinkTitle: "Concurs"`, `menu: "main"`, `weight: 40`. Body: two categories — **Bodegó fine art** (fotos del FOTOgraphic 2026, sense marques comercials, intenció artística) and **Lliure** (qualsevol foto, qualsevol moment, obert a participants del FOTOgraphic); prize table (Bodegó fine art 1r €125 / 2n €100 / 3r €75 dinar; Lliure 1r €100 / 2n €75 dinar, 3r —); calendar (6 juny captura, fins 30 juny presentació, juliol veredicte); prominent link/button to `https://concurs.afparets.com` `target="_blank" rel="noopener"`. No FCF number, no email submission.

- [x] `content/exposiciones-fotographic.md` — update title to `"Exposició FOTOGraphic 2026 – VII Concurs «4t Memorial CHUSSA MULÀ»"`. Body: intro (29 novembre 2025, Danny Vela, skate); winners (1r "Ressorgint de la Penombra" — Ignasi Pallisa; 2n "Rastre de Fum" — Juanjose Carrasco AFParets; 3r "Contrallum" — Montse Dolz); finalists (Desafio — Aurora Padilla; Skate Parets 1 — Toni Barbany; Foscor B — Pere Ninou; Equilibrio en Suspenso / Chispa de Control — Alejandro Bibiano; Força i equilibri — Ramon Maria Sauri Navarro AFParets); jury (Jose González de Sande FCF 2413/36, Francesc de la Torre Escobar, Danny Vela); Bootstrap carousel with 3 winner slides using `image-fit` shortcode: `img/concurso-resultado-2025/49.- ressorgint de la penombra.jpg`, `img/concurso-resultado-2025/29.- Rastre de fum.jpg`, `img/concurso-resultado-2025/21.- Contrallum.jpg`, `size="1024x1024"`, each with caption. Prev/next controls.

**Acceptance Criteria:**

- Given a clean working tree, when `hugo --gc --minify --cleanDestinationDir` runs from project root, then it exits 0 with no errors or warnings
- Given the built `public/` directory, when searching for "danny-vela", "Danny Vela", "12a edició", "novembre de 2025", "skateboard", "skate" outside of `exposicio` and `concurso-resultado-2025` paths, then zero matches
- Given the homepage at 375px viewport, when rendered, then hero carousel is visible below the CTA text and at least one instructor image loads
- Given the ponencies page, when loaded, then the schedule renders 10 agenda items from `data/agenda/2026.yaml` and the 3-sets section appears above the schedule table
- Given the concurso page, when clicking the concurs.afparets.com link, then it opens in a new tab
- Given the exposicions page, when the carousel auto-plays, then all 3 winner images load (fingerprinted URLs resolve, no broken images)

## Design Notes

**Hero carousel:** The right-column `col-12 col-lg-5 col-xl-5` card is replaced by a Bootstrap carousel. Keep `mt-5 mt-lg-0` on the column for mobile stacking. Use `data-bs-interval="3000"` for auto-advance. The generic "Què és FOTOgraphic?" card content is not displayed elsewhere — it was redundant with the guia page; removing it sharpens the hero's artistic focus.

**Schedule YAML for two-group slots:** The template renders one `body` per item via `markdownify`. For simultaneous A/B blocks use a YAML literal block scalar (`body: |`) with `**Grup A**` and `**Grup B**` labels on separate lines separated by `\` (Hugo markdown line break). No template change needed.

## Verification

**Commands:**
- `hugo --gc --minify --cleanDestinationDir` — expected: exit 0, no warnings
- `grep -r "danny-vela\|Danny Vela\|12a edici\|novembre de 2025\|skate" public/ | grep -v "concurso-resultado-2025\|exposicio"` — expected: no output
- `hugo server` then open `http://localhost:1313` — manually verify hero carousel animates and instructor images load

## Suggested Review Order

**Homepage template (entry point)**

- Logo made optional — outer `with` on `hero.logo` param; absent = no logo rendered
  [`index.html:8`](../../layouts/index.html#L8)

- Hero action links: conditional `target`/`rel` for external URLs via `hasPrefix`
  [`index.html:36`](../../layouts/index.html#L36)

- Carousel guard + `$first` pattern ensures active class on first loaded image
  [`index.html:52`](../../layouts/index.html#L52)

- Carousel frontmatter: 6 entries driving the right-column hero visual
  [`_index.md:23`](../../content/_index.md#L23)

**Instructor pages**

- Alex Bibiano page: bio, technique, 3 portfolio images via `image-resize` shortcode
  [`alex-bibiano.md:1`](../../content/ponencias/alex-bibiano.md#L1)

- Toni Barbany page: bio, technique, 3 portfolio images
  [`toni-barbany.md:1`](../../content/ponencias/toni-barbany.md#L1)

- Program page: `agenda: "2026"` key + 3-sets section above schedule
  [`_index.md:6`](../../content/ponencias/_index.md#L6)

**Schedule data**

- Full 2026 timetable; simultaneous A/B blocks encoded as `**Grup A**`/`**Grup B**` markdown lines
  [`2026.yaml:24`](../../data/agenda/2026.yaml#L24)

**Contest page**

- Two-category format; external button + inline `<a>` both with `target`/`rel`
  [`concurso.md:48`](../../content/concurso.md#L48)

**History / exhibition**

- 2025 skate contest results; carousel pointing to `concurso-resultado-2025/` assets
  [`exposiciones-fotographic.md:1`](../../content/exposiciones-fotographic.md#L1)

**Supporting config and styles**

- Carousel image height constraint: `object-fit: cover` prevents layout jump between slides
  [`styles.scss:3`](../../assets/scss/styles.scss#L3)

- Sponsors stripped to 2 entries; `config.toml` title/description updated
  [`sponsors.yaml:1`](../../data/sponsors.yaml#L1)
