// 1134×1722mm ~460W — full roof, landscape col 0, portrait cols 1-4
// START_Y=230: R3 portrait only catches 6100mm (1 rail, top row red)
//              window blocks col3+col4 row 1 only → 2 panels lost
// 6L + 4×4P − 2 = 20 panels × 460W = 9.20 kWp
// Width: 1722 + 4×1134 + 4×10 = 6298mm  ✓ < 7010mm
//
// Run:
//   openscad -o 1134x1722_L1P4_20pcs_fullroof.png --imgsize=3000,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1134x1722_L1P4_20pcs_fullroof.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 1;
START_Y             = 230;
COLUMN_ORIENTATIONS = [1, 0];
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
