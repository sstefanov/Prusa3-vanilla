// configurations

//bearing.scad
thinwall = 3;
bearing_diameter = 19;
bearing_size = bearing_diameter + 2 * thinwall;
ziptie_cut_ofset = 0;

// y
z_rod_to_screw_distance = 27;

// end-idler
//x_rod_diameter = 10 ;

//x-end.scad
x_rod_diameter = 8 ;
x_rod_distance = 64; // 45
x_end_base_height = x_rod_distance + 8 + x_rod_diameter; //68;
// r = x * 2 / sqrt(3) = x * 1.154
x_hex_size = 10 * 1.154;
x_hex_diameter = 6;
x_block_width = x_rod_diameter + 9;
x_rod_center = -((bearing_size+x_block_width)/2);
x_hole_width = 10;
if (x_rod_diameter>10) { 
    x_hole_width = x_rod_diameter ;
};
x_hole_height = x_rod_distance - x_rod_diameter - 6 ;
x_block_depth = bearing_size/2 + z_rod_to_screw_distance + x_hex_size/2+4;


//bearing.scad
bearing_height = x_end_base_height; // 58

