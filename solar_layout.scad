// ═══════════════════════════════════════════════════════════════════
//  SOLAR PANEL LAYOUT  — West side safe zone (4.41m, clear of Velux)
//
//  Run:
//    openscad -o solar_layout.png --imgsize=2200,3700 \
//             --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//             solar_layout.scad
//
//  Named variation:
//    openscad -o path_a.png --imgsize=2200,3700 \
//             --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
//             configs/path_a.scad
// ═══════════════════════════════════════════════════════════════════

// ── ROOF ──────────────────────────────────────────────────────────
ROOF_W  = 4410;   // mm — safe zone width (left edge to Velux window)
ROOF_H  = 7190;   // mm — full height ridge to gutter
START_Y = 0;      // mm — first panel row starts here (set to 600 in configs)

// ── RAILS  (mm from bottom / eave) ────────────────────────────────
RAILS = [600, 1600, 2300, 3000, 3700, 4700, 5400, 6100];

// ── GAPS ──────────────────────────────────────────────────────────
GAP_X = 10;   // mm between columns
GAP_Y = 10;   // mm between panels within a column

// ── PANEL CATALOG  [portrait_w, portrait_h, wattage] ──────────────
//   0 : original test panel  440W  1134 × 1776
//   1 : Path B  standard modern    1134 × 1722  ~460W
//   2 : Path A  Trina/Longi class  1086 × 1808  ~440W
CATALOG = [
    [1134, 1776, 440],
    [1134, 1722, 460],
    [1086, 1808, 440],
];
SEL = 0;   // active panel index

// ── COLUMN ORIENTATIONS  0=portrait  1=landscape ──────────────────
//    Last entry repeats for any extra columns.
COLUMN_ORIENTATIONS = [1, 0];   // col 0 landscape, rest portrait

// ── COLUMN START OFFSET ───────────────────────────────────────────
//    Shifts the entire panel array right by this many mm.
//    Useful to close the gap between the last safe-zone column and window.
X_OFFSET = 0;

// ── SAFE ZONE BOUNDARY ────────────────────────────────────────────
//    Draws an orange vertical line at this x position (0 = off)
SAFE_ZONE_X = 0;

// ── OBSTACLES  [x, y, width, height] mm ───────────────────────────
//    Panels that overlap an obstacle are skipped.
//    Velux window (from roof plan drawing):
//      x=4410  y=2680  w=830  h=1010
//    Uncomment below when modelling full 7010mm roof width.
OBSTACLES = [];

// ── POLYGON OBSTACLES  [[[x,y],[x,y],...], ...] ───────────────────
//    Arbitrary polygon shapes (e.g. snow-shed/diagonal exclusion zones)
POLY_OBSTACLES = [];

// ── RULERS ────────────────────────────────────────────────────────
//    Show 1m tick marks on left and right edges of the roof
SHOW_RULERS = false;

// ── DISPLAY ───────────────────────────────────────────────────────
LABEL_SIZE   = 65;    // mm — text inside each panel
SUMMARY_SIZE = 120;   // mm — summary text above roof
BORDER       = 3;     // mm — roof outline stroke
RAIL_H       = 4;     // mm — visual rail line height


// ── COLORS ────────────────────────────────────────────────────────
COL_COLORS = [
    [0.25, 0.75, 0.25],   // col 0 : green
    [0.90, 0.70, 0.10],   // col 1 : amber
    [0.20, 0.55, 0.90],   // col 2 : blue
    [0.75, 0.30, 0.80],   // col 3 : purple
];
WARN_COLOR  = [0.90, 0.15, 0.15];   // red  — fewer than 2 rails crossing
ZONE_COLOR  = [0.82, 0.82, 0.82];   // gray — excluded zone below START_Y


// ═══════════════════════════════════════════════════════════════════
//  LAYOUT FUNCTIONS
// ═══════════════════════════════════════════════════════════════════

function ori(col) =
    COLUMN_ORIENTATIONS[min(col, len(COLUMN_ORIENTATIONS) - 1)];

function pw(col) = ori(col) == 1 ? CATALOG[SEL][1] : CATALOG[SEL][0];
function ph(col) = ori(col) == 1 ? CATALOG[SEL][0] : CATALOG[SEL][1];

// Available roof height above START_Y
function avail_h() = ROOF_H - START_Y;

function nrows(col) = floor((avail_h() + GAP_Y) / (ph(col) + GAP_Y));

function wattage() = CATALOG[SEL][2];

// Internal: zero-based column x without offset
function _col_x(col) =
    col == 0 ? 0 : _col_x(col - 1) + pw(col - 1) + GAP_X;

function col_x(col) = X_OFFSET + _col_x(col);

function ncols(col = 0) =
    col_x(col) + pw(col) > ROOF_W ? col : ncols(col + 1);

// Last column whose right edge falls within SAFE_ZONE_X (returns -1 if none)
function _last_safe(col, nc) =
    col >= nc ? nc - 1 :
    col_x(col) + pw(col) > SAFE_ZONE_X ? col - 1 :
    _last_safe(col + 1, nc);
function last_safe_col() = SAFE_ZONE_X > 0 ? _last_safe(0, ncols()) : -1;

function rail_count(py, panel_h) =
    len([for (r = RAILS) if (r >= py && r <= py + panel_h) r]);

// Point-in-polygon (ray casting)
function _pip(p, poly, i, j, inside, n) =
    i >= n ? inside :
    _pip(p, poly, i+1, i,
        ((poly[i][1] > p[1]) != (poly[j][1] > p[1]) &&
         p[0] < (poly[j][0]-poly[i][0]) * (p[1]-poly[i][1]) /
                (poly[j][1]-poly[i][1]) + poly[i][0])
        ? !inside : inside, n);
function point_in_poly(p, poly) =
    _pip(p, poly, 0, len(poly)-1, false, len(poly));

// Panel overlaps polygon if ANY of its 4 corners (with 1mm inset) is inside
function panel_in_poly(px, py, epw, eph, poly) =
    point_in_poly([px+1,        py+1],        poly) ||
    point_in_poly([px+epw-1,    py+1],        poly) ||
    point_in_poly([px+1,        py+eph-1],    poly) ||
    point_in_poly([px+epw-1,    py+eph-1],    poly);

function overlaps_obstacle(px, py, epw, eph) =
    (len([for (o = OBSTACLES)
         if (px < o[0]+o[2] && px+epw > o[0] &&
             py < o[1]+o[3] && py+eph > o[1]) o]) > 0)
    ||
    (len([for (poly = POLY_OBSTACLES)
         if (panel_in_poly(px, py, epw, eph, poly)) poly]) > 0);

function _vsum(v, i = 0) =
    i >= len(v) ? 0 : v[i] + _vsum(v, i + 1);

function total_panels() =
    let(nc = ncols())
    _vsum([for (col = [0:nc-1])
           _vsum([for (row = [0:nrows(col)-1])
                  overlaps_obstacle(col_x(col),
                                    START_Y + row*(ph(col)+GAP_Y),
                                    pw(col), ph(col)) ? 0 : 1])]);


// ═══════════════════════════════════════════════════════════════════
//  GEOMETRY MODULES
// ═══════════════════════════════════════════════════════════════════

module draw_roof() {
    // Outline
    color([0.2, 0.2, 0.2]) square([ROOF_W, ROOF_H]);
    color([1, 1, 1])
        translate([BORDER, BORDER])
        square([ROOF_W - 2*BORDER, ROOF_H - 2*BORDER]);
    // Excluded zone below START_Y (hatched gray)
    if (START_Y > 0) {
        color(ZONE_COLOR, 0.6)
            translate([BORDER, BORDER])
            square([ROOF_W - 2*BORDER, START_Y - BORDER]);
        // Label
        color([0.4, 0.4, 0.4])
            translate([ROOF_W/2, START_Y/2])
            text(str("no panels below ", START_Y/1000, "m"),
                 LABEL_SIZE * 0.8, halign="center", valign="center");
    }
}

module draw_rails() {
    color([0.1, 0.4, 0.9])
    for (r = RAILS)
        translate([0, r - RAIL_H/2])
        square([ROOF_W, RAIL_H]);
}

module draw_panel(x, y, w, h, col, rc) {
    c = rc >= 2 ? COL_COLORS[col % len(COL_COLORS)] : WARN_COLOR;
    translate([x, y]) {
        color([0.1, 0.1, 0.1]) square([w, h]);
        color(c, 0.82) translate([2, 2]) square([w - 4, h - 4]);
    }
}

module draw_label(x, y, w, h, col, row, ori_ch) {
    cx = x + w/2;
    cy = y + h/2;
    s  = LABEL_SIZE;
    color([0, 0, 0]) {
        translate([cx, cy + s*0.9])
            text(str("C", col, "R", row), s, halign="center", valign="center");
        translate([cx, cy])
            text(ori_ch, s, halign="center", valign="center");
        translate([cx, cy - s*1.2])
            text(str(wattage(), "W"), s, halign="center", valign="center");
    }
}

module draw_safe_zone(x) {
    if (x > 0 && x < ROOF_W) {
        color([0.9, 0.4, 0.0], 0.9)
            translate([x - 2, 0]) square([4, ROOF_H]);
        color([0.9, 0.4, 0.0])
            translate([x/2, ROOF_H - 180])
            text(str("safe zone  ", x/1000, "m"),
                 LABEL_SIZE * 0.8, halign="center");
    }
}

// Horizontal dimension annotation: line + tick marks + centred label
module draw_h_dim(x1, x2, y, label) {
    let(lo = min(x1, x2), hi = max(x1, x2), mid = (x1+x2)/2,
        ts = LABEL_SIZE * 0.75, th = ts * 1.6) {
        color([0.0, 0.55, 0.55]) {
            translate([lo, y])         square([hi - lo, 3]);
            translate([lo - 2, y - th/2]) square([4, th]);
            translate([hi - 2, y - th/2]) square([4, th]);
            translate([mid, y + th * 0.55])
                text(label, ts, halign="center", valign="bottom");
        }
    }
}

module draw_obstacle(obs) {
    ox=obs[0]; oy=obs[1]; ow=obs[2]; oh=obs[3];
    d = sqrt(ow*ow + oh*oh);
    color([0.9, 0.1, 0.1], 0.35) translate([ox, oy]) square([ow, oh]);
    color([0.7, 0.0, 0.0]) {
        translate([ox, oy])
            rotate([0, 0, atan2(oh, ow)]) square([d, 4]);
        translate([ox + ow, oy])
            rotate([0, 0, atan2(oh, -ow)]) square([d, 4]);
    }
}

module draw_poly_obstacle(poly) {
    color([0.9, 0.1, 0.1], 0.30) polygon(poly);
    // Outline
    color([0.7, 0.0, 0.0])
    for (i = [0:len(poly)-1]) {
        let(p1 = poly[i], p2 = poly[(i+1) % len(poly)],
            dx = p2[0]-p1[0], dy = p2[1]-p1[1],
            ln = sqrt(dx*dx + dy*dy),
            ang = atan2(dy, dx)) {
            translate(p1) rotate([0,0,ang]) translate([0, -2]) square([ln, 4]);
        }
    }
}

// Vertical ruler at given x with tick marks every 100mm and labels every 1m
module draw_ruler(x, label_offset) {
    color([0.2, 0.2, 0.2]) {
        for (y = [0 : 100 : ROOF_H]) {
            tw = (y % 1000 == 0) ? 80 : (y % 500 == 0) ? 50 : 25;
            translate([x - tw/2, y - 2]) square([tw, 4]);
        }
        for (y = [0 : 1000 : ROOF_H])
            translate([x + label_offset, y])
                text(str(y/1000, "m"), 70,
                     halign = label_offset < 0 ? "right" : "left",
                     valign = "center");
    }
}

module draw_summary(nc, total_p) {
    let(kWp   = total_p * wattage() / 1000,
        pw_mm = CATALOG[SEL][0],
        ph_mm = CATALOG[SEL][1],
        sy    = ROOF_H + 400) {
        color([0, 0, 0]) {
            translate([0, sy + SUMMARY_SIZE*3.2])
                text(str("Panels: ", total_p,
                         "   Power: ", kWp, " kWp   (",
                         wattage(), "W × ", total_p, ")"),
                     SUMMARY_SIZE);
            translate([0, sy + SUMMARY_SIZE*1.6])
                text(str("Panel: ", pw_mm, "×", ph_mm,
                         "mm portrait   (landscape: ",
                         ph_mm, "×", pw_mm, "mm)"),
                     SUMMARY_SIZE);
            translate([0, sy])
                text(str("Roof: ", ROOF_W, "×", ROOF_H,
                         "mm   Start: ", START_Y, "mm   Cols: ", nc,
                         "   Rows: ", nrows(0)),
                     SUMMARY_SIZE);
        }
    }
}


// ═══════════════════════════════════════════════════════════════════
//  MAIN RENDER
// ═══════════════════════════════════════════════════════════════════

nc      = ncols();
total_p = total_panels();

draw_roof();
draw_rails();
draw_safe_zone(SAFE_ZONE_X);

for (obs = OBSTACLES)
    draw_obstacle(obs);

for (poly = POLY_OBSTACLES)
    draw_poly_obstacle(poly);

if (SHOW_RULERS) {
    draw_ruler(-50, -100);
    draw_ruler(ROOF_W + 50, 100);
}

for (col = [0:nc-1]) {
    let(cx     = col_x(col),
        cw     = pw(col),
        ch     = ph(col),
        nr     = nrows(col),
        ori_ch = ori(col) == 1 ? "L" : "P")
    for (row = [0:nr-1]) {
        let(py = START_Y + row * (ch + GAP_Y),
            rc = rail_count(py, ch))
        if (!overlaps_obstacle(cx, py, cw, ch)) {
            draw_panel(cx, py, cw, ch, col, rc);
            draw_label(cx, py, cw, ch, col, row, ori_ch);
        }
    }
}

draw_summary(nc, total_p);

// ── DIMENSION ANNOTATIONS ─────────────────────────────────────────

// Left margin (when X_OFFSET > 0)
if (X_OFFSET > 5)
    draw_h_dim(0, X_OFFSET, START_Y / 2,
               str(X_OFFSET, "mm margin"));

// Gap from last safe-zone column to window boundary
if (SAFE_ZONE_X > 0) {
    let(lsc = last_safe_col()) {
        if (lsc >= 0) {
            let(edge = col_x(lsc) + pw(lsc),
                gap  = SAFE_ZONE_X - edge) {
                if (gap > 5)
                    draw_h_dim(edge, SAFE_ZONE_X,
                               START_Y + nrows(lsc) * (ph(lsc) + GAP_Y) / 2,
                               str(gap, "mm to window"));
            }
        }
    }
}

// Gap from window right edge to next column (when obstacle present)
if (len(OBSTACLES) > 0 && nc > 0) {
    let(win_right = OBSTACLES[0][0] + OBSTACLES[0][2],
        // first col whose left edge is >= win_right
        first_past = [for (c=[0:nc-1]) if(col_x(c) >= win_right) c]) {
        if (len(first_past) > 0) {
            let(c = first_past[0], gap = col_x(c) - win_right) {
                if (gap > 5)
                    draw_h_dim(win_right, col_x(c),
                               OBSTACLES[0][1] + OBSTACLES[0][3] / 2,
                               str(gap, "mm"));
            }
        }
    }
}

// Right unused space (last col to roof edge)
if (nc > 0) {
    let(last_right = col_x(nc-1) + pw(nc-1),
        right_gap  = ROOF_W - last_right) {
        if (right_gap > 30)
            draw_h_dim(last_right, ROOF_W,
                       START_Y / 2,
                       str(right_gap, "mm unused"));
    }
}
