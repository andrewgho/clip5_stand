r_w = 44;       // left-right radius (width axis)
r_d = 22;       // front-back radius (depth axis)
r_v = 35;       // vertical radius — controls how "deep" the socket cup is

b_w = 100;      // base width
b_d = 60;       // base depth
b_r = 12;       // base corner radius

depth = 24;     // how far down the speaker sinks (stand height is depth + t2)
thickness = 4;  // minimum shell thickness
thickness2 = thickness * 2;

cutoff_w = max((r_w + thickness2) * 2, b_w);
cutoff_d = max((r_d + thickness2) * 2, b_d);
cutoff_v = (r_v * 2) + thickness2 - depth;

e = 0.1;
e2 = e * 2;
$fn = 90;

module ellipsoid(x, y, z) {
  scale([x, y, z]) sphere(r=1);
}

module shell() {
  difference() {
    hull() {
      translate([0, 0, -(r_v + thickness2 + e)]) {
        rounded_cube(b_w, b_d, e, b_r);
      }
      ellipsoid(r_w + thickness2, r_d + thickness2, r_v + thickness2);
    }
    ellipsoid(r_w, r_d, r_v);
  }
}

module rounded_cube(x, y, z, r = 1) {
  dx = (x / 2) - r;
  dy = (y / 2) - r;
  hull() {
    translate([-dx, -dy, 0]) cylinder(h = z, r = r);
    translate([dx, -dy, 0]) cylinder(h = z, r = r);
    translate([dx, dy, 0]) cylinder(h = z, r = r);
    translate([-dx, dy, 0]) cylinder(h = z, r = r);
  }
}

difference() {
  translate([0, 0, r_v - depth]) shell();
  rounded_cube(cutoff_w + e2, cutoff_d + e2, cutoff_v + e, b_r);
}
