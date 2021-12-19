// PRUSA iteration3
// X end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// S. Stefanov 2021
// all configurations moved to file config.scad
include <config.scad>

// Final part
module x_end_idler_pulley(p_diam=0,p_width=0){
    p_radius = (p_diam==0) ? xt_pulley_diameter/2 : p_diam/2;
    p_width = (p_width==0) ? belt_width : p_width;
    rotate ([0,90,0]) {
        difference() {
            union () {
                cylinder(h = belt_width, r = p_radius, $fn=30, center = true);
                translate(v=[0,0,-belt_width/2]) cylinder(h = 2, r = 2+p_radius,center = true, $fn=30);
                translate(v=[0,0,belt_width/2]) cylinder(h = 2, r = 2+p_radius,center = true, $fn=30);
            }
            cylinder(h = belt_width+6, r = xt_pulley_axe_diameter/2,center = true, $fn=30);
        }
    }
}

x_end_idler_pulley();
