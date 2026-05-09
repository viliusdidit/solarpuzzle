// Full roof — both sides, Path A panels, Velux window as obstacle
// Total width 7010mm, window at x=4410 y=2680 w=830 h=1010
// Run: openscad -o full_roof_path_a.png --imgsize=3000,3700 \
//      --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//      configs/full_roof_path_a.scad

include <../solar_layout.scad>

ROOF_W              = 7010;
SEL                 = 2;         // 1086×1808mm 440W
START_Y             = 200;
COLUMN_ORIENTATIONS = [0];       // all portrait
OBSTACLES           = [[4410, 2680, 830, 1010]];
SAFE_ZONE_X         = 4410;
