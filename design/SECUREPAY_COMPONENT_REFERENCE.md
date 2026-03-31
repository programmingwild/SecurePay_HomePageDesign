# SecurePay Component Library & Design Export

**Generated:** March 31, 2026  
**App Version:** 1.0.0  
**Design System:** Material 3 + Custom Procedural 3D  

---

## 1. EXPORTED COMPONENTS

### Hero Panel
- **Size:** Full width - 16px horizontal padding
- **Height:** 120-140px
- **Background:** `Color(0xFF090E23)` (dark) / `Color(0xFFDBE8FF)` (light)
- **Blur:** 10px backdrop filter (glassmorphism)
- **Border Radius:** 18px
- **Content:**
  - 3D icon (48×48px) with procedural mesh rendering
  - Greeting text: "Hello, User" (20px, 700 weight)
  - Subtitle: "Secure UPI, Wallet & Recharges" (13px, 400 weight)
  - Status pill with blue accent badge
  - 3 trust badges (icons)

### Balance Card
- **Size:** Full width - 16px horizontal padding
- **Height:** 160px
- **Background:** Gradient with 8% white overlay
- **Border Radius:** 16px
- **Content:**
  - 3D icon (36×36px)
  - Label: "SecurePay Wallet Balance" (13px, 400 weight)
  - Amount: "₹45,82,914" (32px, 800 weight)
  - Subtext: "Linked Bank •••• 2184" (13px)
  - Verification badge with email: "user@securepay"

### Quick Actions Grid
- **Layout:** 4×2 grid
- **Grid Gap:** 10px
- **Tile Size:** 80×80px each
- **Border Radius:** 14px
- **Tiles:**
  1. Scan & Pay (Blue #4B7CFF)
  2. Send Money (Green #00A884)
  3. Bank Transfer (Purple #8A5BFF)
  4. Wallet Top-Up (Orange #FF8A3D)
  5. Bill Pay (Teal #2CB3B0)
  6. Recharge (Red #EF5350)
  7. Cashback (Gray #6D7C93)
  8. Rewards (Blue #3A63F3)
- **Interactions:**
  - Tap: Scale 0.95 (140ms, easeOutCubic)
  - Hover: 1.02x scale, elevated shadow
  - Success: Confetti burst from center

### Offer Ribbon
- **Size:** Full width - 16px horizontal padding
- **Height:** 48px
- **Background:** Gradient accent
- **Blur:** 8px backdrop filter
- **Border Radius:** 16px
- **Content:**
  - Icon (24×24px)
  - Offer text: "Get 10% Cashback" (13px, 600 weight)
  - CTA: "Claim" button (blue accent)

### Pay Contacts Section
- **Layout:** Horizontal scroll
- **Height:** 80px
- **Contact Avatar:**
  - Size: 48px diameter
  - Full rounded (999px border radius)
  - Initials or profile image
- **Interactions:**
  - Tap: Triggers success animation + haptic feedback

### Recent Transactions List
- **Layout:** Vertical scroll list
- **Item Height:** 56px
- **Content per item:**
  - Avatar (32×32px)
  - Name & status (13px secondary text)
  - Amount (16px primary text)
  - Date (11px tertiary text)
- **Interactions:**
  - Tap: Triggers success animation + haptic feedback

### Premium Onboarding Carousel
- **Layout:** 3-slide PageView carousel
- **Slide Height:** Full screen (2400px viewport)
- **Slides:**
  1. "Designed For Confident Payments"
     - Icon: layers_rounded
     - Accent: #5D7BFF → #45E2C6
     - Tags: Glass UI, Fluid Motion, Adaptive Theme
  2. "Protection That Feels Invisible"
     - Icon: shield_moon_rounded
     - Accent: #8A63FF → #5DA3FF
     - Tags: Risk Engine, Device Trust, 24x7 Monitoring
  3. "Every Successful Payment Feels Premium"
     - Icon: celebration_rounded
     - Accent: #FF7B9C → #FFC05A
     - Tags: Success FX, Micro-interactions, Real-time Delight
- **Controls:**
  - Glass cards with 3D icons
  - Progress dots (bottom)
  - Next/Skip buttons
  - Theme toggle

### Glass Onboarding Card
- **Size:** 160×200px
- **Background:** 16% white with 10px blur
- **Border:** 1px white subtle line
- **Border Radius:** 18px
- **Content:**
  - 3D icon (48×48px) with dual glow
  - Title (16px, 700 weight)
  - Subtitle (13px, 400 weight)
  - 3 tag chips (11px, 600 weight)

---

## 2. ANIMATION SYSTEMS

### _HoverTilt (3D Motion Tracking)
- **Duration:** 240ms
- **Rotation:** ±0.07 radians on mouse move
- **Scale on hover:** 1.02x
- **Shadow elevation:** 32px blur (hover) → 14px blur (rest)
- **Easing:** smooth transition

### _SuccessBurstOverlay (Confetti)
- **Particle count:** 84
- **Spread:** Origin-aware radius spread
- **Animation duration:** 1050ms total
  - Gravity arc: 0-400ms
  - Swirl: Continuous throughout
  - Fade: 800-1050ms
- **Colors:** Cycled palette from accent colors
- **Direction:** Outward burst from tap origin

### _InteractiveTile (Press Feedback)
- **Animation:** ScaleTransition 1.0 → 0.95
- **Duration:** 140ms
- **Curve:** easeOutCubic
- **Double shadow layers:** Primary + secondary

### _AnimatedGradientSweep (Animated Gradient)
- **Duration:** Looping
- **Opacity (dark):** 0.2→0.12 animated
- **Opacity (light):** 0.04→0.02 animated
- **Spread angle:** 90-180° sweep

### _RevealIn (Staggered Reveal)
- **Base duration:** 520ms
- **Stagger delay:** Per-element offset
- **Curve:** easeOutCubic
- **Transform:** Opacity + 20px vertical translate

---

## 3. 3D RENDERING SYSTEM

### Procedural Mesh Painter (_ProceduralMeshPainter)
- **Shape:** 3D cube
- **Vertices:** 8 corners in 3D space
- **Faces:** 6 faces (front, back, left, right, top, bottom)
- **Lighting:**
  - Dynamic normal-based luminance
  - Perspective distance: 4.4 units
  - Darken blend: 38% (dark) / 28% (light)
  - Edge stroke: white (dark) / #4E6694 (light)

### Glow System
- **Primary glow:** 32% opacity (dark) → 22% opacity (light)
- **Secondary glow:** 12% opacity (dark) → 8% opacity (light)
- **Color:** Icon glyph color with blur

### Icon Colors (Mode-Aware)
- **Dark mode:** Colors.white (glyphs)
- **Light mode:** Color(0xFF14305F) (navy glyphs)

---

## 4. RESPONSIVE SCALING

### Web Phone Emulator (_WebPhoneEmulatorShell)
- **Target size:** 1080×2400 (tablet-like aspect ratio)
- **Scaling:** min(widthScale, heightScale).clamp(0.55, 1.0)
- **Border radius:** 32px
- **Border:** 1.3px #25345B
- **Shadow:** 30px blur, 4px spread, -66% opacity
- **Background:** #0A1027 (dark frame)

---

## 5. THEME VARIANTS

### Dark Theme
- **Scaffold BG:** #090E23
- **Gradient:** #060A1E → #0A1030 → #1A0B35
- **Text:** White (#FFFFFF)
- **Secondary text:** #E5EDFF
- **Surfaces:** rgba(255, 255, 255, 0.08-0.14)
- **Accents:** #3A63F3, #1ED6FF, #34A0FF
- **Shadows:** Higher opacity (24-40%)

### Light Theme
- **Scaffold BG:** #F8FBFF
- **Gradient:** #F8FBFF → #DBE8FF
- **Text:** Navy (#0F2450)
- **Secondary text:** #3D5A8C
- **Surfaces:** #f4f8ff, #e8f0ff
- **Accents:** Brightened vs dark mode
- **Shadows:** Lower opacity (8-16%)
- **Icon glyph:** #14305F (navy)

---

## 6. FIGMA IMPORT INSTRUCTIONS

### Option 1: Import Design Tokens
1. Open `SECUREPAY_DESIGN_TOKENS.json` file
2. In Figma, open Library/Variables panel
3. Click **Import tokens** → Select file
4. All colors, typography, spacing will be available as variables

### Option 2: Manual Component Setup
1. Create page "Components"
2. Use color palette from Section 1
3. Build components using dimensions from Section 2
4. Link animations using interaction descriptions

### Option 3: Figma Plugin Install
- Search "Design Tokens Importer" in Figma plugins
- Paste tokens JSON content directly
- Auto-generates all color/spacing/typography variables

---

## 7. ASSET SUMMARY

| Asset | Type | Qty | Status |
|-------|------|-----|--------|
| Color Tokens | Design Token | 50+ | ✅ Exported |
| Typography Styles | Design Token | 12+ | ✅ Exported |
| Spacing System | Design Token | 6 scales | ✅ Exported |
| Components | UI Element | 8 major | ✅ Documented |
| Animations | Interaction | 5 systems | ✅ Documented |
| 3D Icons | Custom | 12 instances | ✅ Live in app |
| Responsive Sizes | Layout | 1 breakpoint | ✅ Configured |

---

## 8. NEXT STEPS IN FIGMA

1. Import `SECUREPAY_DESIGN_TOKENS.json` using Variables
2. Create Main components from documented specs
3. Link components to design tokens (colors, spacing)
4. Set up component properties (theme variant, size, state)
5. Export as Figma library for team sharing

**Contact:** All design data is live and updated via the Flutter app at localhost:8127

