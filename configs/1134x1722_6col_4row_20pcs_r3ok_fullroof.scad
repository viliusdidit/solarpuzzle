// 1134×1722mm portrait ~460W — rail-compliant variant
// START_Y=200: R3 catches rails at 5400+6100mm (2 rails, green)
// 4 panels blocked by Velux (col3+col4 rows 1+2 all clip window)
// 20 panels × 460W = 9.20 kWp
//
// Run:
//   openscad -o 1134x1722_6col_4row_20pcs_r3ok_fullroof.png --imgsize=3000,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1134x1722_6col_4row_20pcs_r3ok_fullroof.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 1;
START_Y             = 200;
COLUMN_ORIENTATIONS = [0];
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
