pipe_inner_d = 19.5;
pipe_height = 20;

funnel_height = 20;
funnel_wall_factor = 1.2;

fan_outer_fillet_r = 3;
fan_height = 15;
fan_width = 61;
fan_length = 61;

base_margin = 30;
base_height = 3;
base_fillet_r = 5;
hole_margin = 6;
hole_d = 5;

$fn = 60;

include <../BOSL2/std.scad>

module body(should_fillet) {
  hull() {
    if (should_fillet) {
      cuboid(
        [fan_width, fan_length, fan_height], 
        rounding = fan_outer_fillet_r,
        edges = [FRONT+RIGHT, RIGHT+BACK, BACK+LEFT, LEFT+FRONT]
      );
    } else {
      cube([fan_width, fan_length, fan_height], center = true);
    }

    translate([0, 0, fan_height + funnel_height])
      cylinder(h = 0.1, d = pipe_inner_d);
  }

  translate([0, 0, fan_height + funnel_height])
    cylinder(h = pipe_height, d = pipe_inner_d);
}

difference() {
  union() {
    scale([funnel_wall_factor, funnel_wall_factor, 1])
      body(should_fillet = true);

    // base plate
    translate([0, 0, -fan_height / 2 + base_height / 2])
      cuboid(
        [fan_width + base_margin, fan_length + base_margin, base_height], 
        rounding = base_fillet_r,
        edges = [FRONT+RIGHT, RIGHT+BACK, BACK+LEFT, LEFT+FRONT]
      );
  }

  // the inner cutout should not be filleted as we want straight
  // edges on the fan cutout.
  body(should_fillet = false);

  // screw holes
  x_values = [
    fan_width / 2 + base_margin / 2 - hole_margin, 
    -fan_width / 2 - base_margin / 2 + hole_margin
  ];
  y_values = [
    fan_length / 2 + base_margin / 2 - hole_margin, 
    -fan_length / 2 - base_margin / 2 + hole_margin
  ];
  for (x = x_values, y = y_values) {
    translate([x, y, -fan_height / 2 + base_height / 2])
      cylinder(h = base_height, d = hole_d, center = true);
  }
}
