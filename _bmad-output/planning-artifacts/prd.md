---
stepsCompleted: ['step-01-init', 'step-02-discovery', 'step-02b-vision', 'step-02c-executive-summary', 'step-03-success', 'step-04-journeys', 'step-05-domain', 'step-06-innovation', 'step-07-project-type', 'step-08-scoping', 'step-09-functional', 'step-10-nonfunctional', 'step-11-polish', 'step-12-complete']
status: 'complete'
completedAt: '2026-05-15'
releaseMode: 'single-release'
inputDocuments:
  - '_bmad-output/project-context.md'
  - 'docs/project-overview.md'
  - 'tmp/2026/fotographic2026_bodegons_v5.pdf'
workflowType: 'prd'
classification:
  projectType: 'web_app'
  domain: 'general'
  complexity: 'low'
  projectContext: 'brownfield'
---

# Product Requirements Document - FOTOgraphic Parets 2026

**Author:** Alex Bibiano
**Date:** 2026-05-15

## Executive Summary

FOTOgraphic Parets 2026 is the official website for the 13th edition of the annual photography festival organized by the Associació Fotogràfica Parets (AFParets). The site is the primary communication channel — informing interested Catalan photographers and converting them into registered attendees.

The 2026 edition centers on **still life photography (fotografia de bodegons)**, taking place **Saturday, June 6, 2026** at **Ca n'Oms, Parets del Vallès**. Capacity: 48 participants. The format combines theoretical lectures, a central demonstration, and hands-on shooting sessions across 3 curated sets. A photography contest with two categories runs alongside, managed externally at [concurs.afparets.com](https://concurs.afparets.com).

The site has two jobs: drive registrations before the event, and communicate the program so attendees arrive prepared.

### What Makes This Special

The 2026 edition introduces a dual-instructor format — **Alex Bibiano** (low-key still life, 45° lateral LED lighting) and **Toni Barbany** (transparent backlit technique with cardboard diffusion) — two complementary and technically precise approaches under one roof. The "set passport" system assigns each participant to 3 of the 6 shooting tables with fixed time slots, eliminating dead time throughout the day.

The website tone shifts accordingly: more refined and artistic than previous editions, reflecting the craft-focused nature of still life photography.

### Project Classification

| Attribute | Value |
|---|---|
| Project Type | Web App — static site (Hugo + Bootstrap 5) |
| Domain | Cultural / Arts Events |
| Complexity | Low |
| Project Context | Brownfield — 13th edition update of existing site |
| Organizer | Associació Fotogràfica Parets (AFParets) |
| Collaborator | Ajuntament de Parets del Vallès |
| Sponsors | None (2026 edition) |

## Success Criteria

### User Success

- A prospective attendee can find date, venue, price, format, and registration link within 30 seconds of landing
- Registered attendees arrive on June 6 knowing the full day schedule, their group (A/B), and what to bring
- Contest participants immediately understand the two categories, prizes, and find the link to concurs.afparets.com

### Business Success

- Event sells out: 48 registrations before June 6, 2026
- Site live at least 4 weeks before the event (by May 9, 2026)
- Zero support questions about logistics the site should answer

### Technical Success

- Clean Hugo build with no errors; all asset fingerprinting intact
- Mobile-responsive across all pages
- Zero leftover 2025 references (Danny Vela, skateboard theme, old sponsors, old dates)
- History sections updated on both `fotographicparets.com` and the AFParets main site (`/Users/abibiano/Projects/Web/afparets`)

### Measurable Outcomes

- 48/48 registrations filled before event date
- Site deployed ≥ 4 weeks before June 6, 2026
- `hugo --gc --minify --cleanDestinationDir` exits 0 with no warnings

## User Journeys

### Journey 1 — Maria: Prospective Attendee (Success Path)

Maria is a photography enthusiast from Granollers who shoots portraits and wants to branch out into still life. She sees a post on AFParets' Instagram about FOTOgraphic 2026 and clicks the link.

She lands on the homepage. The hero immediately tells her: *still life photography, June 6, Ca n'Oms*. She scrolls — sees the two instructors with portfolio images (a backlit wine glass, an artichoke suspended mid-air). These are people who clearly know their craft. She clicks "Programa" — finds a full day schedule broken into morning lectures, demo, and shooting sessions. She sees there are only 48 spots. She clicks register.

**Aha moment:** "I know exactly what I'm doing all day, I know who's teaching me, and I know there's limited space — I should sign up now."

### Journey 2 — Joan: Registered Attendee (Pre-event Return)

Joan registered three weeks ago. The night before June 6, he pulls up the site on his phone to double-check logistics: what time to arrive, where Ca n'Oms is, what the day looks like.

He finds the schedule immediately on the program page. He checks the visitor guide for the address and parking. He sees the note about the €10 entry fee paid in cash at accreditation. He puts the address in Google Maps and goes to bed.

**Aha moment:** "Everything I need for tomorrow is right here — no emails to dig through."

### Journey 3 — Marta: Contest Participant

Marta attended FOTOgraphic 2026 and came away with a set of shots she's proud of. Two weeks later she remembers there was a contest. She visits the site to find how to submit.

She finds the contest section — two categories explained clearly: *Bodegó fine art* (photos taken during FOTOgraphic 2026) and *Lliure* (any photo, any time). Prizes listed. Submission deadline: June 30. She clicks the link to concurs.afparets.com and submits.

**Aha moment:** "My shots from the event qualify for the fine art category — I know exactly where to submit."

### Journey 4 — Alex: Site Admin (Annual Update)

Alex updates the site from 2025 to 2026 each spring. He has the event PDF, 6 new images, and a list of changes: new date, new instructors, new theme, simplified sponsors, history entry.

He updates `data/agenda/2026.yaml`, the homepage frontmatter, instructor content pages, sponsor data, and adds the 2025 history entry. He copies the portfolio images to `assets/img/`. He runs `hugo server` to verify locally, then `make deploy`.

**Aha moment:** "Hugo builds clean, no leftover 2025 references, deployed in one command."

### Journey Requirements Summary

| Journey | Capabilities Revealed |
|---|---|
| Prospective attendee | Hero with theme/date/CTA, instructor bios + portfolio images, schedule page, registration link |
| Registered attendee | Mobile-responsive schedule, visitor guide with location/transport, accreditation logistics |
| Contest participant | Contest section with categories, prizes, deadline, external link to concurs.afparets.com |
| Site admin | YAML-driven agenda, frontmatter-driven content, image asset pipeline, deploy via `make deploy` |

## Product Scope

### Delivery Strategy

**Approach:** Single-release content update — all 2025 content replaced with 2026 in one deployment.
**Resource:** 1 developer (Alex Bibiano). Hugo + Bootstrap 5. ~1–2 days of focused work.
**Target Deploy:** By May 9, 2026 (4 weeks before the June 6 event).

### Must-Have Capabilities

- Homepage: updated hero (theme, date, CTA), updated highlights, refined artistic tone
- Instructor pages: new pages for Alex Bibiano and Toni Barbany under `content/ponencies/`, with portfolio images from `tmp/2026/`
- Schedule: new `data/agenda/2026.yaml` with full day timetable
- Contest section: 2 categories (Bodegó fine art + Lliure), prizes, deadline (June 30), link to concurs.afparets.com
- Sponsors: AFParets (organizer) + Ajuntament de Parets (collaborator) only; all 2025 sponsors removed
- History section: new 2025 entry drafted from existing site content
- AFParets main site (`/Users/abibiano/Projects/Web/afparets`): matching 2025 history entry added
- Clean build: `hugo --gc --minify --cleanDestinationDir` exits 0, zero 2025 references remaining

### Nice-to-Have (this release)

- "3 sets" visual section: set descriptions, objects, lighting type, and technique — deferrable if time is tight

### Post-Launch (Growth)

- Photo gallery from the 2026 event (after June 6)
- Winner announcement page linked from the contest section (after July 2026 jury verdict)

### Vision (Future Editions)

- Consolidated multi-edition archive page spanning all FOTOgraphic Parets editions

### Risk Mitigation

**Technical:** Hugo image processing for new instructor photos — low risk, established pipeline. Mitigation: test with `hugo server` before deploy.
**Resource:** Single developer. If time is tight, the "3 sets" section is the only deferrable item.

## Technical Requirements

### Architecture

Static multi-page application (MPA) built with Hugo SSG. All pages rendered at build time to static HTML/CSS. No client-side routing, no runtime server, no database. Served from OVH VPS via Nginx.

- Hugo + Bootstrap 5.3.3 + SCSS/PostCSS pipeline — existing stack, no changes
- Asset fingerprinting mandatory on all CSS and images for cache busting
- All new images processed through Hugo's `resources.Get` pipeline (not `static/`)
- Content in Markdown + YAML frontmatter; structured data in `data/` YAML files
- Deploy via `make deploy` (rsync over SSH) — no CI/CD pipeline
- Annual update pattern: all edition-specific content in `data/agenda/YEAR.yaml` and page frontmatter — zero hardcoded strings in templates
- New instructor pages follow existing pattern: `content/ponencies/SLUG.md`

### Browser Support

| Browser | Support Level |
|---|---|
| Chrome / Edge (latest 2) | Full |
| Firefox (latest 2) | Full |
| Safari (latest 2) | Full |
| Mobile Safari / Chrome Android | Full (mobile-first) |
| IE / legacy browsers | Not supported |

### Responsive Design

- Mobile-first Bootstrap grid: `col-12 col-md-X col-lg-Y` pattern throughout
- Schedule table: horizontal scroll on mobile if needed

### SEO

- `description` frontmatter required on every page — no automatic fallback
- OG image defaults to `img/logos/logo-fotographic.png`; override per page with `og_image` frontmatter
- All URLs via `.Permalink` or `absURL` — no hardcoded URLs
- Language: `ca` (Catalan), `languageCode = "ca"` in config

## Functional Requirements

### Event Presentation

- **FR1:** Visitors can view the event's core identity (name, edition number, theme, date, time, venue) on the homepage without scrolling
- **FR2:** Visitors can read a description of the event format and what to expect during the day
- **FR3:** Visitors can navigate to registration directly from the homepage hero section
- **FR4:** Visitors can see the event capacity (48 participants) and understand it is limited

### Program & Schedule

- **FR5:** Visitors can view the full day schedule with time slots, activities, and group assignments (A/B)
- **FR6:** Visitors can see accreditation logistics (arrival time, €10 fee, set passport system)
- **FR7:** Visitors can understand how the two-group rotation works (shooting vs. central demo)
- **FR8:** The schedule renders correctly on mobile devices

### Instructor Profiles

- **FR9:** Visitors can read a biography and technique description for Alex Bibiano
- **FR10:** Visitors can read a biography and technique description for Toni Barbany
- **FR11:** Visitors can view portfolio photography samples for each instructor
- **FR12:** Each instructor page is reachable from the program/schedule section

### Shooting Sets

- **FR13:** Visitors can read a description of each of the 3 shooting sets (Bodegó barroc, Clau baixa, Transparents)
- **FR14:** Each set description includes the objects/props, lighting type, and main technique
- **FR15:** Visitors can understand how set assignment works (set passport, 4 photographers per slot per 40-minute session)

### Photography Contest

- **FR16:** Visitors can read the contest rules and understand the two categories (Bodegó fine art and Lliure)
- **FR17:** Visitors can see the prizes for each category (Bodegó fine art: €125/€100/€75 dinner; Lliure: €100/€75 dinner)
- **FR18:** Visitors can see the submission deadline (June 30, 2026) and jury verdict timeline (July 2026)
- **FR19:** Visitors can navigate to the external contest submission site (concurs.afparets.com)
- **FR20:** The contest page clarifies that Bodegó fine art requires photos taken during FOTOgraphic 2026, and Lliure is open to all participants

### Sponsors & Partners

- **FR21:** Visitors can see AFParets identified as the event organizer
- **FR22:** Visitors can see the Ajuntament de Parets del Vallès identified as collaborator
- **FR23:** No other sponsors or partners are displayed (2026 edition has none)

### Visitor Information

- **FR24:** Visitors can find the venue address and how to get there (transport, parking)
- **FR25:** Visitors can find nearby restaurant recommendations for the lunch break

### Event History

- **FR26:** Visitors can browse a summary of the 2025 edition (Danny Vela, skateboard theme, key facts) on this site
- **FR27:** Visitors can browse the same 2025 edition summary on the AFParets main site
- **FR28:** The history section presents past editions in chronological order

### Site Administration

- **FR29:** The site admin can update all edition-specific content (date, theme, instructors, schedule, contest) by editing YAML data files and page frontmatter — no template changes required
- **FR30:** The site admin can add new instructor portfolio images through the Hugo asset pipeline
- **FR31:** The site admin can deploy the updated site via `make deploy`

## Non-Functional Requirements

### Performance

- All pages achieve Largest Contentful Paint (LCP) under 3 seconds on a 4G mobile connection
- Instructor portfolio images resized via Hugo image processing — no raw full-resolution files served
- CSS minified and fingerprinted via PostCSS pipeline; no render-blocking resources
- `hugo --gc --minify --cleanDestinationDir` completes in under 10 seconds

### Accessibility

- All pages use semantic HTML5 elements (`<main>`, `<nav>`, `<article>`, `<section>`)
- All images include descriptive `alt` attributes
- Color contrast meets WCAG 2.1 AA minimum (Bootstrap 5 default palette compliant)
- All external links include `rel="noopener"` and indicate they open in a new tab
- No functionality depends on JavaScript (Bootstrap JS used only for optional interactive components)

### Reliability

- Site deployed and live by May 9, 2026 (4 weeks before the event)
- Deploy via `make deploy` only — no manual file transfers
- Static hosting on OVH VPS with no runtime dependencies ensures availability throughout the event day (June 6, 2026)
- `hugo server` used for local verification before every deploy
