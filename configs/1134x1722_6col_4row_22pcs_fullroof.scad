// 1134×1722mm portrait  ~460W
// Full roof 7010mm, 6 columns × 4 rows = 24 − 1 window = 23 panels
// START_Y=230: row 2 clears Velux top (3690mm) by 4mm — only 1 panel lost
// Width:  6×1134 + 5×10 = 6854mm  ✓ < 7010mm
// Height: 230 + 4×1722 + 3×10 = 7148mm  ✓ < 7190mm  (42mm margin)
// Power:  23 × 460W = 10.58 kWp
//
// Run:
//   openscad -o 1134x1722_6col_4row_23pcs_fullroof.png --imgsize=3000,3700 \
//            --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//            configs/1134x1722_6col_4row_23pcs_fullroof.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 1;         // 1134×1722mm 460W
START_Y             = 230;       // clears window overlap on row 2
COLUMN_ORIENTATIONS = [0];       // all portrait
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
