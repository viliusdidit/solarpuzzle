// PATH A — "Silver Bullet"
// Trina Vertex S+ / Longi Hi-MO 6 class  1808×1086mm  ~440W
// 4 cols portrait  ×  3 rows  =  12 panels  (west safe zone)
// Width: 4×1086 + 3×10 = 4374mm  ✓ within 4410mm safe zone
// Height: 3×1808 + 2×10 = 5444mm  starting at 600mm → top at 6044mm  ✓
// Rails: each row spans 1808mm — hits 2 rails cleanly (no warnings expected)
// Run: openscad -o path_a.png --imgsize=2200,3700 \
//      --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//      configs/path_a.scad

include <../solar_layout.scad>

SEL                 = 2;         // 1086×1808mm 440W
START_Y             = 600;       // must start at 0.6m rail
COLUMN_ORIENTATIONS = [0];       // all portrait
