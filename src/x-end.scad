// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// S. Stefanov 2021
// all configurations moved to file config.scad
include <config.scad>

use <bearing.scad>
use <polyholes.scad>
use <x-idler-tensioner.scad>

module x_end_base(){
// Main block
    translate(v=[x_rod_center,-((x_block_depth-bearing_size)/2),x_end_base_height/2]) cube(size = [x_block_width,x_block_depth,x_end_base_height], center = true);
// Bearing holder
    vertical_bearing_base(true);	
    if (nut_hex_type)
        nut_hex();
    else
        nut_trapez();
}

module x_end_holes(open_end=true, rod_hole_depth=0){
    // rod_hole_depth = 4-x_block_depth+bearing_size/2;
//    rod_hole_depth = x_block_depth-10;
    rod_hole_depth = (rod_hole_depth==0) ? x_block_depth-6 : rod_hole_depth;
    rod_hole2_depth = x_block_depth - rod_hole_depth;
    vertical_bearing_holes();
// Belt hole
    translate(v=[0,0,0]){
// Stress relief
        if (open_end)
            translate(v=[x_rod_center,-bearing_size/2-1,x_end_base_height/2]) cube(size = [x_block_width+1,1,x_rod_distance - x_rod_diameter - 6], center = true);
        difference(){
            if (open_end)
                translate(v=[x_rod_center,-(0.05+x_block_depth-bearing_size)/2,x_end_base_height/2]) cube(size = [x_hole_width,x_block_depth+0.1,x_hole_height], center = true);
            else {
              translate(v=[x_rod_center,-(0.05+x_block_depth-bearing_size)/2-3,x_end_base_height/2]) {
                cube(size = [x_hole_width,x_block_depth+0.1-6,x_hole_height], center = true);
                translate(v=[0,0,xt_height/2-4.5]) rotate([90,0,0]) cylinder(h=x_block_depth+50, r=m3_through_dia/2, center = true, $fn=30);
                translate(v=[0,0,-(xt_height/2-4.5)]) rotate([90,0,0]) cylinder(h=x_block_depth+50, r=m3_through_dia/2, center = true, $fn=30);
                translate(v=[0,x_block_depth/2+2.6,xt_height/2-4.5]) rotate([90,0,0]) cylinder(h=1, r=m3_through_dia, center = true, $fn=30);
                translate(v=[0,x_block_depth/2+2.6,-(xt_height/2-4.5)]) rotate([90,0,0]) cylinder(h=1, r=m3_through_dia, center = true, $fn=30);
                  
                }
            }
                
	// Nice edges
            edge_offset = 2;
            translate(v=[-edge_offset+7+x_rod_center+x_hole_width/2,-10,(x_end_base_height-x_hole_height)/2]) rotate([0,45,0]) cube(size = [10,x_block_depth+20,28], center = true);
            translate(v=[edge_offset-7+x_rod_center-x_hole_width/2,-10,(x_end_base_height-x_hole_height)/2]) rotate([0,-45,0]) cube(size = [10,x_block_depth+20,28], center = true);
            translate(v=[-edge_offset+7+x_rod_center+x_hole_width/2,-10,(x_end_base_height+x_hole_height)/2]) rotate([0,-45,0]) cube(size = [10,x_block_depth+20,28], center = true);
            translate(v=[edge_offset-7+x_rod_center-x_hole_width/2,-10,(x_end_base_height+x_hole_height)/2]) rotate([0,45,0]) cube(size = [10,x_block_depth+20,28], center = true);

//                translate(v=[x_rod_center+cube_width/2,-10,cube_height/2+23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
//    	        translate(v=[x_rod_center+5.5,-10,30+23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
    //	        translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
    //	        translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);

            }
        }

// Bottom pushfit rod
    translate(v=[x_rod_center,-1-(x_block_depth-bearing_size/2),(x_end_base_height-x_rod_distance)/2]) rotate(a=[-90,0,0]) pushfit_rod(x_rod_diameter + 0.1,rod_hole_depth+1);
    translate(v=[x_rod_center,-1+bearing_size/2-rod_hole2_depth,(x_end_base_height-x_rod_distance)/2]) rotate(a=[-90,0,0]) cylinder(h = rod_hole2_depth+200, r=1.8, $fn=30);
    translate(v=[x_rod_center,-4+bearing_size/2,(x_end_base_height-x_rod_distance)/2]) rotate(a=[-90,0,0]) cylinder(h = 200, r=4, $fn=30);   

// Top pushfit rod
    translate(v=[x_rod_center,-1-(x_block_depth-bearing_size/2),(x_end_base_height+x_rod_distance)/2]) rotate(a=[-90,0,0]) pushfit_rod(x_rod_diameter + 0.1,rod_hole_depth+1);
    translate(v=[x_rod_center,-1+bearing_size/2-rod_hole2_depth,(x_end_base_height+x_rod_distance)/2]) rotate(a=[-90,0,0]) cylinder(h = rod_hole2_depth+200, r=1.8, $fn=30);     
    translate(v=[x_rod_center,-4+bearing_size/2,(x_end_base_height+x_rod_distance)/2]) rotate(a=[-90,0,0]) cylinder(h = 200, r=4, $fn=30); 
}

// Final prototype
module x_end_plain(open_end=true){
 difference(){
  x_end_base();
  x_end_holes(open_end);
 }
}

x_end_plain(false);
//rod_hole_depth = x_block_depth-4;
//rod_hole_depth = x_block_depth-10;
//rod_hole2_depth = x_block_depth - rod_hole_depth;
//#translate(v=[x_rod_center,-bearing_size/2-1,x_end_base_height/2]) x_end_tensioner();

module pushfit_rod(diameter,length){
 poly_cylinder(h = length, r=diameter/2);
 difference(){
 	translate(v=[0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
 	translate(v=[0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
 }
 //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

// hex nut
module nut_hex() {
    difference() {
        union() {
//            x_cube_width = z_rod_to_screw_distance+x_hex_size/2+4-bearing_size/2;
            translate(v=[-bearing_size/4,-2-(z_rod_to_screw_distance+x_hex_size/2+2-x_cube_width/2),x_hex_size/2]) cube(size = [bearing_size/2,x_cube_width,x_hex_size], center = true);
            translate(v=[0,-(z_rod_to_screw_distance),0]) rotate([0,0,30]) cylinder(h = x_hex_size, r=x_hex_size/2+4, $fn = 6);
        };
        translate(v=[0,-(z_rod_to_screw_distance),-0.5]) poly_cylinder(h = 4, r=x_hex_diameter/2, $fn=25);
        translate(v=[0,-(z_rod_to_screw_distance),3]) rotate([0,0,30]) cylinder(h = 10, r=x_hex_size/2, $fn = 6);
    }
}

// trapezoidal thread nut
module nut_trapez() {
    
    module nut_cylinder(h){
        cylinder(h = h, r=nut_outer_corr, $fn=sides(nut_outer));    
    }
    
    module nut_reinf(){
        module nut_reinf_add(){
            translate([0,0,nut_height]) nut_cylinder(nut_trap_reinf_height);   
            rotate([0,0,-135]) translate([-nut_outer_corr,0,nut_height])cube([nut_reinf_wall,nut_outer_corr,nut_trap_reinf_height]);
            rotate([0,0,-135]) translate([nut_outer_corr-nut_reinf_wall,0,nut_height])cube([nut_reinf_wall,nut_outer_corr,nut_trap_reinf_height]);
        }
        
        module nut_reinf_rem(){
            translate([0,0,nut_height-0.001]) cylinder(r=nut_outer_corr-nut_reinf_wall,h=nut_trap_reinf_height+0.1);
            rotate([0,0,-135])  translate([-nut_outer_corr+nut_reinf_wall,0,nut_height+0.1]) cube([2*(nut_outer_corr-nut_reinf_wall),nut_outer_corr,nut_trap_reinf_height]);  
            translate([0,nut_outer_corr,nut_trap_reinf_height+nut_height]) rotate ([0,90,nut_reinf_rotate])linear_extrude(height=3*nut_outer_corr,center=true)scale([nut_trap_reinf_height/nut_outer_corr,nut_reinf_pushback]) circle(r=nut_outer_corr,$fn=50);
        }

        difference(){
            nut_reinf_add();
            nut_reinf_rem();
            }
    }
    
    module nut_trap() {
        nut_cylinder(nut_height);
        rotate([0,0,90])  translate([-nut_outer_corr,0,0]) cube([2*nut_outer_corr,nut_outer_corr,nut_height]);
    }
    
    module nut_trap_cutout() {
       // Hole for the nut
        translate(v=[0,0, -1]) poly_cylinder(h = nut_height+1.01, r = nut_inner, $fn = 25);
        translate(v=[0,0, -0.1]) cylinder(h = 0.5, r1 = 1.085*nut_inner, r = nut_inner, $fn = 25);
    // Screw holes for TR nut
        translate([0, 9.5, -1]) cylinder(h = 10, d=m3_through_dia, $fn=25);
        translate([0, -9.5, -1]) cylinder(h = 8, d=m3_through_dia, $fn=25);
    // Nut traps for TR nut screws
        translate([0, bolt_distance_nut/2, 4]) cylinder(h = 100, r = 3.45, $fn=6);
        translate([0, -bolt_distance_nut/2, 4]) rotate([0,0, 30]) cylinder(h = 3, r = 3.2, $fn=6);
        translate([0,- bolt_distance_nut/2+5.5,4]) cylinder(h=3, r=5,$fn=6);
    }
    
    translate(v=[0,-z_rod_to_screw_distance,0]) difference () {
        union() {
            //translate ([z_rod_to_screw_distance,rod_z_flange-nut_offset,0]) rotate ([0,0,-135])
            rotate ([0,0,-135]) nut_reinf();
            nut_trap();
        }
        rotate ([0,0,-135]) nut_trap_cutout();
    }
}