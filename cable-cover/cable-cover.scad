case_width = 50;
case_length = 50;
case_height = 15;
case_rounding = 3;

wall_thickness = 5;

base_margin = 12;
base_height = 3;
base_fillet_r = 4;
hole_margin = 1.8;
hole_d = 4;

cutout_width = 15;
cutout_height = 8;

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
    scale([1.1, 1.1, 1.1])
      case(should_round = true);
    case();

    translate([
      - case_width / 2 + cutout_width / 2 + case_rounding,
      - case_length / 2,
      cutout_height / 2 + base_height
    ])
    #cube([cutout_width, 5, cutout_height], center = true);
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
      cube([case_width, case_length, base_height], center = true);

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
