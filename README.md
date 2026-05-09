# solarpuzzle

Tools for laying out solar panels on a two-sided pitched roof.

- **`planner.html`** — single-file browser app. Open it locally to draw rails,
  rectangular and polygonal obstacles (e.g. Velux windows), set per-column
  panel orientation (portrait/landscape), and live-preview panel counts and kWp
  for both east and west sides simultaneously. Round-trips with the SCAD
  format (upload an existing layout, edit, export).
- **`solar_layout.scad`** — OpenSCAD 2D panel-layout generator. Drives the
  rendered PNGs via the OpenSCAD CLI.
- **`configs/*.scad`** — per-variation configs that `include` the base layout
  and reassign variables (last-wins).

## Render a SCAD config

```sh
openscad -o out.png --imgsize=2200,3700 \
         --camera=0,0,0,0,0,0,1 --projection=ortho --viewall --autocenter \
         configs/path_a.scad
```

## License

MIT — see [LICENSE](LICENSE).
