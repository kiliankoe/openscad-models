pipe_inner_d = 18;
pipe_height = 20;

funnel_height = 40;

fan_height = 15;
fan_width = 62;
fan_length = 62;

wall_strength = 4;
base_margin = 30;
base_height = 3;
hole_margin = 5;
hole_d = 5;

$fn = 100;

module body() {
  hull() {
    cube(size = [fan_width, fan_length, fan_height], center = true);

    translate([0, 0, fan_height + funnel_height])
      cylinder(h = 0.1, d = pipe_inner_d);
  }

  translate([0, 0, fan_height + funnel_height])
    cylinder(h = pipe_height, d = pipe_inner_d);
}

difference() {
  union() {
    scale([1.2, 1.2, 1])
      body();

    // base plate
    translate([0, 0, -fan_height / 2 + base_height / 2])
      cube([fan_width + base_margin, fan_length + base_margin, base_height], center = true);
  }

  body();

  // screw holes
  x_values = [fan_width / 2 + base_margin / 2 - hole_margin, -fan_width / 2 - base_margin / 2 + hole_margin];
  y_values = [fan_length / 2 + base_margin / 2 - hole_margin, -fan_length / 2 - base_margin / 2 + hole_margin];
  for (x = x_values, y = y_values) {
    translate([x, y, -fan_height / 2 + base_height / 2])
      cylinder(h = base_height, d = hole_d, center = true);
  }
}
