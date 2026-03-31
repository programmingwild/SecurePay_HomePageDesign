# How to Make a Real Figma Design File (.fig) for SecurePay

This is the practical workflow to convert the current homepage into an editable Figma design and save it as a `.fig` file.

## Option A (Fastest): Use the prepared SVG

Use this when you want a complete visual baseline quickly.

1. Open Figma (desktop app or browser).
2. Create a new design file.
3. Drag this file into Figma canvas:
   - `design/securepay_homepage_figma_import.svg`
4. Select all imported layers.
5. Run **Organize / Tidy up** (optional) to clean spacing.
6. Convert major blocks into components:
   - Header
   - Search bar
   - Hero panel
   - Wallet card
   - Quick action tile
   - Trust metric tile
   - Bottom nav item
7. Apply Auto Layout where needed for responsive resizing.
8. Rename frames and groups clearly (e.g., `Home/Desktop/1440`).
9. Save as `.fig` file:
   - Figma Desktop: **File -> Save local copy (.fig)**

## Option B (Higher Fidelity): Rebuild from Flutter screen in Figma

Use this when you want design-system-quality layers.

1. Run app and capture screenshots at these breakpoints:
   - Desktop: 1440 x 2600 (full page)
   - Tablet: 768 width
   - Mobile: 390 width
2. Import screenshots into Figma as locked reference layer.
3. Recreate structure using components and variables:
   - Colors (bg, glass, accent, text-primary, text-secondary)
   - Typography (Google Sans scale)
   - Radius, spacing, shadows
4. Create component set variants:
   - Buttons: primary / secondary / hover
   - Cards: default / highlighted / premium
   - Pills: default / active
   - Nav item: selected / unselected
5. Add interactive states in Prototype tab.
6. Save local `.fig` copy.

## Font setup in Figma

Use **Google Sans** to match Flutter:

1. Install Google Sans on your machine (if not installed).
2. Restart Figma app.
3. Replace fallback text styles with Google Sans.

## Recommended file structure in Figma

- `01 Foundations`
  - Colors
  - Typography
  - Effects
  - Spacing
- `02 Components`
  - Buttons
  - Cards
  - Pills
  - Navigation
- `03 Screens`
  - Home / Desktop
  - Home / Tablet
  - Home / Mobile
- `04 Prototypes`

## What you already have in this project

- Importable design source: `design/securepay_homepage_figma_import.svg`
- Quick import notes: `design/FIGMA_IMPORT_GUIDE.md`

If you want, I can next generate a **token JSON + component naming spec** so your Figma file and Flutter code stay 1:1 aligned.
