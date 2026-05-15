# Project Overview — FOTOgraphic Parets

## Summary

FOTOgraphic Parets is the official event website for the annual photography festival organized by the Associació Fotogràfica Parets (AFParets). This is the 12th edition of the event (2025 edition). The site promotes the event, lists the program, details the national photo contest, and provides visitor information.

- **Live URL:** https://fotographicparets.com
- **Event Date:** November 29, 2025
- **Author:** Alex Bibiano
- **License:** MIT

## Purpose

The website serves as the primary communication channel for the FOTOgraphic Parets event. It covers:

1. **Event promotion** — hero section with CTAs to program and registration
2. **Program / Lectures (Ponències)** — detailed speaker schedule and sessions
3. **Photography Contest** — contest rules, theme, prizes, submission details
4. **Exhibitions** — previous edition's winning photos
5. **Visitor Guide** — how to get there, parking, restaurants
6. **About** — history of the association and past editions
7. **Testimonials** — opinions from past attendees

## Technology Stack

| Category | Technology | Version |
|----------|-----------|---------|
| Static Site Generator | Hugo | Latest |
| CSS Framework | Bootstrap | 5.3.3 |
| CSS Processor | PostCSS CLI | 11.0.0 |
| Markup | Goldmark (Markdown) | — |
| Templating | Go Templates (Hugo) | — |
| Package Manager | npm | — |
| Deployment | Make + rsync over SSH | — |
| Hosting | OVH VPS (Ubuntu) | — |

## Content Language

All content is written in **Catalan** (`ca`). The site uses `languageCode = "ca"` and `defaultContentLanguage = "ca"` in Hugo config.

## Architecture Type

**Static Site Generation (SSG)** — Hugo compiles all content at build time into static HTML/CSS/JS. There is no backend, no database, and no runtime server. The entire site is a set of static files served by Nginx/Apache on the OVH VPS.

## Repository Structure

Single-part monolith. The primary project for the annual event website. There is a separate, related project:

- **afparets_web_fotographicparets** (this project) — The FOTOgraphic Parets event site
- **afparets** (`/Users/abibiano/Projects/Web/afparets/`) — The main AFPARETS association website (Hugo + Blowfish theme)

## Key Content Pages

| URL | Content File | Description |
|-----|-------------|-------------|
| `/` | `content/_index.md` | Homepage with hero, features, highlights |
| `/ponencias/` | `content/ponencias/_index.md` | Program/schedule listing |
| `/ponencias/danny-vela/` | `content/ponencias/danny-vela.md` | Speaker biography |
| `/concurso/` | `content/concurso.md` | National photo contest rules |
| `/exposiciones-fotographic/` | `content/exposiciones-fotographic.md` | Photo exhibitions |
| `/quienes-somos/` | `content/quienes-somos.md` | About the association |
| `/guia/` | `content/guia.md` | Visitor guide (maps, transport) |
| `/opiniones/` | `content/opiniones.html` | Attendee testimonials |
| `/politica-privacidad/` | `content/politica-privacidad.md` | Privacy policy |

## 2025 Event Highlights

- **Theme:** Skateboarding photography
- **Main Speaker:** Danny Vela (action sports photographer — MotoGP, skateboarding)
- **Contest:** VII Concurs Nacional de Fotografia "4t Memorial CHUSSA MULÀ" (theme: Skate)
- **Format:** Theoretical sessions + 3 photo shoots (flash, continuous light, night)
- **Schedule:** 9:30 AM – 8:00 PM (13 time-slotted activities)
- **Partners:** Municipality of Parets del Vallès, Catalan Photography Federation, Nikon, FOTIMA Import, SB Ramps, and others
