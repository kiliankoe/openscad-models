plate_length = 110;
plate_width = 80;
plate_height = 4.5;

sub_length = 98.5;
sub_width = 68.5;
sub_height = 10.6;

leg_length = 73.8;
leg_width = 6;

translate([0, 0, leg_length])
  cube([plate_length, plate_width, plate_height]);

translate([
  plate_length / 2 - sub_length / 2,
  plate_width / 2 - sub_width / 2,
  leg_length - sub_height
])
cube([sub_length, sub_width, sub_height]);

x_values = [(plate_length - sub_length) / 2, (plate_length - sub_length) / 2 + sub_length - leg_width];
y_values = [(plate_width - sub_width) / 2, (plate_width - sub_width) / 2 + sub_width - leg_width];

for (x = x_values, y = y_values) {
  translate([x, y, 0])
  cube([leg_width, leg_width, leg_length]);
}
