leg_length = 5;
leg_width = 8;
leg_height = 71;

foot_length = 7;
foot_width = 75;
foot_height = 3;

base_length = 160;
base_width = 18;
base_height = 6;

plate_height = 2;

length = base_length;
width = 80;
height = foot_height + leg_height + base_height + plate_height;

module leg() {
  cube([foot_length, foot_width, foot_height]);

  translate([(foot_length - leg_length) / 2, foot_width / 2 - leg_width / 2, foot_height])
  cube([leg_length, leg_width, leg_height]);
}

module base() {
  translate([0, width / 2 - foot_width / 2, 0])
  leg();

  translate([length - foot_length, width / 2 - foot_width / 2, 0])
    leg();

  translate([0, width / 2 - base_width / 2, foot_height + leg_height])
    cube([base_length, base_width, base_height]);
}

translate([0, 0, height - plate_height])
  cube([length, width, plate_height]);

base();
