// 1086×1808mm  ~440W
// Col 0 landscape (1808×1086mm) — 6 rows, 4 of 6 WARN (rails spaced for portrait)
// Cols 1-2 portrait (1086×1808mm) — 3 rows each, all OK
// Width: 1808 + 2×1086 + 2×10 = 4000mm  ✓ < 4410mm
// Total: 6+3+3 = 12 panels × 440W = 5.28 kWp  (same as all-portrait Path A)
//
// Run:
//   openscad -o 1086x1808_L1P2_12pcs_safezone.png --imgsize=2200,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1086x1808_L1P2_12pcs_safezone.scad

include <../solar_layout.scad>

SEL                 = 2;         // 1086×1808mm  440W
START_Y             = 200;
COLUMN_ORIENTATIONS = [1, 0];
OBSTACLES           = [];
SAFE_ZONE_X         = 0;
