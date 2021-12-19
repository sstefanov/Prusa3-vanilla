// configurations
//bearing.scad
use <polyholes.scad>
// constants
m3_through_dia=3.2;
d_head_m3 = 5.4;
h_head_m3 = 3.2;

// common parameters
thinwall = 3;
// z axis
bearing_diameter = 19;
bearing_length =  29;
bearing_size = bearing_diameter + 2 * thinwall;

ziptie_cut_ofset = 0;

z_rod_to_screw_distance = 27;

// Nut type
// true if hexagonal
// false if trapezoidal
nut_hex_type = true;

// trapezoidal nut parameters
nut_outer=12.5; //radius
nut_inner=7; //radius
nut_height=8;
nut_offset=17;
bolt_distance_nut=19;
nut_trap_reinf_height= 25; //32.5;
nut_reinf_pushback=0.98;
nut_reinf_wall=4.5;
nut_reinf_rotate=17.5;

//x-end.scad
x_rod_diameter = 8 ;
x_rod_distance = 64; // 45
x_rod_length = 400;

x_rod_motor_depth = 20;
x_rod_idler_depth = 20;

// r = x * 2 / sqrt(3) = x * 1.154
x_hex_size = 10 * 1.154;
x_hex_diameter = 6;
//x_block_width = x_rod_diameter + 9;
//x_hole_width = 15;
//if (x_rod_diameter>10) { 
//    x_hole_width = x_rod_diameter + 6 ;
//};
x_belt_pulley_diameter = 8;
// x carriage bearings
x_bearing_diameter = 19;
x_bearing_length =  24;
x_bearing_size = bearing_diameter + 2 * thinwall;

//Belt dimensions
belt_slot_height=1.95;
belt_tooth_height=1.25;
belt_width=6;

// x tensioner
xt_pulley_diameter=25;
xt_pulley_axe_diameter=3;

//calculations
nut_outer_corr=correctedRadius(nut_outer,sides(nut_outer));
nut_inner_corr=correctedRadius(nut_inner,sides(nut_inner));

x_end_base_height = x_rod_distance + 8 + x_rod_diameter; //68;

x_hole_height = x_rod_distance - x_rod_diameter - 6 ;

x_cube_width = nut_hex_type ? z_rod_to_screw_distance+x_hex_size/2+4-bearing_size/2 : z_rod_to_screw_distance+nut_outer_corr+bearing_size/2;
x_block_depth = nut_hex_type ? bearing_size/2 + z_rod_to_screw_distance + x_hex_size/2+4 : z_rod_to_screw_distance + bearing_size/2 + nut_outer_corr;

echo ("x_block_depth",x_block_depth);
//bearing.scad
bearing_height = x_end_base_height; // 58
rod_z_flange=nut_offset+correctedRadius(nut_outer,sides(nut_outer));

xt_hole_width = belt_width + 4; // 2 * 2 + 2 * 0.25

xt_width = xt_hole_width + 8;
xt_height = x_hole_height - 0.4;
xt_depth = (xt_pulley_diameter/2) + 16;

xt_hole_height = xt_pulley_diameter + 8;
xt_hole_depth = xt_depth - 5;

x_hole_width = xt_width + 0.2;
x_block_width = x_hole_width + 4;
x_rod_center = -((bearing_size+x_block_width)/2);

// bottom of the belt must be horizontal
x_motor_axis_offset = (x_end_base_height+x_belt_pulley_diameter-xt_pulley_diameter) / 2;

//bottom of motor pulley is in center
mot_block_width = x_block_width > 17 ? x_block_width: 17;
b_hole_height = x_belt_pulley_diameter > 16 ? x_belt_pulley_diameter + 6 : 22;

// modules
// m3 nut and bolt
module m3_nut (hole=false) {
    difference() {
        cylinder(h=3.2, r=5.9/2, center = true, $fn=6);
        if (hole) cylinder(h=3.3, r=1.6, center = true, $fn=30);
    }
}

module m3_bolt_countersink (length=10) {
    union () {
        translate(v=[0,0,-6.7/4]) cylinder(h=6.7/2, r2=6.7/2, r1=0, center = true, $fn=30);
        translate(v=[0,0,-length/2]) cylinder(h=length, r=1.6, center = true, $fn=30);
    }
}

module m3_bolt () {
}

//m3_bolt_countersink ();