---
title: 'Speaker profile photos on ponencia pages'
type: 'feature'
created: '2026-05-18'
status: 'done'
route: 'one-shot'
---

# Speaker profile photos on ponencia pages

## Intent

**Problem:** The Alex Bibiano and Toni Barbany ponencia pages had no portrait of the speaker, making it harder for visitors to put a face to the name.

**Approach:** Add a small circular portrait at the top of each bio, floated to the right at md+ and centered on mobile. Drop the now-redundant "Qui sóc" / "Qui és" introductory headings so the avatar reads as the section opener.

## Suggested Review Order

1. [SCSS — new `.ponencia-profile-photo` block + h2 clearfix](../../assets/scss/styles.scss#L410) — sizing, shape, and float-clearing guard for downstream sections.
2. [Alex Bibiano bio — shortcode call](../../content/ponencias/alex-bibiano.md#L7) — verify image path, alt text, Bootstrap utility combo, and that the removed `## Qui sóc` heading doesn't leave dangling references.
3. [Toni Barbany bio — shortcode call](../../content/ponencias/toni-barbany.md#L7) — same checks; confirm `originales/toni-perfil.jpg` resolves through the asset pipeline.
4. New portrait assets `assets/originales/abibiano-perfil.jpg` and `assets/originales/toni-perfil.jpg` — must be staged before commit or CI will fail to build images.
