// JBL Clip 5 cradle
// r_w: radius of bottom arc along width axis (left-right), from front image
// r_d: radius of bottom arc along depth axis (front-back), from side image
// Add ~1-2mm clearance to each so the speaker drops in without force

r_w   = 44;   // 42mm measured + 2mm clearance
r_d   = 22;   // 20.6mm measured + ~1.5mm clearance
w     = 96;   // cradle width (86mm spec + 10mm walls)
d     = 56;   // cradle depth (46mm spec + 10mm walls)
h     = 20;   // cradle block height — enough to hold the socket
lip_h = 6;    // front lip height above socket floor
lip_t = 4;    // front lip thickness
$fn   = 80;

module socket() {
    // Intersection of two perpendicular cylindrical bores
    // Both cylinders are oriented so their concave surface faces upward
    intersection() {
        // Cylinder 1: axis runs front-to-back (Y), curves left-to-right
        // Center of cylinder is above the block at height r_w
        translate([w/2, -1, r_w])
            rotate([90, 0, 0])
                cylinder(h=d+2, r=r_w, center=false);

        // Cylinder 2: axis runs left-to-right (X), curves front-to-back
        // Center of cylinder is above the block at height r_d
        translate([-1, d/2, r_d])
            rotate([0, 90, 0])
                cylinder(h=w+2, r=r_d, center=false);
    }
}

module cradle() {
    difference() {
        // Solid base block
        cube([w, d, h]);
        // Subtract the doubly-curved socket from above
        translate([0, 0, h - 14])
            socket();
    }
    // Front lip: prevents speaker sliding forward off the stand
    translate([0, d - lip_t, 0])
        cube([w, lip_t, lip_h]);
}

difference() {
  translate([0, -d/2, 0]) cube([w, d, h]);

  intersection() {
    translate([w/2, (d+2)/2, r_w])
      rotate([90, 0, 0])
      cylinder(h=d+2, r=r_w, center=false);
    translate([-1, 0, r_d])
      rotate([0, 90, 0])
      cylinder(h=w+2, r=r_d, center=false);
  }
}
