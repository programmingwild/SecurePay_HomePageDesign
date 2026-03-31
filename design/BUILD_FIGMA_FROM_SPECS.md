# How to Build SecurePay Figma Design File

## Quick Start (Recommended: 30-45 minutes)

You have the complete design specifications in `SECUREPAY_DESIGN_SPECS.md`. Here's the fastest way to create the Figma file:

---

## Method 1: Screenshot-Based Design (Fastest)

### Step 1: Capture Homepage Screenshot
1. Run the app: `flutter run -d web-server --web-port 8114`
2. Open browser: http://localhost:8114
3. Take a full-page screenshot (scroll all the way down to capture entire page)
4. Save as `design/securepay-screenshot.png`

### Step 2: Create Figma File
1. Sign in to Figma (figma.com)
2. Create New File → Name it "SecurePay-Homepage"
3. Set canvas size to **1440×2600px** (iPhone max width × full height)
4. Right-click canvas → **Insert image** → Select screenshot
5. Drag screenshot to fill canvas (use specifications to match alignment)

### Step 3: Add Design Layers
Using the screenshot as reference + `SECUREPAY_DESIGN_SPECS.md`:

**Assets to Create:**
1. **Color Styles** (21 total)
   - Copy hex colors from Section 11 of specs
   - Create Figma color styles for each

2. **Text Styles** (8 total)
   - Greeting: 20px, 700 weight, white
   - Subtitle: 13px, 400, #D0DAF7
   - Balance: 32px, 800, white
   - Body: 13px, 400, #E2E9FF
   - (See Section 2 of specs for all)

3. **Component Library**
   - Quick Action Tile (36×36 icon, label)
   - Trust Stat Tile (icon, value, label)
   - Service Pill (icon + label)
   - Section Card (title + content frame)
   - Transaction Item (icon, title, time, amount, status)
   - Contact Avatar (circle, initial)

### Step 4: Create Components from Specs
1. **Hero Panel** (Section 7)
   - Create rounded frame (18px border radius)
   - Add gradient: #663C56FF → #5534A0FF → #6630DFC8
   - Add 10px backdrop blur
   - Add border: rgba(255,255,255,0.2) @ 1px
   - Add shadow: #11C5FF @ 40%, 18px blur

2. **Balance Card** (Section 7)
   - Frame, 18px padding all sides
   - Gradient: #803A57FF → #8049C6FF → #8044E8C2
   - Text stack: label (13px) + amount (32px) + info row

3. **Quick Actions Grid** (Section 7)
   - 4-column grid, 10px spacing
   - Each tile: 36px icon + 12px gap + label (centered)
   - 8 items total with colors from Section 1

4. **Bottom Navigation** (Section 7)
   - 5 icon destinations
   - 14px backdrop blur
   - rgba(255,255,255,0.08) background

---

## Method 2: SVG Import (10 minutes)

1. Open `design/securepay_homepage_figma_import.svg` (previously created)
2. In Figma: File → Import → Select SVG
3. Drag to canvas
4. Convert to components as needed

---

## Method 3: From Code Reference (Most Accurate)

### Color Palette Setup
```
Create Figma color styles with exact names:
- BG-Primary: #090E23
- BG-Gradient-Top: #060A1E
- BG-Gradient-Mid: #0A1030
- BG-Gradient-Bottom: #1A0B35
- Brand-Blue: #3A63F3
- Cyan-Primary: #1ED6FF
- Cyan-Secondary: #00D5C9
- Sky-Blue: #34A0FF
- Success-Green: #00A884
- Error-Red: #EF5350
- Text-Primary: #FFFFFF
- Text-Secondary: #E5EDFF
- Text-Tertiary: #D6DEFF
- ... (reference Section 11 of specs)
```

### Typography Setup
```
Create text styles:
- Heading-1: GoogleSans, 20px, 700, white
- Heading-2: GoogleSans, 16px, 700, white
- Body-Large: GoogleSans, 13px, 400, #E5EDFF
- Body-Small: GoogleSans, 12px, 400, #E5EDFF
- Label: GoogleSans, 12px, 600, white
- Status: GoogleSans, 11px, 600, varies
- ... (reference Section 2 of specs)
```

### Component Hierarchy
```
├── 3D-Icon-Base
│   ├── Icon (36px, configurable)
│   ├── Gradient-Back (shadow layer)
│   └── Gradient-Front (face layer)
├── Button-Styles
├── Tiles
│   ├── Quick-Action-Tile
│   ├── Trust-Stat-Tile
│   └── Service-Pill
└── Cards
    ├── Hero-Panel
    ├── Balance-Card
    ├── Offer-Ribbon
    └── Section-Card
```

---

## Key Specifications for Accurate Implementation

### Dimensions Reference
- **Page Width**: 1440px (desktop), 375px (mobile preview)
- **Page Height**: 2600px (full scroll)
- **Header Height**: ~70px
- **Hero Panel Height**: ~180px
- **Balance Card Height**: ~120px
- **Quick Actions Grid**: ~320px (2 rows)
- **Section Card Padding**: 14px all sides
- **Bottom Nav Height**: ~80px

### Colors to RGB (for Figma import)
- #090E23 = RGB(9, 14, 35)
- #060A1E = RGB(6, 10, 30)
- #3A63F3 = RGB(58, 99, 243)
- #00A884 = RGB(0, 168, 132)
- (Use Figma's color picker paste feature for hex)

### Blur Filter Settings
| Element | Blur |
|---------|------|
| Hero Panel | 10px |
| Offer Ribbon | 8px |
| Search Bar | 8px |
| Trust Tiles | 8px |
| Bottom Nav | 14px |

### Shadow Settings
| Component | Blur | Y-Offset | Color | Opacity |
|-----------|------|----------|-------|---------|
| Header Icon | 18px | 8px | Brand Blue | 40% |
| Balance Card | 22px | 12px | #3E58FF | 30% |
| Section Card | 24px | 10px | #060B2D | 20% |

---

## Animation Specifications (for Developer Handoff)

These effects are implemented in Flutter but document for reference:

### Hover Tilt (3D)
- Max rotation: 0.05-0.08 radians by component
- Transition: 160ms smooth
- Applied to: Hero, Balance, Offer, Quick Actions, Trust Tiles

### Gradient Sweep
- Duration: 3200ms (hero), 2600ms (offer)
- Direction: Left to right
- Rotation: -0.28 radians (-16°)

### Reveal Animation
- Staggered delays: 0ms, 60ms, 110ms, 160ms... (60ms increments)
- Opacity: 0 → 1
- Slide: 14px down → 0
- Curve: easeOutCubic

### Scroll Parallax
- Background layers move at different speeds when scrolling
- Multipliers: 0.08, 0.12, 0.16 (different layer drift rates)

---

## Exporting Figma Design

Once your design is complete in Figma:

### Desktop/Web
1. File → Export → SVG (for reference)
2. File → Download as → figma.zip (contains .fig file)

### Using with Flutter Code
1. Take screenshots of each component at 1x scale
2. Reference `lib/main.dart` for exact color values
3. Verify all fonts match GoogleSans weights (400, 600, 700, 800)
4. Validate spacing using `SECUREPAY_DESIGN_SPECS.md` Section 3

---

## Component Copy-Paste Reference

### Quick Action Item (Color 1: Scan & Pay - Blue)
```
Frame: 100×110px, rounded 14px
Background: rgba(255,255,255,0.1)
Border: rgba(255,255,255,0.16), 1px
Padding: 8px horizontal, 10px vertical

Contents:
  - 3D Icon (36×36px, #4B7CFF base color)
  - Gap: 8px
  - Text: "Scan & Pay", GoogleSans 12px, 600 weight, white, centered
```

Repeat for 7 more items with colors from Section 1.

### Trust Stat Tile (Example: Trust Score)
```
Frame: Flexible width (3 cols), ~100px height
Border Radius: 14px
Background: rgba(255,255,255,0.08)
Border: rgba(255,255,255,0.16), 1px
Blur Filter: 8px
Padding: 10px
Shadow: 16px blur, (0, 8), color:icon-color, 45% opacity

Contents:
  - 3D Icon (26×26px, #4AE2C2 base color)
  - Gap: 8px
  - Value Text: "98/100", white, 700 weight
  - Gap: 2px
  - Label Text: "Trust Score", #BECCEEE, 11px
```

---

## File Export Checklist

- [ ] All 8 quick action colors applied
- [ ] 3D icon perspective and gradients set
- [ ] Backdrop blur on glassmorphic elements
- [ ] All text uses GoogleSans font family
- [ ] Section card borders at correct opacity
- [ ] Shadow blur values match specs
- [ ] Gradient angles and colors certified
- [ ] 1440×2600px canvas size
- [ ] Safe area padding observed
- [ ] Bottom nav has correct 5 destinations

---

## Next Steps

1. **Option A (Fastest)**: Use screenshot + specs to build in Figma (30-45 min)
2. **Option B (Detailed)**: Component-by-component from code reference (1-2 hours, most accurate)
3. **Option C (SVG Import)**: Use `design/securepay_homepage_figma_import.svg`

Once complete, **export .fig file and I'll implement any adjustments to Flutter code for pixel-perfect match**.

All colors, spacing, effects, and fonts are documented in `SECUREPAY_DESIGN_SPECS.md` for reference.

Questions? Reference Section numbers in the design spec file above.
