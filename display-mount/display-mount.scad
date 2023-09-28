case_width = 80;
case_length = 36;
case_height = 35;
case_rounding = 2;

wall_thickness = 5;

base_margin = 6;
base_height = 3;
base_fillet_r = 2;
hole_margin = 1;
hole_d = 4;

display_width = 45;
display_height = 27;

switch_d = 20;

side_cutout_width = 10;
side_cutout_height = 10;

top_wall_thickness = 13;

$fn = 50;

include <../BOSL2/std.scad>

module case(should_round) {
  translate([0, 0, case_height / 2])
    if (should_round) {
      cuboid([case_width, case_length, case_height], rounding = case_rounding, except_edges = [BOTTOM]);
    } else {
      cube([case_width, case_length, case_height], center = true);
    }
}

module cover() {
  difference() {
    case(should_round = true);
    translate([0, 0, -top_wall_thickness])
      scale([0.9, 0.9, 1])
        case();

    translate([0, 0, base_height + side_cutout_height / 2])
      cube([case_width, side_cutout_width, side_cutout_height], true);

    translate([12, 0, case_height - top_wall_thickness / 2])
      cube([display_width, display_height, top_wall_thickness], true);

    translate([-25, 0, case_height - top_wall_thickness / 2])
      cylinder(d=switch_d, h=top_wall_thickness, center = true);
  }
}

module base_plate() {
  difference() {
    translate([0, 0, base_height / 2])
      cuboid(
        [
          case_width + wall_thickness + base_margin,
          case_length + wall_thickness + base_margin,
          base_height
        ],
        rounding = base_fillet_r,
        except_edges = [TOP, BOTTOM]
      );

    translate([0, 0, base_height / 2])
      cube([case_width * 0.9, case_length * 0.9, base_height], center = true);

    // screw holes
    x_values = [
      case_width / 2 + base_margin / 2 - hole_margin,
      -case_width / 2 - base_margin / 2 + hole_margin
    ];
    y_values = [
      case_length / 2 + base_margin / 2 - hole_margin,
      -case_length / 2 - base_margin / 2 + hole_margin
    ];
    for (x = x_values, y = y_values) {
      translate([x, y, base_height / 2])
        cylinder(h = base_height, d = hole_d, center = true);
    }
  }
}

union() {
  cover();
  base_plate();
}
