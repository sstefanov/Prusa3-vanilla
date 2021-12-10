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

module x_end_base(){
// Main block
    translate(v=[x_rod_center,-((x_block_depth-bearing_size)/2),x_end_base_height/2]) cube(size = [x_block_width,x_block_depth,x_end_base_height], center = true);
// Bearing holder
    vertical_bearing_base();	
//Nut trap
 // Cube
    x_cube_width = z_rod_to_screw_distance+x_hex_size/2+4-bearing_size/2;
    translate(v=[-bearing_size/4,-2-(z_rod_to_screw_distance+x_hex_size/2+2-x_cube_width/2),x_hex_size/2]) cube(size = [bearing_size/2,x_cube_width,x_hex_size], center = true);
 // Hexagon
    translate(v=[0,-(z_rod_to_screw_distance),0]) rotate([0,0,30]) cylinder(h = x_hex_size, r=x_hex_size/2+4, $fn = 6);
}

module x_end_holes(rod_hole_depth = x_block_depth-6){
    // rod_hole_depth = 4-x_block_depth+bearing_size/2;
//    rod_hole_depth = x_block_depth-10;
    rod_hole2_depth = x_block_depth - rod_hole_depth;
    vertical_bearing_holes();
// Belt hole
    translate(v=[0,0,0]){
// Stress relief
        translate(v=[x_rod_center,-bearing_size/2-1,x_end_base_height/2]) cube(size = [x_block_width+1,1,x_rod_distance - x_rod_diameter - 6], center = true);
            difference(){
                translate(v=[x_rod_center,-(0.05+x_block_depth-bearing_size)/2,x_end_base_height/2]) cube(size = [x_hole_width,x_block_depth+0.1,x_hole_height], center = true);

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

// Nut trap
    translate(v=[0,-(z_rod_to_screw_distance),-0.5]) poly_cylinder(h = 4, r=x_hex_diameter/2, $fn=25);
    translate(v=[0,-(z_rod_to_screw_distance),3]) rotate([0,0,30]) cylinder(h = 10, r=x_hex_size/2, $fn = 6);
}


// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();
//rod_hole_depth = x_block_depth-4;
rod_hole_depth = x_block_depth-10;
rod_hole2_depth = x_block_depth - rod_hole_depth;


module pushfit_rod(diameter,length){
 poly_cylinder(h = length, r=diameter/2);
 difference(){
 	translate(v=[0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
 	translate(v=[0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
 }
 //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

