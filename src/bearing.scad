// PRUSA iteration3
// Bearing holders
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// S. Stefanov 2021
// all configurations moved to file config.scad
include <config.scad>
use <polyholes.scad>

use <scad-utils/morphology.scad>


module horizontal_bearing_base(bearings=1){
 translate(v=[0,0,6]) cube(size = [x_bearing_diameter+9,8+bearings*x_bearing_length,x_bearing_diameter-3], center = true);	
}

module horizontal_bearing_holes(bearings=1){
 cutter_lenght = 10+bearings*x_bearing_length;
 one_holder_lenght = 8+x_bearing_length;
 holder_lenght = 8+bearings*x_bearing_length;
 %translate(v=[0,0,x_bearing_diameter-3]) rotate(a=[90,0,0]) translate(v=[0,0,-bearings*x_bearing_length/2]) cylinder(h = bearings*x_bearing_length, r=x_bearing_diameter/2, $fn=50);
 // Main bearing cut
 difference(){
  translate(v=[0,0,x_bearing_diameter-3]) rotate(a=[90,0,0]) translate(v=[0,0,-cutter_lenght/2]) cylinder(h = cutter_lenght, r=x_bearing_diameter/2, $fn=50);
  // Bearing retainers
  translate(v=[0,1-holder_lenght/2,3]) cube(size = [x_bearing_diameter+10,6,8], center = true);
  translate(v=[0,-1+holder_lenght/2,3]) cube(size = [x_bearing_diameter+10,6,8], center = true);
 }
 
 // Ziptie cutouts
 for ( i = [0 : bearings-1] ){
  // For easier positioning I move them by half of one 
  // bearing holder then add each bearign lenght and then center again
  translate(v=[0,-holder_lenght/2,0]) translate(v=[0,one_holder_lenght/2+i*25,0]) difference(){
   union(){
    translate(v=[0,2-6,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
    translate(v=[0,2+6,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = 4, r=12.5, $fn=50);
   }
   translate(v=[0,10,12]) rotate(a=[90,0,0]) translate(v=[0,0,0]) cylinder(h = x_bearing_length, r=(5+x_bearing_diameter)/2, $fn=50);
  }
 }
 
}

module horizontal_bearing_test(){
 difference(){
  horizontal_bearing_base(1);
  horizontal_bearing_holes(1);
 }
 translate(v=[(bearing_height+2)/2,0,0]) difference(){
  horizontal_bearing_base(2);
  horizontal_bearing_holes(2);
 }
 translate(v=[bearing_height+2,0,0]) difference(){
  horizontal_bearing_base(3);
  horizontal_bearing_holes(3);
 }
}

el_width=10;
el_length=20;
el_thickness=4;
el_fillet=5;
el_fillet45=el_fillet*sqrt(2);
el_nice=1;
el_nice45=el_nice*sqrt(2);

module enforce_element(hex_hole=true) {

    d = el_length / (2 + sqrt(2));
    module cube_c() {
        difference() {
            cube(size = [el_thickness+0.01,el_length,el_length],center = true);
            // nice corners
            translate (v=[-el_nice-el_thickness/2,0,el_nice+el_length/2])  rotate(a=[0,45,0]) cube(size = [el_nice*4,el_length,el_nice*4],center = true);
            translate (v=[-el_nice-el_thickness/2,0,-el_nice-el_length/2])  rotate(a=[0,45,0]) cube(size = [el_nice*4,el_length,el_nice*4],center = true);
            translate (v=[-el_nice-el_thickness/2,-el_nice-el_length/2,0])  rotate(a=[0,0,45]) cube(size = [el_nice*4,el_nice*4,el_length],center = true);

        }
    }
    //translate([0, -bolt_distance_nut/2, 4]) rotate([0,0, 30]) cylinder(h = 3, r = 3.2, $fn=6);
    //fillet(el_nice) 
    //minkowski() {        cylinder(r=el_nice);
    
   difference() {
        
        intersection() {
            cube(size = [el_thickness,el_width,el_length],center = true);
            translate(v=[0,(-el_width+el_length)/2,0]) intersection () {
                cube_c();
                translate(v=[0,-d+el_fillet45,0]) rotate (a=[45,0,0]) cube_c();
            }
        }
        rotate (a=[0,90,0]) cylinder(r=m3_through_dia/2, h=el_thickness+2, $fn = 25,center = true);
        if (hex_hole) 
            translate(v=[(1.99-el_thickness)/2,0,0]) rotate (a=[0,90,0])  cylinder(r=d_head_m3/2, h=2, $fn = 6,center = true) ;
    }
}

module vertical_enforcement() {
    translate(v=[-(1+el_thickness)/2,0,0]) enforce_element(true);
    translate(v=[(1+el_thickness)/2,0,0]) mirror([1,0,0]) enforce_element(false);
}

module vertical_bearing_base(reinforcement=false){
 translate(v=[-1-bearing_size/4,0,bearing_height/2]) cube(size = [2+bearing_size/2,bearing_size,bearing_height], center = true);
 cylinder(h = bearing_height, r=bearing_size/2, $fn = 90);
    if (reinforcement) {
        rotate(a=[0,0,50]) { 
            translate(v=[0,-(bearing_diameter+el_width)/2, el_length/2+5])  vertical_enforcement();
            translate(v=[0,-(bearing_diameter+el_width)/2, bearing_height-el_length/2-5])  vertical_enforcement();
        }
    }
    
}

module vertical_bearing_holes(){
  translate(v=[0,0,-1]) poly_cylinder(h = bearing_height+4, r=0.2+bearing_diameter/2);
  rotate(a=[0,0,-40]) translate(v=[bearing_diameter/2-1,-0.5,-1]) cube(size = [thinwall*2,1,bearing_height+4]);

}

module vertical_bearing(reinforcement=false) {
    difference(){
        vertical_bearing_base(reinforcement);
        vertical_bearing_holes();
    }
}

//vertical_bearing(true);
horizontal_bearing_test();

