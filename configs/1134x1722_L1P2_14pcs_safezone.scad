// 1134×1722mm  ~460W
// Safe zone only (0–4410mm, where rails exist)
// Col 0 landscape (1722×1134mm) — 6 rows, WARNING: existing rails spaced for
//   portrait so rows R0 R2 R4 R5 only catch 1 rail (needs cross-rail or clamps)
// Cols 1-2 portrait (1134×1722mm) — 4 rows, all rail-compliant (green)
// Width: 1722 + 2×1134 + 2×10 = 4010mm  ✓ < 4410mm
// Height: 200 + 6×1134 + 5×10 = 7054mm  ✓ < 7190mm  (portrait: 7118mm)
// Total: 6 + 4 + 4 = 14 panels × 460W = 6.44 kWp
//
// Run:
//   openscad -o 1134x1722_L1P2_14pcs_safezone.png --imgsize=2200,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1134x1722_L1P2_14pcs_safezone.scad

include <../solar_layout.scad>

SEL                 = 1;         // 1134×1722mm  460W
START_Y             = 200;
COLUMN_ORIENTATIONS = [1, 0];    // col 0 landscape, rest portrait
OBSTACLES           = [];
SAFE_ZONE_X         = 0;
