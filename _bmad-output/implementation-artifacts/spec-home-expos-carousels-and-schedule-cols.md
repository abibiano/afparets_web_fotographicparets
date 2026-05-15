---
title: 'Home/Exposicions carousels + Programa 2-columnes (Grup A/B)'
type: 'feature'
created: '2026-05-15'
status: 'done'
baseline_commit: '68cbec1c49b6570cfc08fd187a945b07fb46ec07'
context:
  - '{project-root}/_bmad-output/project-context.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** Tres mancances UX a la web del FOTOgraphic 2026: (1) el carousel de la home retalla algunes fotos amb `object-fit: cover` i no mostra l'autor; (2) el carousel d'`exposiciones-fotographic` canvia d'alçada entre slides perquè cada foto té una ràtio diferent, fent saltar la pàgina; (3) al programa, els tres blocs simultanis (12:20, 15:30, 17:00) no diferencien visualment què fa el Grup A i què el Grup B.

**Approach:** (A) Afegir `author` per slide a `_index.md`, renderitzar-lo a sota la imatge dins de cada slide i canviar a `object-fit: contain` amb fons negre per fer letterboxing. (B) Aplicar el mateix patró de letterboxing al carousel d'exposicions amb alçada fixa i ampliar-lo perquè inclogui també les 6 fotos finalistes (a més dels 3 guanyadors) + corregir el nom "Juanjose Carrasco" → "Juan Jose Carrasco". (C) Estendre l'esquema YAML d'agenda amb un camp opcional `groups: { a, b }` i actualitzar `schedule.html` perquè, quan hi sigui, renderitzi 2 columnes (Grup A | Grup B) en lloc del `body` únic.

## Boundaries & Constraints

**Always:**
- Tot el text visible nou en català.
- Imatges sempre via pipeline Hugo (`resources.Get` + `.Resize` o `.Fit`) amb `fingerprint`.
- Bootstrap 5 utility classes per layout; cap `style=""` inline; cap `!important`.
- SCSS d'override de Bootstrap només a `custom_variables.scss`; estils de component a `styles.scss`.
- Grid mobile-first: `col-12 col-md-X col-lg-Y` (les 2 columnes A/B en desktop col·lapsen a 1 columna en mòbil).
- Cap dependència JS nova: només Bootstrap bundle.

**Ask First:**
- Alçada concreta del carousel d'exposicions (proposat 500 px desktop / 360 px mòbil).
- Si convé mantenir compatibilitat amb `data/agenda/2025.yaml` (proposat: sí, ja que el camp `groups` és opcional i el comportament antic es preserva).

**Never:**
- No tocar `static/`, ni `public/`, ni `resources/`.
- No canviar el shortcode `image-fit` existent (es fa servir en altres llocs).
- No introduir cap JS custom ni reescriure el carousel de Bootstrap.
- No canviar les pàgines `/concurso`, `/ponencias/*` ni el header/footer.

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| Home slide amb `author` | `carousel[i].author = "Alex Bibiano"` | Imatge en contenidor d'alçada fixa amb bandes negres si cal + caption "Alex Bibiano" sota | N/A |
| Home slide sense `author` | camp absent | Imatge renderitzada igual; cap caption | Cap error; `with` salta el bloc |
| Foto home amb ràtio extrem (portrait) | Imatge alta i estreta | Letterboxing horitzontal amb fons negre; sense salt d'alçada al canviar slide | N/A |
| Exposicions: canvi de slide | 9 fotos (3 guanyadors + 6 finalistes) amb ràtios diferents | Alçada del carousel constant; bandes negres on calgui; sense salt de la pàgina | N/A |
| Agenda item amb `groups: {a, b}` | `items[i].groups.a.body` i `items[i].groups.b.body` definits | Renderitza 2 columnes (`col-12 col-md-6`) amb labels "Grup A" i "Grup B" en lloc del `body` únic | N/A |
| Agenda item sense `groups` | només `body` (comportament 2025) | Renderitza el `body` a tota l'amplada (sense regressió) | N/A |
| Agenda item amb `groups` + `body` simultanis | tots dos camps presents | Es prioritza `groups` (2 columnes); `body` s'ignora | Cap; no es trenca |

</frozen-after-approval>

## Code Map

- `content/_index.md` -- Frontmatter del carousel de la home; afegir camp `author` per entrada.
- `layouts/index.html` -- Plantilla home (líns. 52–77 del carousel); afegir caption `<figcaption>` sota cada `<img>`.
- `assets/scss/styles.scss` -- Regla `.hero-carousel-img` (líns. 2–10): canviar a `contain` + fons negre; afegir estil pel caption i pel carousel d'exposicions.
- `content/exposiciones-fotographic.md` -- HTML del carousel (líns. 44–67); afegir classe específica (`expo-carousel`) al wrapper, afegir 6 nous `<div class="carousel-item">` per als finalistes, i corregir "Juanjose Carrasco" → "Juan Jose Carrasco" (tant a la llista de guanyadors com al caption del carousel).
- `data/agenda/2026.yaml` -- Afegir camp `groups: { a: {body}, b: {body} }` als 3 ítems de "bloc simultani" (12:20, 15:30, 17:00); buidar el `body` corresponent.
- `layouts/partials/components/schedule.html` -- Detectar `.groups`; si existeix, renderitzar 2 columnes Bootstrap (`row > col-md-6 × 2`) amb labels "Grup A"/"Grup B" i `markdownify`. Mantenir el render `body` actual per a la resta i per a `2025.yaml`.

## Tasks & Acceptance

**Execution:**
- [x] `content/_index.md` -- Afegir camp `author` a cada entrada de `hero.carousel` (3× Alex Bibiano, 3× Toni Barbany).
- [x] `layouts/index.html` -- Envoltar cada slide amb `<figure>`; afegir `<figcaption class="hero-carousel-caption">{{ .author }}</figcaption>` sota la `<img>` quan `.author` existeixi.
- [x] `assets/scss/styles.scss` -- Canviar `.hero-carousel-img` a `object-fit: contain` + `background-color: #000`; afegir `.hero-carousel-caption` (text centrat, fons fosc semitransparent o per sota de la imatge); afegir `.expo-carousel .carousel-item img` amb alçada fixa (≈500 px desktop, 360 px mòbil) + `object-fit: contain` + fons negre.
- [x] `content/exposiciones-fotographic.md` -- (1) Afegir classe `expo-carousel` al `<div>` del carousel i renombrar `id` a `expoCarousel` (actualitzar `data-bs-target` als botons prev/next). (2) Afegir 6 nous `<div class="carousel-item">` (no `active`) per als finalistes, en l'ordre de la llista de finalistes existent: Desafio (Aurora Padilla, `47.- desafio.jpg`), Skate Parets 1 (Toni Barbany, `31.- SKATE_PARETS_1.jpg`), Foscor B (Pere Ninou, `17.- Foscor B.jpg`), Equilibrio en Suspenso (Alejandro Bibiano, `14.- Equilibrio en Suspenso.jpg`), Chispa de Control (Alejandro Bibiano, `13.- Chispa de Control.jpg`), Força i equilibri (Ramon Maria Sauri Navarro, `7.- Força i equilibri.jpg`). Cada un amb el mateix patró: `image-fit` size `1024x1024` + `carousel-caption d-none d-md-block` amb `<h5>títol</h5><p>autor</p>`. (3) Reemplaçar "Juanjose Carrasco" per "Juan Jose Carrasco" a la línia 18 (guanyadors) i al caption del carousel.
- [x] `data/agenda/2026.yaml` -- Reestructurar els 3 ítems simultanis amb `groups: { a: { body: "..." }, b: { body: "..." } }`; eliminar el `body` antic d'aquests ítems.
- [x] `layouts/partials/components/schedule.html` -- Dins del bucle d'ítems: `{{ with .groups }}` → renderitzar `<div class="row g-3"><div class="col-12 col-md-6">Grup A …</div><div class="col-12 col-md-6">Grup B …</div></div>` amb `markdownify` de cada `body`; `{{ else }}` mantenir el bloc `body` actual. Aplicar la mateixa estructura als dos blocs (amb i sense `days`).

**Acceptance Criteria:**
- Given un usuari obre la home, when el carousel canvia de slide, then l'alçada del carousel no canvia i sota cada foto es llegeix el nom de l'autor.
- Given una foto de la home té una ràtio diferent (vertical, panoràmica), when es mostra al carousel, then apareix amb bandes negres (letterbox) sense retallar.
- Given un usuari obre `/exposiciones-fotographic` i navega pel carousel, when recorre les 9 fotos (3 guanyadores + 6 finalistes), then totes apareixen en l'ordre esperat, l'alçada del carousel es manté constant i no hi ha cap salt vertical a la pàgina; el caption mostra "Juan Jose Carrasco" (no "Juanjose").
- Given un usuari obre `/ponencias` (o on es renderitzi el `schedule` de 2026), when veu els 3 ítems simultanis (12:20, 15:30, 17:00), then cada un es presenta amb 2 columnes (Grup A | Grup B) en desktop i apilades en mòbil; la resta d'ítems es manté en una sola columna.
- Given `data/agenda/2025.yaml` no té camps `groups`, when es renderitza, then el resultat és idèntic al d'abans del canvi.

## Design Notes

**Estructura YAML proposada per `groups`** (exemple del bloc 12:20):

```yaml
- time: "12:20–13:00"
  title: "Primer bloc simultani"
  groups:
    a:
      body: |
        **Shooting A1** — 1 set × 40 min
    b:
      body: |
        **Demo al set central** — Alex Bibiano + Toni Barbany, 40 min
```

El label "Grup A" / "Grup B" el posa la plantilla, no la dada — així evitem repetició i variants tipogràfiques.

**Letterboxing CSS pattern** (compartit entre home i exposicions):

```scss
.hero-carousel-img { height: 420px; object-fit: contain; background-color: #000; @include media-breakpoint-up(lg) { height: 480px; } }
.expo-carousel .carousel-item img { height: 360px; width: 100%; object-fit: contain; background-color: #000; @include media-breakpoint-up(md) { height: 500px; } }
```

## Verification

**Commands:**
- `hugo --gc --minify --cleanDestinationDir` -- expected: build sense errors ni warnings de templates.
- `hugo server` -- expected: dev server arrenca sense errors; visitar `/`, `/exposiciones-fotographic/`, i la pàgina del programa per inspecció visual.

**Manual checks:**
- Home: navegar pel carousel; verificar que (1) l'alçada no salta, (2) les fotos verticals mostren bandes negres, (3) el nom de l'autor apareix sota cada foto.
- Exposicions: navegar pel carousel; verificar que (1) l'alçada és constant entre slides, (2) la pàgina no fa "jump" en canviar de foto.
- Programa: verificar que els tres blocs simultanis es veuen com 2 columnes (A | B) en desktop ≥768 px i com 2 files apilades en mòbil; que la resta d'ítems segueixen iguals.
- Comprovar `/ponencias/*` (single pages) per assegurar-se que el carousel de ponències NO s'ha vist afectat (regressió cero).

## Suggested Review Order

**Letterbox pattern (entry point)**

- Patró compartit: alçada fixa + `object-fit: contain` + fons negre per home i exposicions.
  [`styles.scss:3`](../../assets/scss/styles.scss#L3)

- Caption del slide com a overlay absolut sobre la imatge (no com a sibling que infla alçada).
  [`styles.scss:13`](../../assets/scss/styles.scss#L13)

- Regla equivalent per al carousel d'exposicions amb alçades 360/500 px.
  [`styles.scss:27`](../../assets/scss/styles.scss#L27)

**Home carousel (markup + dades)**

- `<figure position-relative>` envolta la imatge i ancorà l'overlay del caption.
  [`index.html:61`](../../layouts/index.html#L61)

- Camp `author` afegit per slide; consumit per `with $img.author`.
  [`_index.md:23`](../../content/_index.md#L23)

**Exposicions carousel**

- Wrapper renombrat a `expoCarousel` + classe `expo-carousel` per scoping CSS; 6 finalistes afegits; "Juan Jose Carrasco" corregit.
  [`exposiciones-fotographic.md:44`](../../content/exposiciones-fotographic.md#L44)

**Programa 2 columnes**

- Esquema YAML estès amb `groups: { a, b }` als 3 blocs simultanis; `body` final es manté per a la nota compartida del tercer bloc.
  [`2026.yaml:21`](../../data/agenda/2026.yaml#L21)

- Plantilla: captura `$groups` per accedir-hi fora del `with`; renderitza columnes + body conjuntament; manté compatibilitat per a 2025.yaml.
  [`schedule.html:25`](../../layouts/partials/components/schedule.html#L25)
