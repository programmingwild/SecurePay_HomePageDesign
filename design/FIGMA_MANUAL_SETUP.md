# 📋 SecurePay - Manual Figma Setup Guide

**No JSON imports needed. Build manually step-by-step in Figma.**

---

## 1️⃣ CREATE COLOR STYLES

### Dark Theme Colors
Copy-paste these and create **Color Styles** in Figma:

| Name | Hex | RGB |
|------|-----|-----|
| Color / Dark / Background / Primary | `#090E23` | rgb(9, 14, 35) |
| Color / Dark / Background / Secondary | `#0F1429` | rgb(15, 20, 41) |
| Color / Dark / Text / Primary | `#FFFFFF` | rgb(255, 255, 255) |
| Color / Dark / Text / Secondary | `#E5EDFF` | rgb(229, 237, 255) |
| Color / Dark / Text / Tertiary | `#D0DAF7` | rgb(208, 218, 247) |
| Color / Dark / Accent / Primary | `#3A63F3` | rgb(58, 99, 243) |
| Color / Dark / Accent / Secondary | `#1ED6FF` | rgb(30, 214, 255) |
| Color / Dark / Semantic / Success | `#00A884` | rgb(0, 168, 132) |
| Color / Dark / Semantic / Warning | `#EF5350` | rgb(239, 83, 80) |

### Light Theme Colors

| Name | Hex | RGB |
|------|-----|-----|
| Color / Light / Background / Primary | `#F8FBFF` | rgb(248, 251, 255) |
| Color / Light / Background / Secondary | `#F4F8FF` | rgb(244, 248, 255) |
| Color / Light / Text / Primary | `#0F2450` | rgb(15, 36, 80) |
| Color / Light / Text / Secondary | `#3D5A8C` | rgb(61, 90, 140) |
| Color / Light / Text / Tertiary | `#6B7FA3` | rgb(107, 127, 163) |

---

## 2️⃣ CREATE TEXT STYLES

### Heading (20px, Bold)
- **Font:** Google Sans
- **Size:** 20px
- **Weight:** 700
- **Color:** Color / Dark / Text / Primary

### Section Title (16px, Bold)
- **Font:** Google Sans
- **Size:** 16px
- **Weight:** 700
- **Color:** Color / Dark / Text / Primary

### Body (13px, Regular)
- **Font:** Google Sans
- **Size:** 13px
- **Weight:** 400
- **Color:** Color / Dark / Text / Secondary

### Label (12px, SemiBold)
- **Font:** Google Sans
- **Size:** 12px
- **Weight:** 600
- **Color:** Color / Dark / Text / Primary

### Amount (32px, ExtraBold)
- **Font:** Google Sans
- **Size:** 32px
- **Weight:** 800
- **Color:** Color / Dark / Text / Primary

---

## 3️⃣ CREATE BUTTON COMPONENT

### Step 1: Create Base Button
1. **Rectangle** → 200px width × 60px height
2. **Fill:** `#3A63F3` (Primary Accent)
3. **Corner radius:** 14px
4. **Add text:** "Button" (20px, white)
5. **Center text:** Align center

### Step 2: Create Variants
1. **Right-click** → Create component
2. **Right-click component** → Add variant
3. **Create 3 variants:**
   - **Default:** No changes
   - **Hover:** Opacity 0.9
   - **Pressed:** Scale 0.95, shadow 0 4px 12px rgba(0,0,0,0.24)

---

## 4️⃣ CREATE CARD COMPONENT

### Glass Card (Hero Panel)
1. **Rectangle** → 100% width (e.g., 1000px for demo)
2. **Fill:** `rgba(255, 255, 255, 0.08)` (8% white)
3. **Stroke:** 1px `rgba(255, 255, 255, 0.1)`
4. **Corner radius:** 18px
5. **Effects (Blur):** 10px
6. **Shadow:** `0 8px 24px rgba(0, 0, 0, 0.32)`

### Gradient Card (Balance)
1. **Rectangle** → Full width, 160px height
2. **Fill:** Linear gradient
   - Start: `rgba(58, 99, 243, 0.2)`
   - End: `rgba(30, 214, 255, 0.1)`
3. **Stroke:** 1px `rgba(30, 214, 255, 0.2)`
4. **Corner radius:** 16px

---

## 5️⃣ CREATE QUICK ACTIONS GRID

### Layout
- **Grid:** 4 columns × 2 rows
- **Gap:** 10px
- **Tile size:** 80×80px each

### Tile Component
1. **Rectangle** → 80×80px
2. **Corner radius:** 14px
3. **Fill colors:** (see table below)
4. **Add Icon:** Material icon (36×36px)
5. **Add Label:** 12px text below (4px gap)

### Colors per Tile
| # | Action | Color |
|---|--------|-------|
| 1 | Scan & Pay | `#4B7CFF` |
| 2 | Send Money | `#00A884` |
| 3 | Bank Transfer | `#8A5BFF` |
| 4 | Wallet Top-Up | `#FF8A3D` |
| 5 | Bill Pay | `#2CB3B0` |
| 6 | Recharge | `#EF5350` |
| 7 | Cashback | `#6D7C93` |
| 8 | Rewards | `#3A63F3` |

---

## 6️⃣ CREATE PHONE FRAME

1. **Rectangle** → 1080×2400px
2. **Fill:** None (transparent)
3. **Stroke:** 1.3px `#25345B`
4. **Corner radius:** 32px
5. **Shadow:**  
   ```
   X: 0, Y: 16, Blur: 30, Spread: 4
   Color: rgba(0, 0, 0, 0.66)
   ```
6. **Use as artboard frame** for your designs

---

## 7️⃣ BUILD HOME SCREEN LAYOUT

### Inside Phone Frame (1080×2400)

#### Top Section (y: 0-200px)
```
Greeting: "Hello, User" (20px, 700)
Subtitle: "Secure UPI, Wallet & Recharges" (13px, 400)
```

#### Hero Panel (y: 120px, h: 130px)
```
- Apply glass card component
- Add 3D icon placeholder (48×48px)
- Status text: "SecurePay Status: Active"
```

#### Balance Card (y: 280px, h: 160px)
```
- Apply gradient card component
- Label: "SecurePay Wallet Balance" (13px)
- Amount: "₹45,82,914" (32px, 800)
- Subtext: "Linked Bank •••• 2184"
- Verified badge icon + "user@securepay"
```

#### Quick Actions (y: 480px)
```
- Section title: "Quick Actions" (16px, 700)
- Apply 4×2 grid component (10px gap, 80×80 tiles)
```

#### Pay Someone (y: 1100px)
```
- Section title: "Pay Someone"
- Horizontal scroll area
- 4 circular avatars (48px diameter)
```

#### Recent Transactions (y: 1280px)
```
- Section title: "Recent Transactions"
- List of transaction items
- Each: Avatar (32px) | Name + Status | Amount
```

---

## 8️⃣ CREATE ONBOARDING SCREENS

### Screen 1: "Designed For Confident Payments"

**Setup:**
1. **Frame:** 1080×2400px
2. **Background:** Linear gradient
   ```
   start: #040819
   end: #1A0F3A
   angle: 135°
   ```

**Content:**
```
Title (y: 800px):
  "Designed For Confident Payments"
  Font: 28px, 700, white
  Center text, 1000px width

Subtitle (y: 880px):
  "A cinematic wallet experience with smart motion..."
  Font: 16px, 400, #E5EDFF
  Center text

Tags (y: 1000px):
  3 chips: "Glass UI" | "Fluid Motion" | "Adaptive Theme"
  Background: rgba(93, 123, 255, 0.2)
  Border: 1px rgba(93, 123, 255, 0.3)
  Corner radius: 999px

Buttons (y: 2200px):
  - "Next" button (400×60px, primary)
  - "Skip" button (400×60px, ghost with #E5EDFF border)
  Gap: 100px
```

### Screen 2: "Protection That Feels Invisible"
- Same layout as Screen 1
- Title text change
- Tag colors: `#8A63FF`
- Accent: `#5DA3FF`

### Screen 3: "Every Successful Payment Feels Premium"
- Same layout as Screen 1
- Title text change
- Tag colors: `#FF7B9C`
- Accent: `#FFC05A`

---

## 9️⃣ APPLY SHADOWS

### Dark Mode Shadows
```
Small:   0px 4px 12px rgba(0, 0, 0, 0.24)
Medium:  0px 8px 24px rgba(0, 0, 0, 0.32)
Large:   0px 12px 32px rgba(0, 0, 0, 0.40)
```

### Light Mode Shadows
```
Small:   0px 2px 8px rgba(15, 36, 80, 0.08)
Medium:  0px 4px 16px rgba(15, 36, 80, 0.12)
Large:   0px 8px 24px rgba(15, 36, 80, 0.16)
```

---

## 🔟 CONSTRAINTS & RESPONSIVE

- **Page Horizontal Padding:** 16px
- **Card Padding:** 14-18px
- **Section Gap:** 10-14px
- **Icon Gap:** 6-12px
- **Grid Gap:** 10px

Set constraints on elements:
- Container: **Horizontal: Left & Right stretch**
- Cards: **Horizontal: Left & Right stretch**
- Grid items: **Fixed width/height**

---

## ✅ QUICK CHECKLIST

- [ ] 9 Color Styles created (Dark)
- [ ] 5 Color Styles created (Light)
- [ ] 5 Text Styles created
- [ ] Button component with 3 variants
- [ ] Glass Card component
- [ ] Gradient Card component
- [ ] Quick Actions Grid (4×2 tiles)
- [ ] Phone Frame 1080×2400px
- [ ] Home Screen layout inside frame
- [ ] 3 Onboarding screens
- [ ] All shadows applied
- [ ] All typography applied

---

## 🎬 NEXT STEPS

1. Open Figma
2. Create new file: "SecurePay Design System"
3. Follow each step above
4. Build components first, then layouts
5. Create "Dark" & "Light" pages for theme variants
6. Use component variants for button/card states
7. Document all components in a Design System page

**No JSON needed—just manual Figma building with copy-paste values!**

