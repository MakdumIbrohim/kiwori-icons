# Kiwori Design System

Design guidelines to maintain visual cohesion and quality across all icons in the **Kiwori** theme.

---

## 1. Core Principles

> **Recognizable, Playful, Colorful, Consistent.**

* **Recognizable**: Every application must preserve its essential brand identity and core motifs (Firefox must look like Firefox, Spotify must look like Spotify).
* **Playful**: Lighthearted, friendly cartoon and sticker-inspired aesthetic.
* **Colorful**: Expressive pastel backgrounds combined with punchy saturated focal accents.
* **Consistent**: Shared shape language, uniform outline weights, aligned corner radii, and balanced visual mass across all categories.

---

## 2. Canvas & Grid Metrics

* **Format**: Pure vector SVG (Scalable Vector Graphics).
* **Master Artboard**: `256 × 256` px.
* **Mandatory ViewBox**: `viewBox="0 0 256 256"`.
* **Safe Zone / Padding**: 16 px border inset (224 × 224 px active drawing area).

---

## 3. Outline System

A thick, bold dark outline is a cornerstone of the Kiwori visual identity.

* **Outline Color**: `#171717` (Kiwori Black).
* **Outer Silhouette Stroke**: `14px` (or `16px` for primary container card borders).
* **Inner Structural Stroke**: `8px` to `12px` for interior division lines.
* **Line Caps**: `stroke-linecap="round"`.
* **Line Joins**: `stroke-linejoin="round"`.
* **Scaling Behavior**: Do not use `vector-effect: non-scaling-stroke`; strokes must scale proportionally with icon dimensions.

---

## 4. Shape Language

Construct icons using friendly, soft geometric primitives:
* Rounded rectangles / squircles (Reference Corner Radius: `54px` – `58px` on a 256px card).
* Circles and rounded ellipses.
* Smooth organic shapes with generous curvature.

**Prohibited**:
* Razor-sharp corners (< 90° without a fillet/radius).
* Hyper-detailed micro elements that vanish or blur at 16–24px.
* Realistic textures or heavy skeuomorphism.

---

## 5. Official Color Palette

Reference baseline color palette:

| Color Name    | Hex Code  | Primary Usage |
| ------------- | --------- | ------------- |
| Kiwori Black  | `#171717` | Outlines, contours, glyph lines |
| Soft White    | `#FFFFFF` | Sticker card bases, highlights |
| Pastel Pink   | `#FF8FB1` | Social, entertainment, multimedia accents |
| Pastel Purple | `#B982FF` | Creative tools, developer utilities |
| Pastel Blue   | `#65C7FF` | Core system tools, web browsers, default folders |
| Pastel Cyan   | `#5ED8D2` | Messaging, network, transfer utilities |
| Pastel Green  | `#73D69A` | Audio, productivity, success states |
| Pastel Yellow | `#FFE477` | Standard folders, warnings, archives |
| Pastel Orange | `#FFAA6B` | Graphics, warnings, warm UI accents |
| Pastel Red    | `#FF6B6B` | Error states, recording media, delete actions |

*Third-party application icons should adapt their official brand hues to fit the Kiwori pastel balance and bold outline aesthetic.*

---

## 6. Technical SVG Requirements

All SVG source files must be clean, lightweight, and valid:
1. Strip proprietary editor namespaces (e.g. Inkscape/Sodipodi metadata).
2. Embedded raster images (base64 PNG/JPEG) are strictly prohibited.
3. External file references (`href="file://..."`) are strictly prohibited.
4. Minimal SVG root element:
   ```xml
   <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="256" height="256">
     <!-- Vector paths and shapes -->
   </svg>
   ```
