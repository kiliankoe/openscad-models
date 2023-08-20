include <../BOSL2/std.scad>

pillow_rounding = 5;
pillow_height = 14;

back_length = 215;
back_top_height = 6.5;

module lg_pillow() {
  cuboid([140, 74, pillow_height], rounding = pillow_rounding);
}

module md_pillow() {
  cuboid([74, 74, pillow_height], rounding = pillow_rounding);
}

module sm_pillow() {
  cuboid([74, 40, pillow_height], rounding = pillow_rounding);
}

module side() {
  cuboid([87.5, 48, 12], rounding = 3);
}

module base() {
  cube([140, 75, 13], center = true);
}

module back() {
  prismoid(size1=[10, 215], size2=[6.5, 215], h=48, shift=[1.75, 0]);
}

module foot() {
  // original d = 4.5
  cylinder(h = 15.5, d = 6);
}

$fn = 50;

base();
translate([140/2+75/2, 75/2-5, 0]) rotate([0, 0, 90]) base();

translate([-140/2 - 12/2, 6.2, 48/2-13/2]) rotate([90, 0, 90]) side();
translate([140/2 + 75 + 12/2 - 1, 6.2, 48/2-13/2]) rotate([90, 0, 90]) side();

translate([37.5, -32.5, 0]) rotate([0, 0, 270]) back();

translate([107, 40, 13]) rotate([0, 0, 90]) lg_pillow();
translate([35, 8, 13]) md_pillow();
translate([-35, 8, 13]) md_pillow();

translate([-35, -24, 39]) rotate([-80, 0, 0]) sm_pillow();
translate([36, -24, 39]) rotate([-80, 0, 0]) sm_pillow();
translate([107, -24, 39]) rotate([-80, 0, 0]) sm_pillow();

// foot positions aren't measured, just guessed

translate([-62, -28, -22]) foot();
translate([-62, 29, -22]) foot();
translate([63, -28, -22]) foot();
translate([63, 29, -22]) foot();

translate([80, -28, -22]) foot();
translate([138, -28, -22]) foot();
translate([80, 94, -22]) foot();
translate([138, 94, -22]) foot();
