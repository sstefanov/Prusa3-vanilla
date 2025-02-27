// PRUSA iteration3
// X end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

// S. Stefanov 2021
// all configurations moved to file config.scad
include <config.scad>
use <x-end.scad>

module x_end_idler_base(){
 x_end_base();
}

module x_end_idler_holes(){
    rod_hole_depth = 10;
    x_end_holes(rod_hole_depth);
    translate(v=[0,-(x_hex_size+bearing_size/2),x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 80, r=1.8, $fn=30);
// translate(v=[0,-22,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 80, r=1.8, $fn=30);
    translate(v=[-1,-(x_hex_size+bearing_size/2),x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = bearing_size/2, r=3.1, $fn=30);
    translate(v=[-(x_block_width-1+bearing_size/2),-(x_hex_size+bearing_size/2),x_end_base_height/2]) rotate(a=[0,-90,0]) rotate(a=[0,0,30]) cylinder(h = 80, r=3.6, $fn=6);
// translate(v=[-x_block_width,-(x_hex_size+bearing_size/2),x_end_base_height/2]) rotate(a=[0,-90,0]) rotate(a=[0,0,30]) cylinder(h = 80, r=3.6, $fn=6);
}
 
// Final part
module x_end_idler(){
 mirror([0,1,0]) difference(){
  x_end_idler_base();
  x_end_idler_holes();
 }
}

x_end_idler();
