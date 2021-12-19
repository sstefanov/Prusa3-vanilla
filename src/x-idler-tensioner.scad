// S. Stefanov 2021
// all configurations moved to file config.scad

include <config.scad>
use <x-end-idler-pulley.scad>

module x_end_tensioner() {
    module xt_body () {
            difference(){
                        cube(size = [xt_width,xt_depth,xt_height], center = true);

            // Nice edges
                    edge_offset = 2;
                    translate(v=[-edge_offset-xt_width/2,-xt_depth/2,xt_height/2]) rotate([0,45,0]) cube(size = [6,x_block_depth+20,28], center = true);
                    translate(v=[edge_offset+xt_width/2,-xt_depth/2,xt_height/2]) rotate([0,-45,0]) cube(size = [6,x_block_depth+20,28], center = true);
                    translate(v=[-edge_offset-xt_width/2,-xt_depth/2,-xt_height/2]) rotate([0,-45,0]) cube(size = [6,x_block_depth+20,28], center = true);
                    translate(v=[edge_offset+xt_width/2,-xt_depth/2,-xt_height/2]) rotate([0,45,0]) cube(size = [6,x_block_depth+20,28], center = true);
                    translate(v=[-8,xt_depth/2+3,0]) rotate([0,0,45]) cube(size = [28,6,xt_height+20], center = true);
                    translate(v=[8,xt_depth/2+3,0]) rotate([0,0,-45]) cube(size = [28,6,xt_height+20], center = true);
                    translate(v=[0,xt_depth/2+5.5,-xt_height/2+3]) rotate([-45,0,0]) cube(size = [xt_width+2,6,xt_height+20], center = true);
                    translate(v=[0,xt_depth/2+5.5,xt_height/2-3]) rotate([45,0,0]) cube(size = [xt_width+2,6,xt_height+20], center = true);
        /*
                    translate(v=[edge_offset+xt_width/2,-10,(x_end_base_height-x_hole_height)/2]) rotate([0,-45,0]) cube(size = [10,x_block_depth+20,28], center = true);
                    translate(v=[-edge_offset+7+x_hole_width/2,-10,(x_end_base_height+x_hole_height)/2]) rotate([0,-45,0]) cube(size = [10,x_block_depth+20,28], center = true);
                    translate(v=[edge_offset-7-x_hole_width/2,-10,(x_end_base_height+x_hole_height)/2]) rotate([0,45,0]) cube(size = [10,x_block_depth+20,28], center = true);
        */
        //                translate(v=[x_rod_center+cube_width/2,-10,cube_height/2+23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
        //    	        translate(v=[x_rod_center+5.5,-10,30+23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
            //	        translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
            //	        translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
            }
        }
    module xt_holes () {
        translate(v=[0,-2.5,0]) {
            translate(v=[0,-xt_depth/2+10.5,0]) {
                translate(v=[0,-10.5/2,0]) cube(size = [xt_hole_width,10.5,xt_hole_height], center = true);
                rotate([0,90,0]) cylinder(h = xt_hole_width, r=xt_hole_height/2, $fn=30, center = true);
            }
            translate(v=[0,-xt_depth/2+10.5,0]) {
                translate(v=[-(xt_width-3.1)/2,0,0]) rotate([0,90,0]) m3_nut();
                translate(v=[(xt_width)/2+0.1,0,0]) rotate([0,90,0]) m3_bolt_countersink(xt_width);
            }
        }
        translate(v=[0,0,xt_height/2-4.5]) {
            rotate([90,0,0]) cylinder(h=xt_depth+1, r=m3_through_dia/2, $fn=30, center = true);
            translate(v=[0,xt_width/2-6,0])  {
                //rotate([90,30,0]) m3_nut();
                translate(v=[0,0,1]) cube([5.4,3.2,8], center = true);
            }
            translate(v=[0,xt_depth/2-0.99,0]) rotate([-90,0,0]) cylinder(h=2, r1=3.2/2, r2=5/2, $fn=30,  center = true);
        }
        translate(v=[0,0,-(xt_height/2-4.5)]) {
            rotate([90,0,0]) cylinder(h=xt_depth+1, r=m3_through_dia/2, $fn=30, center = true);
            translate(v=[0,xt_width/2-6,0])  {
                //rotate([90,30,0]) m3_nut();
                translate(v=[0,0,-1]) cube([5.4,3.2,8], center = true);
            }
            translate(v=[0,xt_depth/2-0.99,0]) rotate([-90,0,0]) cylinder(h=2, r1=3.2/2, r2=5/2, $fn=30,  center = true);
        }
        
    }
    
    difference(){
        xt_body ();
        xt_holes ();
    }
}
//x_end_tensioner();
//translate(v=[0,-xt_depth/2+8,0]) x_end_idler_pulley();