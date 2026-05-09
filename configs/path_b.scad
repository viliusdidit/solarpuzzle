// PATH B — "Symmetrical Tetris"
// Standard modern panel  1722×1134mm  ~460W
// Col 0: landscape (1722mm wide, 1134mm tall) — 5 rows
// Cols 1-2: portrait (1134mm wide, 1722mm tall) — 3 rows each
// Width: 1722 + 2×1134 + 2×10 = 4010mm  ✓ within 4410mm safe zone
// Col 0 height: 5×1134 + 4×10 = 5710mm  start 600mm → top 6310mm  ✓
// Col 1-2 height: 3×1722 + 2×10 = 5186mm  start 600mm → top 5786mm  ✓
// NOTE: Col 0 landscape panels need vertical cross-rail or point anchors
//       (existing horizontal rails are portrait-spaced, not landscape-spaced)
// Run: openscad -o path_b.png --imgsize=2200,3700 \
//      --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//      configs/path_b.scad

include <../solar_layout.scad>

SEL                 = 1;         // 1134×1722mm 460W
START_Y             = 600;       // must start at 0.6m rail
COLUMN_ORIENTATIONS = [1, 0];    // col 0 landscape, rest portrait
