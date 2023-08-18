table_width = 60;
table_length = 106;
table_height = 45;

plate_height = 1.5;
leg_width = 4;

bottom_offset = 21;

module leg() {
  difference() {
    cube([leg_width, leg_width, table_height - 2*plate_height]);
    translate([leg_width / 3, leg_width / 3, 0])
      cube([leg_width, leg_width, table_height - 2*plate_height]);
  }
}

translate([0, 0, table_height - 2*plate_height])
  cube([table_width, table_length, 2*plate_height]);

translate([0, 0, bottom_offset])
  cube([table_width, table_length, plate_height]);

leg();

translate([table_width, 0, 0])
  rotate([0, 0, 90])
    leg();

translate([table_width, table_length, 0])
  rotate([0, 0, 180])
    leg();

translate([0, table_length, 0])
  rotate([0, 0, 270])
    leg();
