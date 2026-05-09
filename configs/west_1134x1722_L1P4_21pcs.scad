// WEST SIDE — 6500mm wide with Velux window
// 1134×1722mm ~460W, X_OFFSET=200, START_Y=230
// Col 0 landscape + cols 1-4 portrait, shifted 200mm right
// Window blocks only 1 panel (col 3 R1)
// Total: 6L + 4×4P − 1 = 21 panels × 460W = 9.66 kWp
//
// Run:
//   openscad -o west_1134x1722_L1P4_21pcs.png --imgsize=2800,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/west_1134x1722_L1P4_21pcs.scad

include <../solar_layout.scad>

ROOF_W              = 6500;
SEL                 = 1;
START_Y             = 230;
X_OFFSET            = 200;
COLUMN_ORIENTATIONS = [1, 0];
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
SHOW_RULERS         = true;
