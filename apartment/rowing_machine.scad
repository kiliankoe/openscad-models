base_length = 250;
base_width = 31;
base_height = 14;

seat_width = base_width;
seat_length = 23;
seat_height = 16;

drum_height = 18.5;
drum_d = 55;

module foot_rest() {
  foot_rest_width = 26;
  hull() {
    cube([foot_rest_width, 36, 2.5]);

    translate([foot_rest_width / 2 - 11.5 / 2, 54, 0])
      cube([11.5, 2, 2.5]);
  }
}

difference() {
  cube([base_width, base_length, base_height]);

  translate([3.5, 0, 3.51])
    cube([base_width - 7, base_length, base_height - 3.5]);
}

translate([0, 100, base_height])
  cube([seat_width, seat_length, seat_height]);

translate([base_width / 2, 200, base_height])
  cylinder(h=drum_height, d=drum_d, $fn=80);

translate([base_width / 2 - 11.5 / 2, base_length - 11.5, 0])
  cube([11.5, 11.5, 49]);

top_length = 53;

union() {
  translate([base_width / 2 - 11.5 / 2, base_length - 11.5 - top_length, 32.5])
    cube([11.5, top_length, 13]);

  translate([base_width / 2 - 26 / 2, 140, base_height - 2])
    rotate([33, 0, 0])
      foot_rest();
}

translate([base_width / 2 - 39 / 2, 178, 40])
  rotate([0, 90, 0])
    cylinder(h = 39, d = 4, $fn = 20);
