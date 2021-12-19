// S. Stefanov 2021
// all configurations moved to file config.scad
include <config.scad>
use <x-end-motor.scad>
use <x-end-idler-with_tensioner.scad>
use <x-end-idler-pulley.scad>
include <MCAD/stepper.scad>


module x_rod() {
    rotate ([90,0,0]) cylinder(h=x_rod_length,r=x_rod_diameter/2,center = true,$fn=20);
}

x_motor_offset = x_rod_length/2 + x_block_depth - bearing_size/2 - x_rod_motor_depth; 
x_idler_offset = -(x_rod_length/2 + x_block_depth - bearing_size/2 - x_rod_idler_depth); 
x_idler_tensioner_axis_y = x_idler_offset+(xt_height/2+6);
x_motor_axis_y = (44+bearing_size)/2 + x_motor_offset;
belt_bottom_z = (x_end_base_height - xt_pulley_diameter - belt_slot_height - belt_tooth_height) / 2 ;
belt_bottom_length = -x_idler_tensioner_axis_y + x_motor_axis_y;

// rods
#translate([x_rod_center,0,(x_end_base_height+x_rod_distance)/2]) x_rod();
#translate([x_rod_center,0,(x_end_base_height-x_rod_distance)/2]) x_rod();

//difference() {
// x-end-motor
    translate([0,x_motor_offset,0]) x_end_motor(x_rod_motor_depth);
    translate([0,x_idler_offset,0]) x_end_idler(with_tensioner=true,rod_hole_depth=x_rod_idler_depth);
// x-end-tensioner
    translate([0,x_idler_offset,0]) x_end_tensioner();
    
    translate([x_rod_center,x_idler_tensioner_axis_y,x_end_base_height/2]) {
        x_end_idler_pulley();
        translate([xt_width/2,0,0]) rotate ([0,90,0]) m3_bolt_countersink(xt_width);
        translate([-xt_width/2+1.6,0,0]) rotate ([0,90,0]) m3_nut();
    }
    
//    translate([x_rod_center,0,10+(x_end_base_height+x_rod_distance)/2]) cube([100,500,20],center=true);
// motor pulley
    translate([x_rod_center,x_motor_axis_y,x_motor_axis_offset]) {
        x_end_idler_pulley(p_diam=x_belt_pulley_diameter);
        translate([x_rod_center+mot_block_width/2+3,0,0]) rotate ([0,-90,0]) motor(model=Nema17, size=NemaShort);
    }
// belt
    translate([x_rod_center,x_motor_axis_y-belt_bottom_length/2,belt_bottom_z]) cube([belt_width,belt_bottom_length,belt_slot_height+belt_tooth_height],center=true);
    
    top_belt_angle = atan((xt_pulley_diameter-x_belt_pulley_diameter)/belt_bottom_length);
    echo ("top_belt_angle", top_belt_angle);
    translate([x_rod_center,x_motor_axis_y-belt_bottom_length/2,belt_bottom_z+(xt_pulley_diameter+x_belt_pulley_diameter)/2+belt_slot_height+belt_tooth_height]) rotate([-top_belt_angle,0,0]) cube([belt_width,belt_bottom_length,belt_slot_height+belt_tooth_height],center=true);

//}