width = 54;
depth = 47;
height = 99;

difference() {
  cube([width, depth, height]);

  values = [7:2:92];
  for(v = values) {
    translate([3, 0, v])
      cube([48, 0.5, 1]);
  }
}
