// 1134×1722mm ~460W — full roof, X_OFFSET=400mm
// Col 0 landscape + cols 1-4 portrait, shifted 400mm right
// Col 2 right edge now at exactly 4410mm (flush with window)
// START_Y=230: R3 only catches 6100mm rail (top row red) but maximises panels
// 6L + 4×4P − 2 window = 20 panels × 460W = 9.20 kWp
//
// Run:
//   openscad -o 1134x1722_L1P4_20pcs_xoff400_fullroof.png --imgsize=3000,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1134x1722_L1P4_20pcs_xoff400_fullroof.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 1;
START_Y             = 230;
X_OFFSET            = 400;
COLUMN_ORIENTATIONS = [1, 0];
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
