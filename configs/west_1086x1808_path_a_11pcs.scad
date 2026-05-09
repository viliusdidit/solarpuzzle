// WEST 6500mm — Path A reduced layout (keep SMA STP 10.0)
// 1086×1808mm 440W, all portrait, 4 cols × 3 rows − 1 window = 11 panels
// 11 × 440W = 4.84 kWp
//
// Pair with east_1086x1808_path_a_18pcs.scad → 29 total = 12.76 kWp
// DC/AC ratio with STP 10.0 = 1.28 ✅ safe for post-warranty

include <../solar_layout.scad>

ROOF_W              = 6500;
SEL                 = 2;         // 1086×1808 440W
START_Y             = 600;       // align with 0.6m rail
COLUMN_ORIENTATIONS = [0];
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
