// 1134×1722mm ~460W — full roof, landscape col 0, portrait cols 1-4
// START_Y=200: R3 portrait catches 5400+6100mm (2 rails, all green)
//              window blocks col3+col4 rows 1+2 → 4 panels lost
// 6L + 4×4P − 4 = 18 panels × 460W = 8.28 kWp
// Width: 1722 + 4×1134 + 4×10 = 6298mm  ✓ < 7010mm
//
// Run:
//   openscad -o 1134x1722_L1P4_18pcs_r3ok_fullroof.png --imgsize=3000,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1134x1722_L1P4_18pcs_r3ok_fullroof.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 1;
START_Y             = 200;
COLUMN_ORIENTATIONS = [1, 0];
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
