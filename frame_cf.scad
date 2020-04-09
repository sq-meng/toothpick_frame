$fn=51;


frame_size = 200;
arms_positions = [45, 135, 225, 315];
d_bracket= 30.5 * 1.414 * 1.3;
arm_nominal_bracket = 30;
d_motor_pad = 20;

fc_pad_height = 2;

support_height=1.6;
support_width=2;

motor_pad_height = 4;
motor_pad_rim_th = 1.2;
pad_rim_height = 4.2    ;
motor_holes = 4;
motor_hole_dia = 2.15;
motor_hole_space_dia = 12;
motor_hole_offset = 0;
motor_center_hole = 6;


arm_th = 1.2;
bracket_th = 2.8;
arm_th_bottom = 1.2;
arm_height = 2;
bracket_height = 12;
arm_height_end = 2;

mnt_offsets = [45, 45];
mnt_hole_dias = [2.1, 3.1];
mnt_hole_distances = [20, 30.5];

side_holes_dia = 3;
side_holes_positions = [90, 180, 270];

x_support = false;
x_support_pos = [0.2, 0.5, 0.8];
prop_dia = 0;



function cat(L1, L2) = [for(L=[L1, L2], a=L) a];

function findx(d1, d2, l) = 
    let (r1 = d1 / 2)
    let (r2 = d2 / 2)
    let (x = l / (r2 / r1 -1))
    let (alpha = asin(r1/x))
    let (x2 = r2 * cos(alpha))
    let (x1 = r1 * cos(alpha))
    [x1, x2];
    

d1 = d_motor_pad;
d2 = arm_nominal_bracket;
l = frame_size / 2;

x = findx(d1, d2, frame_size);
y = [sqrt(d1*d1/4 - x[0]*x[0]) + l, sqrt(d2*d2/4 - x[1]*x[1])];

xl1=[x[0], y[0], 0];
xl2=[x[1], y[1], 0];
xr1=[-x[0], y[0], 0];
xr2=[-x[1], y[1], 0];

echo(x, y);

module multiHull(){
    for (i = [1 : $children-1])
        hull(){
            children(0);
            children(i);
        }
}
 
module sequentialHull(){
    for (i = [0: $children-2])
        hull(){
            children(i);
            children(i+1);
        }
}

module armside(){
    hull(){
        translate([x[0], y[0], 0])cylinder(h=arm_height_end, d2 = arm_th, d1=arm_th_bottom);
        translate([x[1], y[1], 0])cylinder(h=arm_height, d2 = arm_th, d1=arm_th_bottom);
    }
    if (x_support){
    x_support();}
}
module holes(num, h, offset){
        for (i = [0:num - 1]) {
            translate([0, h, 0])
                rotate(motor_hole_offset + i * 360/num, [0, 0, 1])
                translate([0, motor_hole_space_dia / 2, 0])
                cylinder(d=motor_hole_dia, h=30, center=true);
            }
    }

module x_support(){
        for (i = [0:len(x_support_pos) - 2]){
            hull(){
            if (i % 2 == 0){
                translate(x_support_pos[i]*xl1+(1- x_support_pos[i])*xl2)cylinder(h=2, d=1.2);
                translate(x_support_pos[i+1]*xr1+(1- x_support_pos[i+1])*xr2)cylinder(h=2, d=1.2);
                } else {
                translate(x_support_pos[i]*xr1+(1- x_support_pos[i])*xr2)cylinder(h=2, d=1.2);
                translate(x_support_pos[i+1]*xl1+(1- x_support_pos[i+1])*xl2)cylinder(h=2, d=1.2);
                }
            }
        //translate(0.8*xl1+0.2*xl2)cylinder(h=2, d=1.2);
        
        
        //translate(0.3*xr1+0.7*xr2)cylinder(h=2, d=1.2);
        }
    }
module arm(){
    armside();
    mirror([1, 0, 0])armside();
    difference(){
        translate([0, l,  0])cylinder(h=pad_rim_height, d=d_motor_pad + arm_th);
        translate([0, l,  0])cylinder(h=pad_rim_height, d=d_motor_pad - motor_pad_rim_th * 2);
        }
    difference(){
        translate([0, l, 0])cylinder(d=d_motor_pad, h=motor_pad_height);
        holes(motor_holes, l, 0);
        translate([0, l, 0])cylinder(d=motor_center_hole, h=30);
        }
        if (prop_dia > 0.5){
            color([0.5,0.5,0.5,0.5])translate([0, l, -5])cylinder(d=prop_dia * 25.4, h=1);
            }
}
module arms(angles){
    for (angle = angles){
        rotate(angle, [0, 0, 1])arm();
        }
    }

module tab(hole_sp_all, hole_dia_all, thickness){
    hole_sp = hole_sp_all[0];
    intersection(){
        difference(){
            hull(){
                translate([0, 0, 0])cylinder(d = hole_dia_all[0], h=thickness);
                translate([hole_sp / 2 + 20, hole_sp / 2 + 13, 0])cylinder(d = hole_dia_all[0] + 4.8, h=thickness);
                translate([hole_sp / 2 + 13, hole_sp / 2  + 20, 0])cylinder(d = hole_dia_all[0] + 4.8, h=thickness);
            }
            for(i = [0:len(hole_sp_all) -1]){
               
                translate([hole_sp_all[i] / 2, hole_sp_all[i] / 2, 0])cylinder(d = hole_dia_all[i], h=thickness);
                }
        };
        
        cylinder(d=d_bracket - 0.2, h=20, center=true);
    }
}

module tabs(){
    for (i=[0:4 - 1]){
        rotate(90 * i, [0, 0, 1])tab(mnt_hole_distances, mnt_hole_dias, fc_pad_height);
        }
    }

module sidehole(){
    difference(){
        hull(){
            translate([0, d_bracket / 2 + 2.5 + 1, 0])cylinder(h=2, d=3 + 3.2);
            translate([0, d_bracket / 2 - 5 + 1, 0])cylinder(h=2, d=12 + 2.4);
            };
        translate([0, d_bracket / 2 + 2.5 + 1, 0])cylinder(h=2, d=side_holes_dia);
    }
}

module side_tab(dist, width, t1, t2, hole_y, hole_x, hole_size){
    module hull_anchor(x, y, t, d=4){
        translate([x, y, 0])cylinder(h=t, d=d);
        }
        hull(){
            hull_anchor(-width/2, d_bracket/2 + dist, t1, 3);
            hull_anchor(-width/2 , d_bracket/2, arm_height, 3);
        }
        hull(){
            hull_anchor(width/2, d_bracket/2 + dist, t1, 3);
            hull_anchor(width/2 , d_bracket/2, arm_height, 3);
        }
        difference(){
            hull(){
                hull_anchor(-width/2, d_bracket/2 + dist, t1);
                hull_anchor(width/2, d_bracket/2 + dist, t1);
                hull_anchor(-width/2 - 5, 0, t2);
                hull_anchor(width/2 + 5, 0, t2);
            }
            for (i=[0: len(hole_y) -1]) {
                translate([hole_x[i], d_bracket/2 + hole_y[i], 0])cylinder(d=hole_size[i], h=10, center=true);
            }
        }
}

module sideholes(){
    for (pos = side_holes_positions){
        rotate(pos, [0, 0, 1])sidehole();
        }
    }
    
module fuselage_outside(){
    arms(arms_positions);
    cylinder(h=bracket_height,d=d_bracket);
    sideholes();
    side_tab(6, 12, 2, 2, [4.5], [0], [2.1]);
    }
    

    
difference(){
    fuselage_outside();
    cylinder(h=30,d=d_bracket - bracket_th * 2,center=true);
    }
tabs();