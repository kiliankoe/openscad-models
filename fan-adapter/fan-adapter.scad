pipe_inner_d = 18;
pipe_height = 20;

funnel_height = 40;

fan_height = 15;
fan_width = 62;
fan_length = 62;

wall_strength = 4;
base_margin = 30;
base_height = 3;
base_chamfer = 5;
hole_margin = 6;
hole_d = 5;

$fn = 15;

include <../BOSL2/std.scad>

module chamfered_cube(size, should_chamfer = true, chamfer_r) {
  difference() {
    cube(size, center = true);

    if (should_chamfer) {
      translate([-size.x / 2, -size.y / 2, -size.z / 2])
        rounding_edge_mask(l = size.z, r = chamfer_r, orient = UP, anchor = BOTTOM);
      translate([size.x / 2, -size.y / 2, -size.z / 2])
        rotate([0,0,90])
          rounding_edge_mask(l = size.z, r = chamfer_r, orient = UP, anchor = BOTTOM);
      translate([size.x / 2, size.y / 2, -size.z / 2])
        rotate([0,0,180])
          rounding_edge_mask(l = size.z, r = chamfer_r, orient = UP, anchor = BOTTOM);
      translate([-size.x / 2, size.y / 2, -size.z / 2])
        rotate([0,0,270])
          rounding_edge_mask(l = size.z, r = chamfer_r, orient = UP, anchor = BOTTOM);
    }
  }
}

module body(should_chamfer) {
  hull() {
    chamfered_cube([fan_width, fan_length, fan_height], should_chamfer = should_chamfer, chamfer_r = 5);

    translate([0, 0, fan_height + funnel_height])
      cylinder(h = 0.1, d = pipe_inner_d);
  }

  translate([0, 0, fan_height + funnel_height])
    cylinder(h = pipe_height, d = pipe_inner_d);
}

difference() {
  union() {
    scale([1.2, 1.2, 1])
      body(should_chamfer = true);

    // base plate
    translate([0, 0, -fan_height / 2 + base_height / 2])
    chamfered_cube([fan_width + base_margin, fan_length + base_margin, base_height], chamfer_r = base_chamfer);
  }

  // the inner cutout should not be chamfered as we want straight
  // edges on the fan cutout.
  body(should_chamfer = false);

  // screw holes
  x_values = [fan_width / 2 + base_margin / 2 - hole_margin, -fan_width / 2 - base_margin / 2 + hole_margin];
  y_values = [fan_length / 2 + base_margin / 2 - hole_margin, -fan_length / 2 - base_margin / 2 + hole_margin];
  for (x = x_values, y = y_values) {
    translate([x, y, -fan_height / 2 + base_height / 2])
      cylinder(h = base_height, d = hole_d, center = true);
  }
}
