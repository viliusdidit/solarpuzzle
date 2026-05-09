// EAST SIDE — 7010mm wide, mirrored Velux window
// Window at x=1770mm (mirrored from west: 7010 - 4410 - 830 = 1770)
// 1134×1722mm ~460W, all portrait
// 6 cols × 4 rows − 2 window = 22 panels × 460W = 10.12 kWp
//
// Run:
//   openscad -o east_1134x1722_24pcs.png --imgsize=3000,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/east_1134x1722_24pcs.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 1;
START_Y             = 230;
COLUMN_ORIENTATIONS = [0];
OBSTACLES           = [[1770, 2680, 830, 1010]];   // mirrored Velux
SAFE_ZONE_X         = 2600;                         // safe zone right of window
SHOW_RULERS         = true;
