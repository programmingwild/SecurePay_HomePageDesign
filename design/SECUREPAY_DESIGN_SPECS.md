# SecurePay Design System - Complete Specifications

## 1. COLOR PALETTE

### Background & Base
- **Primary BG**: `#090E23` (Dark Navy - main scaffold)
- **BG Gradient**: `#060A1E` → `#0A1030` → `#1A0B35` (top-left to bottom-right)
- **Secondary Surface**: `rgba(255, 255, 255, 0.08)` (Cards, containers)
- **Tertiary Surface**: `rgba(255, 255, 255, 0.12)` (Pills, badges)
- **Hover Surface**: `rgba(255, 255, 255, 0.14)` (Interactive elements)

### Accent & Brand Colors
- **Primary Accent**: `#3A63F3` (Seed color for Material3)
- **Secondary Accent**: `#1ED6FF` (Cyan)
- **Tertiary Accent**: `#34A0FF` (Sky Blue)
- **Success**: `#00A884` (Green - received payments, active status)
- **Warning**: `#EF5350` (Red - failed/pending)
- **Gradient Primary**: `#3C56FF` → `#34A0FF` → `#30DFC8` (Blue to Cyan to Teal)

### Quick Action Colors (8 Icons)
1. Scan & Pay: `#4B7CFF` (Blue)
2. Send Money: `#00A884` (Green)
3. Bank Transfer: `#8A5BFF` (Purple)
4. Wallet Top-Up: `#FF8A3D` (Orange)
5. Bill Pay: `#2CB3B0` (Teal)
6. Recharge: `#EF5350` (Red)
7. Cashback: `#6D7C93` (Gray)
8. Rewards: `#3A63F3` (Blue)

### Ambient Background Orbs (Parallax)
- **Top-Left Orb**: `#4B6BFF` @ 45% opacity (Blue)
- **Top-Right Orb**: `#00D5C9` @ 22% opacity (Cyan)
- **Bottom Beams**: `#6B87FF` @ 24% opacity, `#31D6B8` @ 18% opacity

### Text Colors
- **Primary Text**: `#FFFFFF` (White - 100%)
- **Secondary Text**: `#E5EDFF`, `#E2E9FF` (Very light blue)
- **Tertiary Text**: `#D0DAF7`, `#BFCBEA`, `#B9C8EC`, `#D6DEFF` (Light blue-gray)
- **Disabled Text**: `#8A9DD6` (Muted blue)
- **Positive Amount**: `#00A884` (Green)

---

## 2. TYPOGRAPHY SYSTEM

### Font Family
- **Primary Font**: Google Sans (all text)
- **Weights Used**: 400 (Regular), 600 (SemiBold), 700 (Bold), 800 (ExtraBold)

### Type Scale

| Component | Size | Weight | Color | Line Height |
|-----------|------|--------|-------|-------------|
| **Greeting** | 20px | 700 | White | 1.0 |
| **Subtitle** | 13px | 400 | #D0DAF7 | 1.0 |
| **Section Title** | 16px | 700 | White | 1.0 |
| **Balance Amount** | 32px | 800 | White | 1.0 |
| **Card Label** | 13px | 400 | #D6DEFF | 1.0 |
| **Tile Label** | 12px | 600 | White | 1.2 |
| **Status Text** | 11px | 600 | Varies | 1.0 |
| **Body Text** | 13px | 400 | #E2E9FF | 1.35 |
| **Small Text** | 12px | 400 | #E5EDFF | 1.0 |
| **Tiny Text** | 11px | 400 | #BECCEEE | 1.0 |

---

## 3. SPACING & LAYOUT

### Padding & Margins
- **Page Horizontal Padding**: 16px
- **Page Top Padding**: 10px+
- **Card Padding (Standard)**: 14px
- **Card Padding (Large)**: 18px
- **Section Gap (Vertical)**: 10-14px
- **Icon Gap**: 6-12px
- **Grid Gaps**: 10px

### Component Sizes
- **Header Icon**: 48×48px
- **3D Icon (Quick Actions)**: 36×36px (default), 32×32px (services), 30×30px (security)
- **Avatar Circle**: 48px diameter
- **Tile Aspect Ratio**: 0.95:1

### Border Radius
- **Hero Panel**: 18px
- **Section Card**: 16px
- **Service Pills/Badges**: 999px (fully rounded)
- **Input Fields**: 16px
- **Icon Background**: 14px
- **Buttons**: 12-14px

---

## 4. GLASS & BLUR EFFECTS

### Backdrop Filters (Glassmorphism)
| Element | Blur Amount | Note |
|---------|-----------|------|
| Hero Panel | 10px (X & Y) | Main security layer |
| Offer Ribbon | 8px (X & Y) | Cashback banner |
| Search Bar | 8px (X & Y) | Input field |
| Trust Stat Tiles | 8px (X & Y) | Confidence metrics |
| Bottom Nav | 14px (X & Y) | Dock navigation |

### Border Styling
- **Hero Panel**: `rgba(255, 255, 255, 0.20)` @ 1px
- **Standard Cards**: `rgba(255, 255, 255, 0.18)` @ 1px
- **Input Border**: `rgba(255, 255, 255, 0.16)` @ 1px (unfocused), `#6FD6FF` @ 1.2px (focused)

### Shadow Effects
| Component | Blur | Offset | Color | Alpha |
|-----------|------|--------|-------|-------|
| Header Icon | 18px | (0, 8) | #11C5FF | 40% |
| Balance Card | 22px | (0, 12) | #3E58FF | 30% |
| 3D Icon | 16px | (0, 8) | Icon color | 45% |
| Section Card | 24px | (0, 10) | #060B2D | 20% |

---

## 5. GRADIENTS

### Hero Panel Gradient (Main Card)
```
Direction: Top-Left → Bottom-Right
Colors: #663C56FF → #5534A0FF → #6630DFC8
Opacity: 40%, 33%, 40%
```

### Balance Card Gradient
```
Direction: Top-Left → Bottom-Right
Colors: #803A57FF → #8049C6FF → #8044E8C2
Opacity: 50%, 50%, 50%
```

### Offer Ribbon Gradient
```
Direction: Center-Left → Center-Right
Colors: #6662A0FF → #664EE6CC
Opacity: 40%, 40%
```

### Header Icon Gradient
```
Direction: Linear (top-down)
Colors: #1ED6FF → #5A72FF
```

### 3D Icon Base Gradient (Behind icon)
```
Direction: Top → Bottom
Colors: baseColor @ 45% → baseColor @ 15%
```

### 3D Icon Front Gradient (Icon face)
```
Direction: Top-Left → Bottom-Right
Colors: baseColor @ 95% → darken(baseColor, 25%)
```

### Rewards Pill Gradient
```
Direction: Linear
Colors: #44FFAA @ 26% → #33FFBE74
Border: #66FFECC2
```

---

## 6. INTERACTIVE EFFECTS

### Hover Tilt (3D Perspective)
- **Effect**: Mouse-position-based 3D rotation
- **Max Tilt Angle**: Varies by component
  - Hero Panel: 0.07 radians (~4°)
  - Balance Card: 0.06 radians (~3.4°)
  - Offer Ribbon: 0.05 radians (~2.9°)
  - Quick Actions: 0.08 radians (~4.6°)
  - Trust Tiles: 0.06 radians (~3.4°)
- **Transform**: Matrix4 with perspective (0.001 Z-depth)
- **Animation Duration**: 160ms smooth transition

### Animated Gradient Sweep
- **Effect**: Horizontal light sweep across surface
- **Duration**: 3200ms (hero panel) / 2600ms (offer ribbon)
- **Animation**: Infinite loop
- **Transform**: 
  - Rotation: -0.28 radians (-16°)
  - Translation: Shifts from -110% to +110% horizontally
- **Gradient**: White @ 20% → White @ 4%

### Reveal Animation (Staged Entry)
- **Effect**: Opacity fade-in + upward slide
- **Curve**: easeOutCubic
- **Base Duration**: 520ms
- **Staggered Delays**: 0ms, 60ms, 110ms, 160ms, 220ms, 280ms, 340ms, 400ms, etc.
- **Slide Distance**: 14px (Y-axis, upward)

### Scroll Parallax (Background)
- **Slow Layer (Orbs)**: scrollOffset × 0.08
- **Mid Layer**: scrollOffset × 0.12
- **Beam Layer**: scrollOffset × 0.16
- **Throttle Threshold**: 0.8px (updates only after 0.8px scroll)

---

## 7. COMPONENTS

### Hero Panel (Premium Security Layer)
```
Layout: Vertical stack (column)
Padding: 14px
Border Radius: 18px
Backdrop Filter: 10px blur
Gradient: Multi-color (blue-cyan-teal)
Border: rgba(255,255,255,0.2)
Hover Effect: _HoverTilt (0.07 max)
Contains:
  - Header row with 3D icon + "Premium Security Layer Active" + "Live" badge
  - Description text (13.5px, line-height 1.35)
  - 3 Trust badges (RBI Aligned, Device Binding, etc.)
  - Animated gradient sweep overlay (3200ms)
```

### Balance Card
```
Layout: Vertical stack (column)
Padding: 18px
Border Radius: 18px
Gradient: Blue-cyan-teal (50% opacity)
Border: rgba(255,255,255,0.22)
Shadow: 22px blur, (0,12) offset, #3E58FF @ 30%
Hover Effect: _HoverTilt (0.06 max)
Contains:
  - "SecurePay Wallet Balance" label (13px)
  - "₹28,540.73" amount (32px, 800 weight)
  - 2-column footer (account + UPI info)
```

### Wallet Offer Ribbon
```
Layout: Horizontal (row)
Padding: 12px horizontal, 10px vertical
Border Radius: 14px
Backdrop Filter: 8px blur
Gradient: Blue-teal (40% opacity, center-left to right)
Border: rgba(255,255,255,0.2)
Hover Effect: _HoverTilt (0.05 max)
Contains:
  - 3D Offer icon
  - Cashback text (12.5px, 600 weight)
  - "View" button (light background)
  - Animated gradient sweep (2600ms)
```

### Quick Actions Grid
```
Layout: 4×2 grid (4 columns, 8 items)
Item Padding: 8px horizontal, 10px vertical
Item Border Radius: 14px
Item Background: rgba(255,255,255,0.1)
Item Border: rgba(255,255,255,0.16)
Spacing: 10px (both axes)
Each Item:
  - 3D Icon (36px)
  - Label (12px, center-aligned)
  - Hover Effect: _HoverTilt (0.08 max)
```

### Trust Stat Tiles (3 columns)
```
Layout: 3 equal columns in a row
Each Tile:
  - Size: Flexible, ~equal height
  - Border Radius: 14px
  - Background: rgba(255,255,255,0.08)
  - Border: rgba(255,255,255,0.16)
  - Backdrop Filter: 8px blur
  - Padding: 10px
  - Hover Effect: _HoverTilt (0.06 max)
  - Contains: 3D icon + value + label
```

### Service Pills (Wrap)
```
Layout: Horizontal wrap (flexible)
Spacing: 10px between items
Each Pill:
  - Background: rgba(255,255,255,0.12)
  - Border Radius: 999px
  - Border: rgba(255,255,255,0.16)
  - Padding: 12px horizontal, 8px vertical
  - Contains: 3D icon + label (12px, 600 weight)
```

### Section Cards (Standard)
```
Layout: Container with title on top
Border Radius: 16px
Padding: 14px
Background: rgba(255,255,255,0.08)
Border: rgba(255,255,255,0.18)
Shadow: 24px blur, (0,10) offset, #060B2D @ 20%
Title: 16px, 700 weight, white
Content: Varies (grid, list, wrap, etc.)
```

### 3D Icon Object (Layered Icon)
```
Size: 36px (default), 30px (hero), 24-32px (services)
Structure:
  1. Back shadow: Gradient blur (baseColor @ 45% → 15%)
     Offset: (0, 3)
  2. Front face: Perspective-rotated container (0.22 rotateX, -0.08 rotateZ)
     - Gradient: baseColor @ 95% → dark(baseColor)
     - Border: rgba(255,255,255,0.35) @ 1px
     - Shine: White gradient @ top (50% → 0% opacity)
     - Icon: White centered (50% of size)
     - Shadow: baseColor @ 45%, 16px blur
Border Radius: 30% of size
```

### Bottom Navigation (Dock)
```
Style: NavigationBar (5 destinations)
Padding: 14px (outer), 0 (dock padding)
Border Radius: 18px
Backdrop Filter: 14px blur
Background: rgba(255,255,255,0.08)
Indicator: rgba(50,203,255,0.4)
Selected State: White text, 700 weight, white icon
Unselected State: #B8C6EA text/icon
Destinations:
  1. Home (home_rounded)
  2. Balance (account_balance_wallet_rounded)
  3. Scan (qr_code_scanner_rounded)
  4. Help (help_outline_rounded)
  5. Profile (person_outline_rounded)
```

---

## 8. RESPONSIVE BEHAVIOR

### Desktop (≥900px width)
- Content max-width: 980px
- Bills & Offers: Side-by-side (2 columns)
- 4-column quick actions grid
- Same spacing rules apply

### Mobile (<900px width)
- Content max-width: Full (320px min)
- Bills & Offers: Stacked (2 rows)
- 4-column quick actions grid
- Same spacing rules apply

### Scroll Behavior
- Physics: Bouncing scroll
- Cache extent: 1200px (optimization)
- Safe area: Top + Bottom applied

---

## 9. ANIMATIONS & TRANSITIONS

### Page Load Sequence
```
0ms → Header (H1, icon) - stagerIn delay 0ms
60ms → Search bar - staggerIn delay 60ms
110ms → Hero panel - staggerIn delay 110ms
160ms → Balance card - staggerIn delay 160ms
220ms → Offer ribbon - staggerIn delay 220ms
280ms → Trust tiles - staggerIn delay 280ms
340ms → Quick actions - staggerIn delay 340ms
...continuing 60ms increments
```

### Scroll Parallax Animation
```
- Parallax layers move at different speeds
- Slow orbs: 8% of scroll offset
- Mid orbs: 12% of scroll offset
- Beams: 16% of scroll offset
- Creates depth illusion on scroll
```

### Gradient Sweep Effect
```
Loop Duration: 3200ms (hero panel) or 2600ms (offer)
Movement: Left-to-right sweep
Transforms:
  - Rotation: -0.28 radians (-16°)
  - Translation: FractionalTranslation (animated from -1.1 to +1.1)
Effect: Horizontal light sweep across surface
```

### Hover State Transitions
```
Duration: 160ms (smooth easing)
Effect: 3D tilt based on mouse position
Direction: 
  - rotateX: -dy * maxTilt * 2
  - rotateY: dx * maxTilt * 2
On mouse exit: Immediate reset to flat (0 tilt)
```

---

## 10. LAYOUT DIMENSIONS

### Hero Panel
- Height: ~180px (estimated with padding + content)
- Width: Full (minus 16px padding)

### Balance Card
- Height: ~120px
- Width: Full

### Search Bar
- Height: 56px (standard Material TextField)
- Width: Full

### Quick Actions Grid
- Item height ratio: 0.95 aspect ratio
- Estimated height: ~320px (2 rows × ~160px + spacing)

### Contact Carousel
- Height: 86px
- Avatar: 48px
- Item width: 72px

### Bottom Navigation
- Height: ~80px (with safe area + padding)

---

## 11. COLORS - HEX REFERENCE

```
Primary BG:       #090E23
Gradient Top:     #060A1E
Gradient Mid:     #0A1030
Gradient Bot:     #1A0B35
Brand Blue:       #3A63F3
Cyan:             #1ED6FF / #00D5C9
Sky Blue:         #34A0FF
Success Green:    #00A884
Error Red:        #EF5350
Button BG (alt):  #C08BFF (rewards)
Header Gradient:  #66B7FF
Trust Badge:      #4AE2C2

Action Colors (Quick Actions):
  #4B7CFF, #00A884, #8A5BFF, #FF8A3D
  #2CB3B0, #EF5350, #6D7C93, #3A63F3

Text Colors:
  White:         #FFFFFF
  Primary Text:  #E5EDFF / #E2E9FF
  Secondary:     #D6DEFF / #D0DAF7
  Tertiary:      #BFCBEA / #B9C8EC
  Disabled:      #8A9DD6
```

---

## 12. LAYER STRUCTURE (Z-INDEX)

1. **Background** (Bottom)
   - Gradient background
   - Ambient parallax orbs/beams

2. **Content Layers**
   - Header
   - Search bar
   - Hero panel
   - Balance card
   - Offer ribbon
   - Quick actions
   - etc.

3. **Overlays**
   - Animated gradient sweeps
   - Hover effects

4. **Navigation** (Top)
   - Bottom dock navigation

---

## 13. KEY INTERACTIONS

### Search Functionality
- Input changes trigger contact filtering
- Filtered list updates in real-time
- Empty state when no matches

### Bottom Navigation
- 5 destinations (Home, Balance, Scan, Help, Profile)
- Selected state: Highlighted with indicator
- Current implementation shows Home as active

### Hover Effects
- All interactive cards support 3D tilt
- Smooth 160ms transition
- Resets on mouse exit

### Transactions List
- Recent 5 transactions shown
- Status indicators (Success/Pending)
- Amount color coding (Green for +, White/Teal for -)

---

This is the complete design specification for SecurePay. All colors, spacing, typography, and effects are documented for pixel-perfect implementation in Figma.
