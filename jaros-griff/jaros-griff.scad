include <../BOSL2/std.scad>

height = 26;
length = 150;
edge_rounding = 8;

$fn = 50;

union()
{
    translate([ height / 2, length - (height / 2), height / 2 ])
        cuboid([ length, height, height ], rounding = edge_rounding);
    cube([ height, length - (height / 2), height ]);
}

// union()
// {
//     cylinder(h = 4, r = 1, center = true, $fn = 100);
//     rotate([ 90, 0, 0 ]) cylinder(h = 4, r = 0.9, center = true, $fn = 100);
// }
