projector_d = 92;
depth = 2.5;
wall_thickness = 1.5;

$fn = 360;

union()
{
    cylinder(h = wall_thickness, r = projector_d / 2 + wall_thickness);
    translate([ 0, 0, wall_thickness ]) difference()
    {
        cylinder(h = depth, r = projector_d / 2 + wall_thickness);
        cylinder(h = depth, r = projector_d / 2);
    }
}
