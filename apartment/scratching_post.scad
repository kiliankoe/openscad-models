base_d = 44;

body_d = 28;
body_seg_lg_h = 80.5;
body_seg_sm_h = 40.5;

plate_h = 1.7;
bed_d = 43.5;

bed_plate_offset = 40;

lower_bed_angle = 0;
upper_bed_angle = 90;

bed_r_maj = 18;
bed_r_min = 5.5;
bed_h_offset = bed_r_min * 0.8;

$fn = 80;

include <../BOSL2/std.scad>

module bed_ring() {
  torus(r_maj = bed_r_maj, r_min = bed_r_min);
}

module bed_plate() {
  hull() {
    cylinder(h = plate_h, d = body_d);

    translate([bed_plate_offset,0,0])
      cylinder(h = plate_h, d = bed_d);
  }
  translate([bed_plate_offset,0,plate_h + bed_h_offset])
    bed_ring();
}

cylinder(h = plate_h, d = base_d);

translate([0,0,plate_h]) {
  cylinder(h=body_seg_lg_h, d=body_d);

  translate([0,0,body_seg_lg_h]) {
    rotate([0, 0, lower_bed_angle])
      bed_plate();

    translate([0,0,plate_h]) {
      cylinder(h=body_seg_lg_h, d=body_d);

      translate([0, 0, body_seg_lg_h]) {
        rotate([0, 0, upper_bed_angle])
          bed_plate();

        translate([0, 0, plate_h]) {
          cylinder(h=body_seg_sm_h, d=body_d);

          translate([0, 0, body_seg_sm_h]) {
            cylinder(h = plate_h, d = base_d);

            translate([0, 0, plate_h + bed_h_offset]) {
              bed_ring();
            }
          }
        }
      }
    }
  }
}
