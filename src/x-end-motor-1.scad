// PRUSA iteration3
// X end motor
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// S. Stefanov 2021
// all configurations moved to file config.scad
include <config.scad>

use <x-end.scad>

motor_axis_z = x_end_base_height / 2;

module x_end_motor_base(){
 x_end_base();
 translate(v=[x_rod_center,-(43+x_block_depth+bearing_size)/2,motor_axis_z-2]) cube(size = [17,44,51], center = true);
}

module x_end_motor_holes(){
    rod_hole_depth = 24;
 x_end_holes(rod_hole_depth);
 // Position to place
 translate(v=[x_rod_center,-(44+x_block_depth+bearing_size)/2,motor_axis_z]){
  // Belt hole
  translate(v=[0,1,0]) cube(size = [10,47,22], center = true);
  // Motor mounting holes
  translate(v=[19,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[-5,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 4, r=3.1, $fn=30);
//  translate(v=[19,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
//  translate(v=[9,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 4, r=3.1, $fn=30);
  translate(v=[19,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[-5,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 4, r=3.1, $fn=30);
  translate(v=[19,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
  translate(v=[-5,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 4, r=3.1, $fn=30);
//  translate(v=[0,15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);

  // Material saving cutout 
  translate(v=[-10,-12,10]) cube(size = [60,42,42], center = true);

  // Material saving cutout
  translate(v=[-10,-40,-33]) rotate(a=[45,0,0])  cube(size = [60,42,42], center = true);
  // Motor shaft cutout
  translate(v=[10,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=17, $fn=6);
 
 }
}

// Final part
module x_end_motor(){
 difference(){
  x_end_motor_base();
  x_end_motor_holes();
//     x_end_holes();
 }
}

x_end_motor();
//translate(v=[x_rod_center,-(44+x_block_depth+bearing_size)/2,motor_axis_z]){  //translate(v=[-5,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 4, r=3.1, $fn=30);
//}