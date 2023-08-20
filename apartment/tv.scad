cabinet_length = 149;
cabinet_height = 44;
cabinet_depth = 36;

cabinet_foot_height = 10;
// original val = 2, 3 for better printability
cabinet_foot_width = 3;

tv_foot_width = 51;
tv_foot_depth = 25;
tv_foot_height = 1.5;

tv_middle_width = tv_foot_width;
tv_middle_depth = 2;
tv_middle_height = 2;

tv_width = 123;
tv_depth = 4;
tv_height = 74;

module cabinet() {
  translate([0, 0, cabinet_foot_height])
    cube([cabinet_length, cabinet_depth, cabinet_height]);

  for (i = [0 : (cabinet_length - cabinet_foot_width) / 3 : (cabinet_length - cabinet_foot_width)]) {
    translate([i, 0, 0]) {
      cube([cabinet_foot_width, cabinet_foot_width, cabinet_foot_height]);
      translate([0, cabinet_depth - cabinet_foot_width, 0])
        cube([cabinet_foot_width, cabinet_foot_width, cabinet_foot_height]);
    }
  }
}

module tv() {
  translate([tv_width / 2, tv_foot_depth / 2, tv_foot_height / 2]) {
    cube([tv_foot_width, tv_foot_depth, tv_foot_height], center = true);

    translate([0, 0, tv_foot_height / 2 + tv_middle_height / 2]) {
      cube([tv_middle_width, tv_middle_depth, tv_middle_height], center = true);

      translate([0, 0, tv_middle_height / 2 + tv_height / 2]) {
        cube([tv_width, tv_depth, tv_height], center = true);
      }
    }
  }
}

cabinet();

translate([cabinet_length / 2 - tv_width / 2, cabinet_depth / 2 - tv_foot_depth / 2, cabinet_height + cabinet_foot_height])
  tv();
