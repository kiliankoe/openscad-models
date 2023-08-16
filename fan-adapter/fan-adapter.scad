pipe_inner_d = 19.5;
pipe_height = 20;

funnel_height = 40;
body_fillet_r = 5;

fan_height = 15;
fan_width = 61;
fan_length = 61;

base_margin = 30;
base_height = 3;
base_fillet_r = 5;
hole_margin = 6;
hole_d = 5;

$fn = 30;

include <../BOSL2/std.scad>

module filleted_cube(size, should_fillet = true, fillet_r) {
  difference() {
    cube(size, center = true);

    if (should_fillet) {
      translate([-size.x / 2, -size.y / 2, -size.z / 2])
        rounding_edge_mask(l = size.z, r = fillet_r, orient = UP, anchor = BOTTOM);
      translate([size.x / 2, -size.y / 2, -size.z / 2])
        rotate([0,0,90])
          rounding_edge_mask(l = size.z, r = fillet_r, orient = UP, anchor = BOTTOM);
      translate([size.x / 2, size.y / 2, -size.z / 2])
        rotate([0,0,180])
          rounding_edge_mask(l = size.z, r = fillet_r, orient = UP, anchor = BOTTOM);
      translate([-size.x / 2, size.y / 2, -size.z / 2])
        rotate([0,0,270])
          rounding_edge_mask(l = size.z, r = fillet_r, orient = UP, anchor = BOTTOM);
    }
  }
}

module body(should_fillet) {
  hull() {
    filleted_cube([fan_width, fan_length, fan_height], should_fillet = should_fillet, fillet_r = body_fillet_r);

    translate([0, 0, fan_height + funnel_height])
      cylinder(h = 0.1, d = pipe_inner_d);
  }

  translate([0, 0, fan_height + funnel_height])
    cylinder(h = pipe_height, d = pipe_inner_d);
}

difference() {
  union() {
    scale([1.2, 1.2, 1])
      body(should_fillet = true);

    // base plate
    translate([0, 0, -fan_height / 2 + base_height / 2])
      filleted_cube([fan_width + base_margin, fan_length + base_margin, base_height], fillet_r = base_fillet_r);
  }

  // the inner cutout should not be filleted as we want straight
  // edges on the fan cutout.
  body(should_fillet = false);

  // screw holes
  x_values = [fan_width / 2 + base_margin / 2 - hole_margin, -fan_width / 2 - base_margin / 2 + hole_margin];
  y_values = [fan_length / 2 + base_margin / 2 - hole_margin, -fan_length / 2 - base_margin / 2 + hole_margin];
  for (x = x_values, y = y_values) {
    translate([x, y, -fan_height / 2 + base_height / 2])
      cylinder(h = base_height, d = hole_d, center = true);
  }
}
