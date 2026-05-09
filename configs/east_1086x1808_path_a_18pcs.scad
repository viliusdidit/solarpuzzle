// EAST 7010mm — Path A "Silver Bullet" full layout
// 1086×1808mm 440W, all portrait, 6 cols × 3 rows = 18 panels
// 18 × 440W = 7.92 kWp
//
// Total system (paired with west 11pcs) = 29 panels × 440W = 12.76 kWp
// DC/AC ratio with SMA STP 10.0 = 1.28 ✅ safe

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 2;
START_Y             = 600;
COLUMN_ORIENTATIONS = [0];
OBSTACLES           = [];
SAFE_ZONE_X         = 0;
